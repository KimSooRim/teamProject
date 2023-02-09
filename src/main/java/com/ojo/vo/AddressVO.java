package com.ojo.vo;

public class AddressVO {
	
	private String gu;
	private String dong;
	private int idx;
	
//	======================= getters & setters
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
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
//	================== toString
	@Override
	public String toString() {
		return "AddressVO [gu=" + gu + ", dong=" + dong + ", idx=" + idx + "]";
	}
	
	

}
