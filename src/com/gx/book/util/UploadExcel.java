package com.gx.book.util;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.system.util.service.SystemService;

public class UploadExcel {
	
	public String uploadExcel(Map<Integer, String> map) {
		int num=0;
		// TODO Auto-generated method stub
		String name1=map.get(0);
		String name2=map.get(1);
		String balance1 = map.get(2);
		String balance2 = map.get(3);
		String balance3 = map.get(4);
		String time = map.get(5);
		
		if(!"".equals(name1)&&null!=name1){
			String sql = "SELECT * FROM PROJECT WHERE NAME1='"+name1+"' AND NAME2 ='"+name2+"' AND BALANCE1='"+balance1+"' AND "
					+ " BALANCE2='"+balance2+"' AND BALANCE3='"+balance3+"' AND TIME ='"+time+"';"
					+ "insert into project (`NAME1`,`NAME2`,`BAlANCE1`,`BAlANCE2`,`BAlANCE3`,`TIME`) values('"
					+ name1
					+ "','"
					+ name2
					+ "','"
					+ balance1
					+ "','"
					+ balance2
					+ "','" + balance3 + "','" + time + "')";
			return sql;
		}else{
			return "nnn";
		}
		
	}

}
