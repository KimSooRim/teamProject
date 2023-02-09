package com.ojo.vo;

public class DongtblVO {
	private String gu;
	private String dong;
	
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	@Override
	public String toString() {
		return "DongtblVO [gu=" + gu + ", dong=" + dong + "]";
	}
}
