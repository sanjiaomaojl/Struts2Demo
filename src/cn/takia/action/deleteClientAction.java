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

public class deleteClientAction extends ActionSupport {
    public void write()throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();

        String Ids = request.getParameter("str");
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        boolean isSuccess = deleteClient(Ids);
        if(isSuccess)
        {
            out.write("1");
        }else{
            out.write("0");
        }
        out.flush();
        out.close();
    }

    public boolean deleteClient(String Ids){
        String isd = Ids.substring(0,Ids.length()-1);
        String sql = "delete from  t_client where cid in("+isd+")";
        BaseDao dao = new BaseDao();
        try {
            int count = dao.executeUpdate(sql,null);
            return count>0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
