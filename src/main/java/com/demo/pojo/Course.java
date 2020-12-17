package com.demo.pojo;

public class Course {
    private Integer cID;
    private String cName;
    private String cInfo;
    private Integer ctID;
    private String ctName;
    private String liveSrc;

    public Integer getcID() {
        return cID;
    }

    public void setcID(Integer cID) {
        this.cID = cID;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getcInfo() {
        return cInfo;
    }

    public void setcInfo(String cInfo) {
        this.cInfo = cInfo;
    }

    public Integer getCtID() {
        return ctID;
    }

    public void setCtID(Integer ctID) {
        this.ctID = ctID;
    }

    public String getCtName() {
        return ctName;
    }

    public void setCtName(String ctName) {
        this.ctName = ctName;
    }

    public String getLiveSrc() {
        return liveSrc;
    }

    public void setLiveSrc(String liveSrc) {
        this.liveSrc = liveSrc;
    }

    @Override
    public String toString() {
        return "Course{" +
                "cID=" + cID +
                ", cName='" + cName + '\'' +
                ", cInfo='" + cInfo + '\'' +
                ", ctID=" + ctID +
                ", ctName='" + ctName + '\'' +
                ", liveSrc='" + liveSrc + '\'' +
                '}';
    }
}
