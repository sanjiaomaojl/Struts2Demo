package cn.takia.action;

import cn.takia.dao.BaseDao;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class addClientAction extends ActionSupport {

    public void write()throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setCharacterEncoding("utf-8");
        String cName = request.getParameter("cName");
        String cAddr = request.getParameter("cAddr");
        String manager = request.getParameter("manager");
        String postcode = request.getParameter("postcode");
        String tel = request.getParameter("tel");
        String star = request.getParameter("star");
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        boolean isSuccess = addUser(cName,cAddr,manager,postcode,tel,star);
        if(isSuccess)
        {
            out.write("1");
        }else{
            out.write("0");
        }
        out.flush();
        out.close();
    }

    public boolean addUser(String cName,String cAddr,String manager,String postcode,String tel,String star){
        String sql = "insert into t_client(cname,caddr,manager,postcode,tel,star) values(?,?,?,?,?,?)";
        List<Object> param = new ArrayList<Object>();
        param.add(cName);
        param.add(cAddr);
        param.add(manager);
        param.add(postcode);
        param.add(tel);
        param.add(star);
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
