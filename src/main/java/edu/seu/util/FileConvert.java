package edu.seu.util;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

public class FileConvert {
    public FileItem createFileItem(String filePath)
    {
        FileItemFactory factory = new DiskFileItemFactory(16,null);
        String textFiledName = "textField";
        File newFile = new File(filePath);
        FileItem item = factory.createItem(textFiledName,"text/plain",true,newFile.getName());
        int bytesRead = 0;
        byte[] buffer = new byte[8192];
        try{
            FileInputStream fis = new FileInputStream(newFile);
            OutputStream os = item.getOutputStream();
            while((bytesRead = fis.read(buffer,0,8192))!= -1){
                os.write(buffer,0,bytesRead);
            }
            os.close();
            fis.close();
        }catch (IOException e)
        {
            e.printStackTrace();
        }
        return item;
    }
}
