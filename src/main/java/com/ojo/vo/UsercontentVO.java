package com.ojo.vo;

public class UsercontentVO {

	private int idx;
	private String content;
	
	
	
	
	public int getIdx() {
		return idx;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	@Override
	public String toString() {
		return "UsercontentVO [idx=" + idx + ", content=" + content + "]";
	}

	

	

	
}
