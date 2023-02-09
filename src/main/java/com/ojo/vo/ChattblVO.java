package com.ojo.vo;

public class ChattblVO {
	private int no;
	private int room;
	private String send_nick;
	private String recv_nick;
	private String send_time;
	private String read_time;
	private String content;
	private int read_chk;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public String getSend_nick() {
		return send_nick;
	}
	public void setSend_nick(String send_nick) {
		this.send_nick = send_nick;
	}
	public String getRecv_nick() {
		return recv_nick;
	}
	public void setRecv_nick(String recv_nick) {
		this.recv_nick = recv_nick;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}
	public String getRead_time() {
		return read_time;
	}
	public void setRead_time(String read_time) {
		this.read_time = read_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRead_chk() {
		return read_chk;
	}
	public void setRead_chk(int read_chk) {
		this.read_chk = read_chk;
	}
	@Override
	public String toString() {
		return "ChattblVO [no=" + no + ", room=" + room + ", send_nick=" + send_nick + ", recv_nick=" + recv_nick
				+ ", send_time=" + send_time + ", read_time=" + read_time + ", content=" + content + ", read_chk="
				+ read_chk + "]";
	}
	
	
}
