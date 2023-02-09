package com.ojo.vo;

public class UsertblVO {

	private String userid;
	private String userpw;
	private String nickname;
	private String usergu;
	private String userdong;
	private String opendate;
	private String usercontent;
	private String userprofile;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUsergu() {
		return usergu;
	}
	public void setUsergu(String usergu) {
		this.usergu = usergu;
	}
	public String getUserdong() {
		return userdong;
	}
	public void setUserdong(String userdong) {
		this.userdong = userdong;
	}
	public String getOpendate() {
		return opendate;
	}
	public void setOpendate(String opendate) {
		this.opendate = opendate;
	}
	public String getUsercontent() {
		return usercontent;
	}
	public void setUsercontent(String usercontent) {
		this.usercontent = usercontent;
	}
	public String getUserprofile() {
		return userprofile;
	}
	public void setUserprofile(String userprofile) {
		this.userprofile = userprofile;
	}
	@Override
	public String toString() {
		return "UsertblVO [userid=" + userid + ", userpw=" + userpw + ", nickname=" + nickname + ", usergu=" + usergu
				+ ", userdong=" + userdong + ", opendate=" + opendate + ", usercontent=" + usercontent
				+ ", userprofile=" + userprofile + "]";
	}

	


}
