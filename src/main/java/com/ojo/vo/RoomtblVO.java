package com.ojo.vo;

public class RoomtblVO {
	private int room;
	private String seller_nick;
	private String purchaser_nick;
	private int postnum;
	
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public String getSeller_nick() {
		return seller_nick;
	}
	public void setSeller_nick(String seller_nick) {
		this.seller_nick = seller_nick;
	}
	public String getPurchaser_nick() {
		return purchaser_nick;
	}
	public void setPurchaser_nick(String purchaser_nick) {
		this.purchaser_nick = purchaser_nick;
	}
	public int getPostnum() {
		return postnum;
	}
	public void setPostnum(int postnum) {
		this.postnum = postnum;
	}
	
	@Override
	public String toString() {
		return "RoomtblVO [room=" + room + ", seller_nick=" + seller_nick + ", purchaser_nick=" + purchaser_nick
				+ ", postnum=" + postnum + "]";
	}
	
	
	
}
