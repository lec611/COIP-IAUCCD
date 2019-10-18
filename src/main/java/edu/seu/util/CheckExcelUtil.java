package edu.seu.util;

public class CheckExcelUtil {
    /**
     * 检查是否是2003的excel，若是，则返回true
     */
    public static boolean isExcel2003(String filePath) {
        return filePath.matches("^.+\\.(?i)(xls)$");
    }

    /**
     * 检查是否是2007的excel，若是，则返回true
     */
    public static boolean isExcel2007(String filePath) {
        return filePath.matches("^.+\\.(?i)(xlsx)$");
    }
}
