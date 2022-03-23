package com.humanwebtoon.vo;

import java.io.File;

public class RequestInfo {
	private String writer;
	private String title;
	private String subTitle;
	private String wrdate;
	private String info;
	private File[] imgs;
	
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public File[] getImgs() {
		return imgs;
	}
	public void setImgs(File[] imgs) {
		this.imgs = imgs;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWrdate() {
		return wrdate;
	}
	public void setWrdate(String wrdate) {
		this.wrdate = wrdate;
	}
}
