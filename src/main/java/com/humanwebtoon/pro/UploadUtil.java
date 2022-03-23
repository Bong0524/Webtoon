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

public class UploadUtil {

	private String uploadPath;
	private ServletContext cont;
	
	/* 생성 구문*/
	public static UploadUtil create(ServletContext cont) {
		UploadUtil uploadUtil = new UploadUtil();
		uploadUtil.setcont(cont);
		uploadUtil.setImgPath(cont.getRealPath("/img"));
		return uploadUtil;
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
	public String createFilePath(String toon_id,String page) {
		String result = toon_id+"\\"+page+"\\";
		createFolders(result);
		return result; 
	}
	public String createFilePath(String toon_id) {
		String result = toon_id+"\\";
		createFolders(result);
		return result; 
	}
	
	private void createFolders(String paths) {
		
		File folders = new File(uploadPath, paths);
		
		if(!folders.exists())
			folders.mkdirs();
	}
}