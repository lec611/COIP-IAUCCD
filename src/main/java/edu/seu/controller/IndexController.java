package edu.seu.controller;

import com.alibaba.fastjson.JSON;
import edu.seu.base.CodeEnum;
import edu.seu.base.CommonResponse;
import edu.seu.exceptions.IAUCCDException;
import edu.seu.model.HostHolder;
import edu.seu.model.User;
import edu.seu.service.CalculateService;
import edu.seu.model.CalculateObject;
import edu.seu.util.ProcessExcel;
import edu.seu.util.FileConvert;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: yxl
 * @Date: 2019-05-15 13:55
 */
@Controller
@RequestMapping("/main")
public class IndexController {

    private static final Logger LOGGER = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private CalculateService calculateService;

    @Autowired
    private HostHolder hostHolder;

    public void adminAuth() throws IAUCCDException
    {
        User user = hostHolder.getUser();
        if(user == null || user.getLevel() != 2)
        {
            throw new IAUCCDException(CodeEnum.USER_ERROR,"此操作需要管理员权限");
        }
    }

    @RequestMapping("/calculate")
    @ResponseBody
    public String calculate(CalculateObject calculateObject, @Param("selectValue") final String selectValue){
        try{
            HashMap<String, Object> data = calculateService.calculate(calculateObject, selectValue);
            return new CommonResponse(CodeEnum.SUCCESS.getValue(), "数据计算成功", data).toJSONString();
        }catch (IAUCCDException e){
            LOGGER.info(e.getMessage() + "parameter: calculate={}", calculateObject);
            return new CommonResponse(CodeEnum.CALCULATE_ERROR.getValue(), e.getMessage()).toJSONString();
        }catch (Exception e){
            LOGGER.error("/main/calculate" + "parameter: calculate={}", calculateObject, e);
            return new CommonResponse(CodeEnum.UNKNOWN_ERROR.getValue(), e.getMessage()).toJSONString();
        }
    }
    @RequestMapping("/calculateFile")
    @ResponseBody
    public String calculate(@Param("selectValue") final String selectValue,HttpServletRequest request){
        try{
            System.out.println(selectValue);
            ServletContext context = request.getSession().getServletContext();
            String realPath = context.getRealPath("/file/待计算文件.xlsx");
            File file = new File(realPath);
            String fileName = file.getName();
            FileItem item = new FileConvert().createFileItem(realPath);
            MultipartFile multipartFile = new CommonsMultipartFile(item);
            ProcessExcel processExcel = new ProcessExcel();
            List<CalculateObject> calculateObjects = processExcel.getExcelInfo(fileName,multipartFile);
            System.out.println(calculateObjects);
            String[] data = new String[calculateObjects.size()*3 + 1];
            data[0] = calculateObjects.size()+"";
            for(int i = 1 ; i <= calculateObjects.size(); i++)
            {
                CalculateObject calculateObject = calculateObjects.get(i-1);
                data[i] = calculateObject.getName();
                HashMap<String, Object> temp = calculateService.calculate(calculateObject, selectValue);
                data[i + calculateObjects.size()] = temp.get("degree").toString();
                data[i+calculateObjects.size() * 2] = temp.get("level").toString();
            }
            return JSON.toJSONString(data);
        }catch (IAUCCDException e)
        {
            LOGGER.info(e.getMessage() + "parameter: calculate={}");
            return new CommonResponse(CodeEnum.CALCULATE_ERROR.getValue(), e.getMessage()).toJSONString();
        }catch (Exception e)
        {
            LOGGER.error("/main/calculate" + "parameter: calculate={}", e);
            return new CommonResponse(CodeEnum.UNKNOWN_ERROR.getValue(), e.getMessage()).toJSONString();
        }

    }


    @RequestMapping("/dataGroup")
    @ResponseBody
    public String dataGroup(){
        try{
            ArrayList<CalculateObject> dataGroup = calculateService.getDataGroup();
            HashMap<String, Object> data = new HashMap<>(8);
            data.put("dataGroup", dataGroup);
            return new CommonResponse(CodeEnum.SUCCESS.getValue(), "数据组获取成功", data).toJSONString();
        }catch (Exception e){
            LOGGER.error("/main/dataGroup", e);
            return new CommonResponse(CodeEnum.UNKNOWN_ERROR.getValue(), e.getMessage()).toJSONString();
        }
    }

    @RequestMapping("templateDownload")
    @ResponseBody
    public ResponseEntity<byte[]> templateDownload(HttpServletRequest request) throws IOException
    {
        ServletContext context = request.getSession().getServletContext();
        String realPath = context.getRealPath("/file/文件输入模板.xlsx");
        File file = new File(realPath);
        if(file.exists()){
                HttpHeaders httpHeaders = new HttpHeaders();
                httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                httpHeaders.setContentDispositionFormData("attachment",URLEncoder.encode(file.getName(), "UTF-8"));
                return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),httpHeaders, HttpStatus.OK);
        }else
            return null;
    }

    @RequestMapping("templateUpload")
    @ResponseBody
    public String templateUpload(MultipartFile file,HttpServletRequest request)
    {
        try {
            //判断是否有管理员权限
          //  adminAuth();
            String filename = file.getOriginalFilename();
            System.out.println(filename);
            ServletContext context = request.getSession().getServletContext();
            String realPath = context.getRealPath("/file");
            System.out.println(realPath);
            if(!"xlsx".equals(FilenameUtils.getExtension(filename))){
                System.out.println("非Excel文件");
               return JSON.toJSONString("File is not Excel!");
            }
            File mkdir = new File(realPath);
            if(!mkdir.exists()) {
                mkdir.mkdirs();
            }

            File f = new File(realPath,"待计算文件.xlsx");
            file.transferTo(f);

//            ProcessExcel processExcel = new ProcessExcel();
//            List<CalculateObject> calculateObjects = processExcel.getExcelInfo(filename,file);
//            System.out.println(calculateObjects);
//            File mkdir = new File(realPath);
//            if(!mkdir.exists()) {
//                mkdir.mkdirs();
//            }
//
//            File f = new File(realPath,"待计算文件.xlsx");
//            file.transferTo(f);

            return JSON.toJSONString("success");
        }catch(Exception e){
            LOGGER.error(e.getMessage());
            return JSON.toJSONString("error");
        }
    }

    @RequestMapping("/updateDataGroup")
    @ResponseBody
    public String updateDataGroup(CalculateObject calculateObject)
    {
        try{
            calculateService.updateDataGroup(calculateObject);
            return new CommonResponse(CodeEnum.SUCCESS.getValue(),"更新内置数据组成功").toJSONString();
        }catch(Exception e)
        {
            LOGGER.info(e.getMessage() + "parameter: calculateObject={}", calculateObject);
            return new CommonResponse(CodeEnum.CALCULATE_ERROR.getValue(), e.getMessage()).toJSONString();
        }
    }
}
