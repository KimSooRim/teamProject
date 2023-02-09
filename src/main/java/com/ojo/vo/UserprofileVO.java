package com.ojo.vo;

public class UserprofileVO {
	
	private int idx;
	private String profileimage;
	private String filename;
	private String filerealname;
	private int filenum;
	private String userid;
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getProfileimage() {
		return profileimage;
	}
	public void setProfileimage(String profileimage) {
		this.profileimage = profileimage;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilerealname() {
		return filerealname;
	}
	public void setFilerealname(String filerealname) {
		this.filerealname = filerealname;
	}
	public int getFilenum() {
		return filenum;
	}
	public void setFilenum(int filenum) {
		this.filenum = filenum;
	}
	
	@Override
	public String toString() {
		return "UserprofileVO [idx=" + idx + ", profileimage=" + profileimage + ", filename=" + filename
				+ ", filerealname=" + filerealname + ", filenum=" + filenum + ", userid=" + userid + "]";
	}

	
}
