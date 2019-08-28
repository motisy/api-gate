package com.ruoyi.common.utils;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Objects;
import java.util.TreeMap;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiFunction;

import org.springframework.util.StringUtils;

/**
 * 自定义 JavaBean 与 Map互相转换 工具类
 * <p>Title: MapBeanUtil</p>  
 * <p>Description: </p>  
 * @author 陈阳  
 * @date 2019年8月22日
 */
public class MapBeanUtil {

    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不处理驼峰,不忽略null的值,默认类型为HashMap)
     *
     * @param javaBean 要转化的JavaBean 对象
     */
    public static <K, V> Map<K, V> beanToMap(Object javaBean) throws IntrospectionException, InvocationTargetException, IllegalAccessException, InstantiationException {
        return beanToMap(false, javaBean);
    }


    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不处理驼峰,默认类型为ConcurrentHashMap)
     *
     * @param javaBean   要转化的JavaBean 对象
     * @param ignoreNull 是否忽略值为null的属性
     */
    public static <K, V> Map<K, V> beanToMap(boolean ignoreNull, Object javaBean) throws InvocationTargetException, IntrospectionException, InstantiationException, IllegalAccessException {
        return beanToMap(ignoreNull, javaBean, null);
    }


    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不处理驼峰,不忽略null的值)
     *
     * @param javaBean 要转化的JavaBean 对象
     * @param mapClass Map的类型(只能支持Hashtable,ConcurrentHashMap,TreeMap,HashMap) 类型会决定,是否忽略空的键属性
     */
    public static <K, V> Map<K, V> beanToMap(Object javaBean, Class<? extends Map> mapClass) throws InvocationTargetException, IntrospectionException, InstantiationException, IllegalAccessException {
        return beanToMap(false, javaBean, mapClass);
    }


    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不忽略null的值,默认类型为HashMap)
     *
     * @param javaBean           要转化的JavaBean 对象
     * @param isCamelToUnderline 是否将Map的键 驼峰处理成下划线
     */
    public static <K, V> Map<K, V> beanToMap(Object javaBean, boolean isCamelToUnderline) throws InvocationTargetException, IntrospectionException, InstantiationException, IllegalAccessException {
        return beanToMap(false, javaBean, null, isCamelToUnderline);
    }

    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不忽略null的值,默认类型为HashMap)
     *
     * @param javaBean   要转化的JavaBean 对象
     * @param mapClass   Map的类型(只能支持Hashtable,ConcurrentHashMap,TreeMap,HashMap) 类型会决定,是否忽略空的键属性
     * @param ignoreNull 是否忽略值为null的属性
     */
    public static <K, V> Map<K, V> beanToMap(boolean ignoreNull, Object javaBean, Class<? extends Map> mapClass) throws InvocationTargetException, IntrospectionException, InstantiationException, IllegalAccessException {
        return beanToMap(ignoreNull, javaBean, mapClass, false);
    }


    /**
     * 将一个 JavaBean 对象转化为一个 Map(默认不忽略null的值)
     *
     * @param javaBean           要转化的JavaBean 对象
     * @param mapClass           Map的类型(只能支持Hashtable,ConcurrentHashMap,TreeMap,HashMap) 类型会决定,是否忽略空的键属性
     * @param isCamelToUnderline 是否将Map的键 驼峰处理成下划线
     */
    public static <K, V> Map<K, V> beanToMap(Object javaBean, Class<? extends Map> mapClass, boolean isCamelToUnderline) throws InvocationTargetException, IntrospectionException, InstantiationException, IllegalAccessException {
        return beanToMap(false, javaBean, mapClass, isCamelToUnderline);
    }

    /**
     * 将一个 JavaBean 对象转化为一个 Map
     *
     * @param ignoreNull         是否忽略值为null的属性
     * @param javaBean           要转化的JavaBean 对象
     * @param mapClass           Map的类型(只能支持Hashtable,ConcurrentHashMap,TreeMap,HashMap) 类型会决定,是否忽略空的键属性
     * @param isCamelToUnderline 是否将Map的键 驼峰处理成下划线
     */
    public static <K, V> Map<K, V> beanToMap(boolean ignoreNull, Object javaBean, Class<? extends Map> mapClass, boolean isCamelToUnderline) throws IllegalAccessException, InstantiationException, IntrospectionException, InvocationTargetException {
        Map<K, V> result;
        if (Objects.isNull(mapClass)) {
            if (ignoreNull) result = new ConcurrentHashMap<>();
            else result = new HashMap<>();
        } else result = (Map<K, V>) mapClass.newInstance();
        if (Objects.nonNull(javaBean)) {
            PropertyDescriptor[] propertyDescriptors = Introspector.getBeanInfo(javaBean.getClass()).getPropertyDescriptors();
            for (PropertyDescriptor desc : propertyDescriptors) {
                String prop = desc.getName();
                if (isCamelToUnderline) prop = camelToUnderline(prop);
                if (!prop.equals("class")) {
                    Method readMethod = desc.getReadMethod();
                    Object value = readMethod.invoke(javaBean);
                    if (ignoreNull) {
                        if (Objects.nonNull(value)) {
                            value = value.toString();
                            safetyMapPut(result, prop, value);
                        }
                    } else safetyMapPut(result, prop, value);
                }
            }
        }
        return result;
    }


    /**
     * 将一个Map转换成一个JavaBean(默认不识别驼峰,Map中的Key和传出来的JavaBean的属性名完全一致)
     *
     * @param map   要转的Map(包含Key,Value)
     * @param clazz 要传成的JavaBean对象(完全映射转换)
     */
    public static <T> T mapToBean(Map map, Class<T> clazz) throws IntrospectionException, IllegalAccessException, InstantiationException, InvocationTargetException {
        return mapToBean(map, clazz, false);
    }

    /**
     * 将一个Map转换成一个JavaBean
     *
     * @param map                要转的Map(包含Key,Value)
     * @param clazz              要传成的JavaBean对象
     * @param isUnderlineToCamel 是否识别Map中键的下划线(是否下划线转成驼峰再进行匹配 映射转换)
     */
    public static <T> T mapToBean(Map map, Class<T> clazz, boolean isUnderlineToCamel) throws IntrospectionException, IllegalAccessException, InstantiationException, InvocationTargetException {
        if (Objects.isNull(map)) return null;
        T result = clazz.newInstance();
        PropertyDescriptor[] propertyDescriptors = Introspector.getBeanInfo(clazz).getPropertyDescriptors();
        for (PropertyDescriptor descriptor : propertyDescriptors) {
            String prop = descriptor.getName();
            if (isUnderlineToCamel) {
                if (map.containsKey(prop) || map.containsKey(camelToUnderline(prop))) {
                    Object value = map.get(prop);
                    if (Objects.isNull(value) || "".equals(value)) value = map.get(camelToUnderline(prop));
                    Object[] args = {value};
                    descriptor.getWriteMethod().invoke(result, args);
                }
            } else {
                if (map.containsKey(prop)) {
                    Object[] args = {map.get(prop)};
                    descriptor.getWriteMethod().invoke(result, args);
                }
            }
        }
        return result;
    }

    /**
     * Map 安全设值(目前只支持Hashtable,ConcurrentHashMap,TreeMap,HashMap及其子类)
     */
    private static void safetyMapPut(Map map, Object key, Object value) {
        if ((map instanceof Hashtable || map instanceof ConcurrentHashMap)
                && Objects.nonNull(key) && Objects.nonNull(value)) map.put(key, value);
        if ((map instanceof TreeMap) && Objects.nonNull(key)) map.put(key, value);
        if (map instanceof HashMap) map.put(key, value);
    }

    /**
     * 将驼峰字符串转换成下划线 如: userId 转成 user_id
     */
    public static String camelToUnderline(String origin) {
        return stringProcess(origin, (prev, c) -> {
                    if (Character.isLowerCase(prev) && Character.isUpperCase(c)) return "" + "_" + Character.toLowerCase(c);
                    return "" + c;
                }
        );
    }

    /**
     * 将下划线转成驼峰字符串 如: user_id转成userId
     */
    public static String underlineToCamel(String origin) {
        return stringProcess(origin, (prev, c) -> {
                    if (prev == '_' && Character.isLowerCase(c)) return "" + Character.toUpperCase(c);
                    if (c == '_') return "";
                    return "" + c;
                }
        );
    }

    private static String stringProcess(String origin, BiFunction<Character, Character, String> convertFunc) {
        if (StringUtils.isEmpty(origin)) return "";
        String newOrigin = "0" + origin;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < newOrigin.length() - 1; i++) {
            char prev = newOrigin.charAt(i);
            char c = newOrigin.charAt(i + 1);
            sb.append(convertFunc.apply(prev, c));
        }
        return sb.toString();
    }
}