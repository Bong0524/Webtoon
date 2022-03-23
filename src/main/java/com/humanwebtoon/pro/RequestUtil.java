package com.humanwebtoon.pro;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;

public class RequestUtil {

	private String uploadPath;
	private ServletContext cont;
	
	/* 생성 구문*/
	public static RequestUtil create(ServletContext cont) {
		RequestUtil requestUtil = new RequestUtil();
		requestUtil.setcont(cont);
		requestUtil.setImgPath(cont.getRealPath("/img/request"));
		return requestUtil;
	}
	private void setcont(ServletContext cont) {
		this.cont = cont;
	}
	private void setImgPath(String realPath) {
		this.uploadPath = realPath;
	}
	/* 파일 저장 구문 */
	public void saveFiles(Part filePart, String folderPath, String filename) {
		String realPath = this.uploadPath + File.separator + folderPath;
		String filePath = realPath + filename;
		try(InputStream inp = filePart.getInputStream(); 
			OutputStream outp = new FileOutputStream(filePath);){
			
			byte[] buf = new byte[1024];
			int len = 0;
			while((len = inp.read(buf, 0, 1024)) != -1)
				outp.write(buf, 0, len);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*img 폴더 경로 생성 구문 */
	public String createFilePath(String writer) {
		String result = writer+"\\";
		createFolders(result);
		return result; 
	}
	
	private void createFolders(String paths) {
		
		File folders = new File(uploadPath, paths);
		
		if(!folders.exists())
			folders.mkdirs();
	}
}