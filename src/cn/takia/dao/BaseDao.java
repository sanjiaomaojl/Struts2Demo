package cn.takia.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class BaseDao {
	
	private static final String DRIVER="com.mysql.jdbc.Driver";
	
	private static final String URL="jdbc:mysql://localhost:3306/mydb";
	
	private static final String USER="root";
	
	
	private static final String PWD="mysql";
	
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	private void getConnection() throws Exception{
		
		if(conn==null){
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(
					URL, USER,
					PWD);
		}
		
	}
	
	public int executeUpdate(String sql,List<Object> params)throws Exception{
		getConnection();
		 pstmt= conn.prepareStatement(sql);
	    if(params!=null){
	    		for(int i=0;i<params.size();i++){
	    			pstmt.setObject(i+1, params.get(i));
	    		}
	    }
	    int count=pstmt.executeUpdate();
	    pstmt.close();
	    pstmt=null;
	    conn.close();
	    conn=null;
	    
	   return count;
	}
	
	
	 public ResultSet excuteQuery(String sql,List<Object> params)throws Exception{
			getConnection();
			 pstmt= conn.prepareStatement(sql);
		    if(params!=null){
		    		for(int i=0;i<params.size();i++){
		    			pstmt.setObject(i+1, params.get(i));
		    		}
		    }
		    rs=pstmt.executeQuery();
		    return rs;
	 }
	 
	 public <T> List<T> getModelsWidthSqlAndParam(String sql,List<Object> param,T t) throws Exception{
		 
		 List<T>  list=new ArrayList<T>();
		 Class<?> c= t.getClass();
		 
		 ResultSet rs=excuteQuery(sql, param);
		 
		 while(rs.next()){
			 
			 T obj=(T)c.newInstance();
			 Field[] fields=c.getDeclaredFields();
			 //username age pwd
			 for(Field f:fields){
				 //int   String
				 String type=f.getType().getSimpleName();
				 String fname=f.getName();
				 if(!isExists(rs, fname))continue;
				 
				 Object value=null;
				 if("string".equalsIgnoreCase(type)){
					 value=rs.getString(fname);
				 }else if("int".equalsIgnoreCase(type)){
					 value=rs.getInt(fname);
				 }else if("float".equalsIgnoreCase(type)){
					 value=rs.getFloat(fname);
				 }else if("double".equalsIgnoreCase(type)){
					 value=rs.getDouble(fname);
				 }else if("boolean".equalsIgnoreCase(type)){
					 value=rs.getBoolean(fname);
				 }else if("date".equalsIgnoreCase(type)){
					 value=rs.getDate(fname);
				 }
				 
				 fname=fname.substring(0,1).toUpperCase()+fname.substring(1);
				 String mName="set"+fname;
				 Method m= c.getDeclaredMethod(mName, f.getType());
				 m.invoke(obj, value);
				 
				  
			 }
			 list.add(obj);
		 }
		 
		 close();
		 return list;
	 }
	 

	 public boolean isExists(ResultSet rs,String colum){
	   try {
			rs.findColumn(colum);
		} catch (SQLException e) {
			return false;
		}
		 return true;
	 }
	 

	 public void close(){
		 		try {
		 			if(rs!=null){
						rs.close();
						rs=null;
				 	}
		 			if(pstmt!=null){
		 				pstmt.close();
		 				pstmt=null;
				 	}
		 			if(conn!=null){
		 				conn.close();
		 				conn=null;
				 	}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	 }
	 

		public int getSequenceIndex(String seq) throws Exception{
			String sql="select "+seq+".nextval num from dual ";
			getConnection();
			
			ResultSet rs= excuteQuery(sql, null);
			try {
				if(rs.next()){
					return rs.getInt("num");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return 0;
		}
}
