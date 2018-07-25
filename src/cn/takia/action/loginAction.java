package cn.takia.action;

import cn.takia.dao.BaseDao;
import cn.takia.model.User;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;
import java.util.List;

public class loginAction extends ActionSupport {
    private String userName;
    private String pwd;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String execute()throws Exception{
        boolean flag = isExists();
        if (flag){
            return "success";
        }
        else {
            return "error";
        }
    }

    public boolean isExists(){
        String sql = "select * from t_user where username=? and password=?";
        List<Object> param = new ArrayList<Object>();
        param.add(userName);
        param.add(pwd);
        BaseDao dao = new BaseDao();
        try {
            //返回包含多个user的列表，此时如果登陆人存在，则列表里面只有一个对象，如果不存在则列表无对象
            List<User> li = dao.getModelsWidthSqlAndParam(sql,param,new User());
            System.out.println(li);
            return li.size()>0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
