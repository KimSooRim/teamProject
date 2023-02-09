package com.ojo.vo;

import java.util.Date;

public class PosttblVO {

		
	private int postnum;
	private String userid;
	private String postcontent;
	private String title;
	private int price;
	private String postgu;
	private String postdong;
	private int istrade;
	private Date writedate;
	private String category;
	private String subway;
	
	
	public String getSubway() {
		return subway;
	}
	public void setSubway(String subway) {
		this.subway = subway;
	}
	public int getPostnum() {
		return postnum;
	}
	public void setPostnum(int postnum) {
		this.postnum = postnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPostcontent() {
		return postcontent;
	}
	public void setPostcontent(String postcontent) {
		this.postcontent = postcontent;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPostgu() {
		return postgu;
	}
	public void setPostgu(String postgu) {
		this.postgu = postgu;
	}
	public String getPostdong() {
		return postdong;
	}
	public void setPostdong(String postdong) {
		this.postdong = postdong;
	}
	public int getIstrade() {
		return istrade;
	}
	public void setIstrade(int istrade) {
		this.istrade = istrade;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "PosttblVO [postnum=" + postnum + ", userid=" + userid + ", postcontent=" + postcontent + ", title="
				+ title + ", price=" + price + ", postgu=" + postgu + ", postdong=" + postdong + ", istrade=" + istrade
				+ ", writedate=" + writedate + ", category=" + category + ", subway=" + subway + "]";
	}
	

	
	
	
	
	
	
	
	
	
}
