package com.ojo.vo;

public class UserbookmarkVO {

	private String userid;
	private int postnum;
	private int ismark;
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getPostnum() {
		return postnum;
	}
	public void setPostnum(int postnum) {
		this.postnum = postnum;
	}
	public int getIsmark() {
		return ismark;
	}
	public void setIsmark(int ismark) {
		this.ismark = ismark;
	}
	
	
	@Override
	public String toString() {
		return "UserbookmarkVO [userid=" + userid + ", postnum=" + postnum + ", ismark=" + ismark + "]";
	}
	
	
	
}
