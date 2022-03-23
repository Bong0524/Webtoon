package com.humanwebtoon.vo;

public class CommentInfo {
	private int comm_id;
	private String writer_id;
	private String writer_name;
	private String target;
	private String comments;
	private String wrdate;
	public String getWrdate() {
		return wrdate;
	}

	public void setWrdate(String wrdate) {
		this.wrdate = wrdate;
	}

	public int getComm_id() {
		return comm_id;
	}

	public void setComm_id(int comm_id) {
		this.comm_id = comm_id;
	}

	public String getWriter_id() {
		return writer_id;
	}

	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}

	public String getWriter_name() {
		return writer_name;
	}

	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
}
