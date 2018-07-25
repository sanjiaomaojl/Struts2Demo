package cn.takia.model;

public class Client {

    private int cId;
    private String cName;
    private String cAddr;
    private String manager;
    private String postcode;
    private String tel;
    private int star;
    public Client(){}
    public Client(String cName, String cAddr, String manager, String postcode, String tel, int star) {
        this.cName = cName;
        this.cAddr = cAddr;
        this.manager = manager;
        this.postcode = postcode;
        this.tel = tel;
        this.star = star;
    }

    public int getcId() {
        return cId;
    }
    public void setCId(int cId) {
        this.cId = cId;
    }
    public String getcName() {
        return cName;
    }
    public void setCName(String cName) {
        this.cName = cName;
    }
    public String getcAddr() {
        return cAddr;
    }
    public void setCAddr(String cAddr) {
        this.cAddr = cAddr;
    }
    public String getManager() {
        return manager;
    }
    public void setManager(String manager) {
        this.manager = manager;
    }
    public String getPostcode() {
        return postcode;
    }
    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }
    public int getStar() {
        return star;
    }
    public void setStar(int star) {
        this.star = star;
    }

}
