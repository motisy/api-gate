package com.ruoyi.project.api.apitest;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;

/**
 * 测试页面
 * <p>Title: ApiTestController</p>  
 * <p>Description: </p>  
 * @author 陈阳  
 * @date 2019年8月26日
 */
@Controller
@RequestMapping("/api/test")
public class ApiShowController extends BaseController
{
    private String prefix = "api/test";

    @Autowired
    private ApiConfig apiConfig;
    
    @GetMapping()
    public String operlog(ModelMap map)
    {
    	map.put("url1", apiConfig.getDomain()+apiConfig.getPreurl());
        return prefix + "/test";
    }
    
    @PostMapping("/fileUpload")
    @ResponseBody
    public AjaxResult uploadTest(MultipartFile file)
    {
		try {
			if(file!=null && !file.isEmpty()) {
				String p = FileUploadUtils.upload(file);
				return AjaxResult.success(p);
			}else {
				return AjaxResult.error("文件为空");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
			return AjaxResult.error();
		}
    		
    }
    
}
