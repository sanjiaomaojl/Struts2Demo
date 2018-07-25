package cn.takia.action;

import cn.takia.dao.BaseDao;
import cn.takia.model.Client;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ListAction extends ActionSupport {
    public void write() throws IOException {
        //获取request对象
        HttpServletRequest request = ServletActionContext.getRequest();
        String username = request.getParameter("username");
        String manager = request.getParameter("manager");
        String tel = request.getParameter("tel");
        String star = request.getParameter("star");
        if (star == null || "".equals(star)){
            star = "0";
        }
        Client c= new Client(username,"",manager,"",tel,Integer.valueOf(star));
        //获取response对象
        HttpServletResponse resp= ServletActionContext.getResponse();
        //设置编码格式防止乱码
        resp.setContentType("text/html;charset=utf-8");
        //获取前台打印对象
        PrintWriter out= resp.getWriter();
        //往前台传递数据
        List<Client> list = getAllClientByCondition(c);
        //将list转成json对象==》json字符串
        String str = JSONArray.fromObject(list).toString();
        String jsonStr = "{\"total\":"+list.size()+",\"rows\":"+str+"}";
        //将对象转成json
        out.write(jsonStr);
        //刷新缓存并关闭输出
        out.flush();
        out.close();
    }
    //获取所有的用户信息
    public List<Client> getAllClientByCondition(Client c){
        String sql = "select * from t_client where 1=1 ";
        List<Object> param = new ArrayList<Object>();
        //name
        if(!"".equals(c.getcName()) && c.getcName() != null){
            sql+="and cname like ?";
            param.add("%"+c.getcName()+"%");
        }
        //manager
        if(!"".equals(c.getManager()) && c.getManager() != null){
            sql+="and manager=?";
            param.add(c.getManager());
        }
        //tel
        if(!"".equals(c.getTel()) && c.getTel() != null){
            sql+="and tel like ?";
            param.add("%"+c.getTel()+"%");
        }
        //star
        if(c.getStar() != 0){
            sql+="and star=?";
            param.add(c.getStar());
        }
        BaseDao dao = new BaseDao();
        try {
            List<Client> list = dao.getModelsWidthSqlAndParam(sql,param,new Client());
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
