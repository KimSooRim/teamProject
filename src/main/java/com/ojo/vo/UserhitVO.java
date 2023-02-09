package com.ojo.vo;

public class UserhitVO {

	private String userid;
	private String hituserid;
	private int ishit;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getHituserid() {
		return hituserid;
	}
	public void setHituserid(String hituserid) {
		this.hituserid = hituserid;
	}
	public int getIshit() {
		return ishit;
	}
	public void setIshit(int ishit) {
		this.ishit = ishit;
	}
	
	@Override
	public String toString() {
		return "UserhitVO [userid=" + userid + ", hituserid=" + hituserid + ", ishit=" + ishit + "]";
	}
	
	
	
}
