package com.humanwebtoon.vo;

import java.io.File;
import java.sql.Date;

public class ToonpageInfo {
	private String page_id;
	private int page_num;
	private String toon_id;
	private String title;
	private int view_cnt;
	private Date wrdate;
	private File[] imgs;
	public File[] getImgs() {
		return imgs;
	}
	public void setImgs(File[] imgs) {
		this.imgs = imgs;
	}
	public String getPage_id() {
		return page_id;
	}
	public void setPage_id(String page_id) {
		this.page_id = page_id;
	}
	public int getPage_num() {
		return page_num;
	}
	public void setPage_num(int page_num) {
		this.page_num = page_num;
	}
	public String getToon_id() {
		return toon_id;
	}
	public void setToon_id(String toon_id) {
		this.toon_id = toon_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public Date getWrdate() {
		return wrdate;
	}
	public void setWrdate(Date wrdate) {
		this.wrdate = wrdate;
	}
}
