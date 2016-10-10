package com.cd.home;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="home/")
public class HomeAction {
    
    @RequestMapping(value="home")
    public String test() {
        return "/home/home";
    }
    
    @RequestMapping(value="portlet")
    public String portlet() {
        return "/home/portlet";
    }
    
    @RequestMapping(value="uploadData")
    public String uploadData() {
        return "/home/uploadData";
    }
    
    @RequestMapping(value="uploadFile")
    public void uploadFile(@RequestParam("yssj") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
    	if(!file.isEmpty()){
    		ServletContext sc = request.getSession().getServletContext();
    		String dir = sc.getRealPath("/upload"); // 设定文件保存的目录
    		String filename = file.getOriginalFilename(); // 得到上传时的文件名
    		FileUtils.writeByteArrayToFile(new File(dir,filename), file.getBytes());
    		
    		System.out.println("upload over. "+ filename);
    	}
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
}
