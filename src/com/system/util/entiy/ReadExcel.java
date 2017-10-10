package com.system.util.entiy;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.gx.book.util.UploadExcel;

public class ReadExcel {
	Map<Integer,String> map = new HashMap<Integer,String>();  
    List<Map<Integer,String>> list = new ArrayList<Map<Integer,String>>();  
    HSSFWorkbook workbook;  
//  ConnectorA a = new ConnectorA();  
                                                                                                             
    public Map<String, Object> readExcelFile(String filePath){  
    	Map<String, Object> maps= new HashMap<String, Object>();
        try {
            FileInputStream excelFile = new FileInputStream(filePath);  
            workbook = new HSSFWorkbook(excelFile);  
            //读入Excel文件的第一个表  
            HSSFSheet sheet = workbook.getSheetAt(0);  
            //从文件第二行开始读取，第一行为标识行  
            for(int i=1;i<=sheet.getLastRowNum();i++){  
                HSSFRow row = sheet.getRow(i);  
                if(row==null){  
                    continue;  
                }  
                for(int j=0;j<=row.getPhysicalNumberOfCells();j++){  
                    if(row.getCell(j)!=null){  
                        // 注意：一定要设成这个，否则可能会出现乱码  
                        String str = getCellValue(row.getCell(j));  
                        map.put(j,str);  
                    }  
                }  
                UploadExcel ue = new UploadExcel();  
                String num=ue.uploadExcel(map); 
                if(!num.equals("nnn")){
                	maps.put(i+"",num );
                }
                
                map.clear();  
            }  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
            System.out.println("【Excel路径有误，请重新确认Excel路径...】");  
        } catch (IOException e) {  
            e.printStackTrace();  
            System.out.println("【文件输入有误，请重新确定您要加入的文件...】");  
        } 
        
        return maps;
    }  
                                                                                                             
    //传入cell的值，进行cell值类型的判断，并返回String类型  
     private static String getCellValue(HSSFCell cell){  
            String value = null;  
            //简单的查检列类型  
            switch(cell.getCellType())  {  
                                                                                                                         
                case HSSFCell.CELL_TYPE_STRING://字符串  
                    value = cell.getRichStringCellValue().toString();  
                    break;  
                case HSSFCell.CELL_TYPE_NUMERIC://数字  
                    long dd = (long)cell.getNumericCellValue();  
                    value = dd+"";  
                    break;  
                case HSSFCell.CELL_TYPE_BLANK:  
                    value = "";  
                    break;     
                case HSSFCell.CELL_TYPE_FORMULA:  
                    value = String.valueOf(cell.getCellFormula());  
                    break;  
                case HSSFCell.CELL_TYPE_BOOLEAN://boolean型值  
                    value = String.valueOf(cell.getBooleanCellValue());  
                    break;  
                case HSSFCell.CELL_TYPE_ERROR:  
                    value = String.valueOf(cell.getErrorCellValue());  
                    break;  
                default:  
                    System.out.println("default");  
                    break;  
            }  
            return value;  
        }  
}
