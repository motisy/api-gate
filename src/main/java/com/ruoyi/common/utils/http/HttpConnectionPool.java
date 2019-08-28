package com.ruoyi.common.utils.http;

import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.UnknownHostException;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.SSLException;
import javax.net.ssl.SSLHandshakeException;

import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.NoHttpResponseException;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.LayeredConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.protocol.HttpContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpConnectionPool {

    private static Logger logger = LoggerFactory.getLogger(HttpConnectionPool.class);

    private static final int MAX_CONN = Config.getHttpMaxPoolSize(); // 最大连接数
    private static final int Max_PRE_ROUTE = Config.getHttpMaxPoolSize();
    private static final int MAX_ROUTE = Config.getHttpMaxPoolSize();
    private CloseableHttpClient httpClient; // 发送请求的客户端单例
    private PoolingHttpClientConnectionManager manager; //连接池管理类
    private ScheduledExecutorService monitorExecutor;

    private Object syncLock = new Object(); // 相当于线程锁,用于线程安全
    
    public HttpConnectionPool(String host, int port) {
    	createHttpClient(host, port);
    }
    
    public CloseableHttpClient getHttpClient(){
    	return httpClient;
    }
    /**
     * 根据host和port构建httpclient实例
     * @param host 要访问的域名
     * @param port 要访问的端口
     * @return
     */
    private void createHttpClient(String host, int port){
    	synchronized (syncLock){
            if (httpClient == null){
            	
		    	ConnectionSocketFactory plainSocketFactory = PlainConnectionSocketFactory.getSocketFactory();
		        LayeredConnectionSocketFactory sslSocketFactory = SSLConnectionSocketFactory.getSocketFactory();
		        Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory> create().register("http", plainSocketFactory)
		                .register("https", sslSocketFactory).build();
		
		        manager = new PoolingHttpClientConnectionManager(registry);
		        //设置连接参数
		        manager.setMaxTotal(MAX_CONN); // 最大连接数
		        manager.setDefaultMaxPerRoute(Max_PRE_ROUTE); // 路由最大连接数
		
		        HttpHost httpHost = new HttpHost(host, port);
		        manager.setMaxPerRoute(new HttpRoute(httpHost), MAX_ROUTE);
		
		        //请求失败时,进行请求重试
		        HttpRequestRetryHandler handler = new HttpRequestRetryHandler() {
		            @Override
		            public boolean retryRequest(IOException e, int i, HttpContext httpContext) {
		                if (i > 3){
		                    //重试超过3次,放弃请求
		                    logger.error("retry has more than 3 time, give up request");
		                    return false;
		                }
		                if (e instanceof NoHttpResponseException){
		                    //服务器没有响应,可能是服务器断开了连接,应该重试
		                    logger.error("receive no response from server, retry");
		                    return true;
		                }
		                if (e instanceof SSLHandshakeException){
		                    // SSL握手异常
		                    logger.error("SSL hand shake exception");
		                    return false;
		                }
		                if (e instanceof InterruptedIOException){
		                    //超时
		                    logger.error("InterruptedIOException");
		                    return false;
		                }
		                if (e instanceof UnknownHostException){
		                    // 服务器不可达
		                    logger.error("server host unknown");
		                    return false;
		                }
		                if (e instanceof ConnectTimeoutException){
		                    // 连接超时
		                    logger.error("Connection Time out");
		                    return false;
		                }
		                if (e instanceof SSLException){
		                    logger.error("SSLException");
		                    return false;
		                }
		
		                HttpClientContext context = HttpClientContext.adapt(httpContext);
		                HttpRequest request = context.getRequest();
		                if (!(request instanceof HttpEntityEnclosingRequest)){
		                    //如果请求不是关闭连接的请求
		                    return true;
		                }
		                return false;
		            }
		        };
		
		        httpClient = HttpClients.custom().setConnectionManager(manager).setRetryHandler(handler).build();
		        //开启监控线程,对异常和空闲线程进行关闭
		        monitorExecutor = Executors.newScheduledThreadPool(1);
		        monitorExecutor.scheduleAtFixedRate(new TimerTask() {
		            @Override
		            public void run() {
		                //关闭异常连接
		                manager.closeExpiredConnections();
		                //关闭5s空闲的连接
		                manager.closeIdleConnections(Config.getHttpIdelTimeout(), TimeUnit.MILLISECONDS);
//		                logger.info("close expired and idle for over 5s connection");
		            }
		        }, Config.getHttpMonitorInterval(), Config.getHttpMonitorInterval(), TimeUnit.MILLISECONDS);
            }
    	}
    }
    
    /**
     * 关闭连接池
     */
    public void closeConnectionPool(){
        try {
            httpClient.close();
            manager.close();
            monitorExecutor.shutdown();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class Config{

	static int httpConnectTimeout = 3000;
	
	static int httpSocketTimeout = 3000;
	
	static int httpMaxPoolSize = 100;
	
	static int httpMonitorInterval = 5000;
	
	static int httpIdelTimeout = 2000;
	
	public static int getHttpIdelTimeout() {
	return httpIdelTimeout;
	}
	
	public static int getHttpSocketTimeout() {
	return httpSocketTimeout;
	}
	
	public static int getHttpMaxPoolSize() {
	return httpMaxPoolSize;
	}
	
	public static int getHttpMonitorInterval() {
	return httpMonitorInterval;
	}
	
	public static int getHttpConnectTimeout() {
	return httpConnectTimeout;
	}
}