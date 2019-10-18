package edu.seu.util;

import edu.seu.model.CalculateObject;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProcessExcel {
    /**
     * 处理Excel文件
     *
     * @Author lec
     * @Date
     */
    //总行数
    private int totalRows;
    //总列数
    private int totalCells;
    //错误信息
    private String errInfo;

    //Constructor
    public ProcessExcel() {
    }

    public int getTotalRows() {
        return totalRows;
    }

    public int getTotalCells() {
        return totalCells;
    }

    public String getErrInfo() {
        return errInfo;
    }

    public boolean validateExcel(String filePath) {
        /** 检查文件名是否为空或者是否是Excel格式的文件 */
        if (filePath == null || !(CheckExcelUtil.isExcel2003(filePath) || CheckExcelUtil.isExcel2007(filePath))) {
            errInfo = "文件名不是excel格式";
            return false;
        }

        /** 检查文件是否存在 */
        File file = new File(filePath);
        if (file == null) {
            errInfo = "文件为空";
            return false;
        } else if (!file.exists()) {
            errInfo = "文件不存在";
            return false;
        }
        return true;
    }

    /**
     * 根据路径读取Excel文件
     */
    public List<CalculateObject> getExcelInfo(String fileName, MultipartFile Mfile) {
        //把spring文件上传的MultipartFile转换成CommonsMultipartFile类型
        CommonsMultipartFile cf = (CommonsMultipartFile) Mfile; //获取本地存储路径
        File file = new File("F:\\fileupload");
        //创建一个目录 （它的路径名由当前 File对象指定，包括任一必须的父路径。）
        if (!file.exists()) file.mkdirs();
        //新建一个文件
        File file1 = new File("F:\\fileupload" + new Date().getTime() + ".xlsx");
        //将上传的文件写入新建的文件中
        try {
            cf.getFileItem().write(file1);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //初始化客户信息的集合
        List<CalculateObject> calculateObjects = new ArrayList<>();
        //初始化输入流
        InputStream is = null;
        try {
            //验证文件名是否合格
            if (!validateExcel(file1.getPath())) {
                return null;
            }
            //根据文件名判断文件是2003版本还是2007版本
            boolean isExcel2003 = true;
            if (CheckExcelUtil.isExcel2007(file1.getName())) {
                isExcel2003 = false;
            }
            //根据新建的文件实例化输入流
            is = new FileInputStream(file1);
            //根据excel里面的内容读取客户信息
            calculateObjects = getExcelInfo(is, isExcel2003);
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    is = null;
                    e.printStackTrace();
                }
            }
        }
        return calculateObjects;
    }

    public List<CalculateObject> getExcelInfo(InputStream is, boolean isExcel2003) {
        List<CalculateObject> calculateObjects = null;
        try {
            /** 根据版本选择创建Workbook的方式 */
            Workbook wb = null;
            //当excel是2003时
            if (isExcel2003) {
                wb = new HSSFWorkbook(is);
            } else {//当excel是2007时
                wb = new XSSFWorkbook(is);
            }
            //读取Excel里面客户的信息
            calculateObjects = readExcelValue(wb);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return calculateObjects;
    }

    private List<CalculateObject> readExcelValue(Workbook wb) {
        List<CalculateObject> calculateObjects = new ArrayList<>();
        CalculateObject calculateObject;
        Sheet sheet = wb.getSheetAt(0);
        //得到Excel文件的行数
        this.totalRows = sheet.getPhysicalNumberOfRows();
        //System.out.println(this.totalRows);

        //得到列数，前提是有行数
        if (totalRows >= 1 && sheet.getRow(0) != null) {
            this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
        }
        /**
         * 从第二列开始循环，每次从上到下循环
         */
        for (int i = 1; i < this.getTotalCells(); i++) {
            calculateObject = new CalculateObject();
            for (int j = 0; j < this.getTotalRows(); j++) {
                Row row = sheet.getRow(j);
                if (row == null)
                    continue;
                Cell cell = row.getCell(i);
                if (cell != null) {
                    if (j == 0) {
                        calculateObject.setTotalEmployment(cell.getNumericCellValue());
                    } else if (j == 1) {
                        calculateObject.setActualOperatingIncome(cell.getNumericCellValue());
                    } else if (j == 2) {
                        calculateObject.setActualTotalEnterprises(cell.getNumericCellValue());
                    } else if (j == 3) {
                        calculateObject.setSiteArea(cell.getNumericCellValue());
                    } else if (j == 4) {
                        calculateObject.setUrbanPopulation(cell.getNumericCellValue());
                    } else if (j == 5) {
                        calculateObject.setUrbanizationRate(cell.getNumericCellValue());
                    } else if (j == 6) {
                        calculateObject.setIndustrialEmployment(cell.getNumericCellValue());
                    } else if (j == 7) {
                        calculateObject.setGdpProportion(cell.getNumericCellValue());
                    } else if (j == 8) {
                        calculateObject.setGdpPerCapita(cell.getNumericCellValue());
                    } else if (j == 9) {
                        calculateObject.setName(cell.getStringCellValue());
                    }
                }
            }
            if(0.0 != calculateObject.getActualOperatingIncome()){
               // System.out.println(calculateObject.getName());
                  calculateObjects.add(calculateObject);
            }else
                continue;

        }
       // System.out.println(calculateObjects);
        return calculateObjects;
    }
}

