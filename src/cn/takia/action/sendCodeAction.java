package cn.takia.action;

import cn.takia.SMS.SDKDemo;
import cn.takia.dao.BaseDao;
import cn.takia.model.User;
import com.montnets.mwgate.common.GlobalParams;
import com.montnets.mwgate.smsutil.ConfigManager;
import com.montnets.mwgate.smsutil.SmsSendConn;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class sendCodeAction extends ActionSupport {
    public void write() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        String tel = request.getParameter("tel");
        String code = request.getParameter("code");
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        boolean isExist = isExist(tel);
        if (isExist){
            out.write("1");
        }else {
            SDKDemo.sendCodeWithTel(code,tel);
            out.write("0");
        }
        out.flush();
        out.close();
    }
    public boolean isExist(String tel){
        String sql = "select * from t_user where tel=?";
        List<Object> param = new ArrayList<Object>();
        param.add(tel);
        BaseDao dao = new BaseDao();
        try {
            List<User> li = dao.getModelsWidthSqlAndParam(sql,param,new User());
            return li.size()>0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
