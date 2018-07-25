package cn.takia.action;

import cn.takia.SMS.SDKDemo;
import cn.takia.dao.BaseDao;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class addUserAction extends ActionSupport {
    public void write()throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        String username = request.getParameter("userName");
        String password = request.getParameter("passWord");
        String tel = request.getParameter("tel");
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        boolean isSuccess = addUser(username,password,tel);
        if(isSuccess)
        {
            out.write("1");
        }else{
            out.write("0");
        }
        out.flush();
        out.close();
    }

    public boolean addUser(String username,String password,String tel){
        String sql = "insert into t_user values(?,?,?)";
        List<Object> param = new ArrayList<Object>();
        param.add(username);
        param.add(password);
        param.add(tel);
        BaseDao dao = new BaseDao();
        try {
            int count = dao.executeUpdate(sql,param);
            return count>0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
