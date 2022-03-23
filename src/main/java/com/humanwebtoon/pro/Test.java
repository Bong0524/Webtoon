package com.humanwebtoon.pro;

import java.io.File;
import java.text.ParseException;

public class Test {
	public static void main(String[] args) throws ParseException {
		
			
		File f = new File("./");
		System.out.println(f.getAbsolutePath());
		File[] files = f.listFiles();
		for (int i = 0; i < files.length; i++) {
			if ( files[i].isFile() ) {
				System.out.println
				( "파일 : " + files[i].getName() );
			} else {
				System.out.println( "디렉토리명 : " + files[i].getName() );
			}
		}
		System.out.println("폴더 갯수 : " + files.length );
	}
}
