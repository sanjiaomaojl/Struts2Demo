package cn.takia.action;

import cn.takia.dao.BaseDao;
import cn.takia.model.User;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class CheckUserAction extends ActionSupport {
    public void write() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        String username = request.getParameter("userName");
        boolean isExist = isExists(username);
        //将结果返回给ajax
        HttpServletResponse resp = ServletActionContext.getResponse();
        //防止乱码
        resp.setContentType("text/html;charset=utf-8");
        //获取前台对象
        PrintWriter out = resp.getWriter();
        if (isExist){
            out.write("1");
        }else {
            out.write("0");
        }
        out.flush();
        out.close();
    }
    public boolean isExists(String userName){
        String sql = "select * from t_user where username=?";
        List<Object> param = new ArrayList<Object>();
        param.add(userName);
        BaseDao dao = new BaseDao();
        try {
            //返回包含多个user的列表，此时如果登陆人存在，则列表里面只有一个对象，如果不存在则列表无对象
            List<User> li = dao.getModelsWidthSqlAndParam(sql,param,new User());
            return li.size()>0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
