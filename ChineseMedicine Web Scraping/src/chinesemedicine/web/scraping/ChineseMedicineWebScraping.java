/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chinesemedicine.web.scraping;

/**
 *
 * @author shumhiutung
 */
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jsoup.*;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Set;
import org.mozilla.universalchardet.UniversalDetector;

public class ChineseMedicineWebScraping {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, IOException {

        
        
        
//        Find file encoding
        /*
        byte[] buf = new byte[40960*2];
        String fileName = "formulae.csv";
        java.io.FileInputStream fis = new java.io.FileInputStream(fileName);

// (1)
        UniversalDetector detector = new UniversalDetector(null);

// (2)
        int nread;
//        byte[] buf = null;
        while ((nread = fis.read(buf)) > 0 && !detector.isDone()) {
            detector.handleData(buf, 0, nread);
        }
// (3)
        detector.dataEnd();

// (4)
        String encoding = detector.getDetectedCharset();
        if (encoding != null) {
            System.out.println("Detected encoding = " + encoding);
        } else {
            System.out.println("No encoding detected.");
        }

// (5)
        detector.reset();
                */
        
//        Scraping Formulae DB
       /*
        try {
            // TODO code application logic here
            PrintWriter pw = new PrintWriter(new File("formulae.csv"));
            StringBuilder sb = new StringBuilder();
            int i = 1;
            String url = "http://lib-nt2.hkbu.edu.hk/database/cmed/cmfid/details.asp?lang=cht&id=F00";
            for (i = 1; i <= 182; i++) {
                
                sb = new StringBuilder();
                url = "http://lib-nt2.hkbu.edu.hk/database/cmed/cmfid/details.asp?lang=cht&id=F00";
                if (i < 10) {
                    url = url + "00" + i;
                } else if (i < 100) {
                    url = url + "0" + i;
                } else {
                    url = url + i;
                }
//                System.out.println(url);

                Document doc = Jsoup.connect(url).get();
                Element allTable = doc.select("table").get(7);

                
                sb.append(i);
                sb.append(",");
                
                String current = "";
                String last = "";
                
                for (Element tr : allTable.child(0).children()) {
                    System.out.println(tr.child(0).text());
                    current = tr.child(0).text();
                    
                    if(last.equals("【病機】") && !current.equals("【釋疑】")){
                        sb.append(",");
                    }
                    
                    if(last.equals("【運用】") && !current.equals("【附方】")){
                        sb.append(",");
                    }
                    
//                    System.out.println(tr.child(1).text());
                    String temp = tr.child(1).text().replace(",", "/");
                    sb.append(temp);
                    
                    sb.append(",");
                    last = current;
                }
                sb.setLength(sb.length() - 1);
                sb.append("\n");
//                System.out.println(sb.toString());
//                System.out.println("--------------------------------------");
                pw.write(sb.toString());

            }

            pw.close();

        } catch (IOException ex) {
            Logger.getLogger(ChineseMedicineWebScraping.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        */
        
        
        
        
        
         try {
            // TODO code application logic here
            PrintWriter pw = new PrintWriter(new File("combine.txt"));
            StringBuilder sb = new StringBuilder();
            int i = 1;
            String url = "http://lib-nt2.hkbu.edu.hk/database/cmed/cmfid/details.asp?lang=cht&id=F00";
            for (i = 1; i <= 50; i++) {
                
                sb = new StringBuilder();
                url = "http://lib-nt2.hkbu.edu.hk/database/cmed/cmfid/details.asp?lang=cht&id=F00";
                if (i < 10) {
                    url = url + "00" + i;
                } else if (i < 100) {
                    url = url + "0" + i;
                } else {
                    url = url + i;
                }


                Document doc = Jsoup.connect(url).get();
                Element allTable = doc.select("table").get(7);

                
                
                
                String current =  allTable.child(0).children().get(5).child(1).text();
                current = current.replaceAll("\\(.*?\\)", "");
                current = current.replaceAll(",", " ");
                current = current.replaceAll("，", " ");
                current = current.replaceAll("、", " ");
                current = current.replaceAll("一", "");
                current = current.replaceAll("二", "");
                current = current.replaceAll("三", "");
                current = current.replaceAll("四", "");
                current = current.replaceAll("五", "");
                current = current.replaceAll("六", "");
                current = current.replaceAll("七", "");
                current = current.replaceAll("八", "");
                current = current.replaceAll("九", "");
                current = current.replaceAll("十", "");
                current = current.replaceAll("兩", "");
                current = current.replaceAll("各", "");
                current = current.replaceAll("錢", "");
                current = current.replaceAll("至", "");
                current = current.replaceAll("片", "");
                current = current.replaceAll("分", "");
                current = current.replaceAll("個", "");
                current = current.replaceAll("斤", "");
                current = current.replaceAll("枚", "");
                current = current.replaceAll("升", "");
                current = current.replaceAll("合", "");
                current = current.replaceAll("匕", "");
                current = current.replaceAll("或", "");
                current = current.replaceAll("銼", "");
                current = current.replaceAll("炒", "");
                current = current.replaceAll("酒", "");
                current = current.replaceAll("炙", "");
                current = current.replaceAll("水", "");
                current = current.replaceAll("漬", "");
                
                current = current.replaceAll("汗", "");
                current = current.replaceAll("出", "");
                current = current.replaceAll("熬", "");
                
                current = current.replaceAll("去皮", "");
                current = current.replaceAll("去", "");
                current = current.replaceAll("半夏", "HALF夏");
                current = current.replaceAll("半", "");
                current = current.replaceAll("HALF夏", "半夏");
                
                current = current.replaceAll("  ", " ");
                current = current.replaceAll("   ", " ");
                current = current.replaceAll("    ", " ");
                current = current.replaceAll("\\d", "");
                current = current.replaceAll("g", "");
                current = current.replaceAll("米泔浸", "");
                current = current.replaceAll("身", "");
                current = current.replaceAll("切", "");
                current = current.replaceAll("包", "");
                current = current.replaceAll("捶碎", "");
                current = current.replaceAll("刷", "");
                current = current.replaceAll("火燒通赤", "");
                current = current.replaceAll("生用", "");
                        

                current = current.replaceAll(" \n", " ");
                current = current.replaceAll(" ", "\n");
                sb.append(current);

                System.out.println(current);
                
//                for (Element tr : allTable.child(0).children()) {
//                    System.out.println(tr.child(0).text());
//                    current = tr.child(0).text();
//                    
//                    if(last.equals("【病機】") && !current.equals("【釋疑】")){
//                        sb.append(",");
//                    }
//                    
//                    if(last.equals("【運用】") && !current.equals("【附方】")){
//                        sb.append(",");
//                    }
//                    
//
//                    String temp = tr.child(1).text().replace(",", "/");
//                    sb.append(temp);
//                    
//                    sb.append(",");
//                    last = current;
//                }
                
//                sb.setLength(sb.length() - 1);
//                sb.append("\n");

                pw.write(sb.toString());

            }

            pw.close();

        } catch (IOException ex) {
            Logger.getLogger(ChineseMedicineWebScraping.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        		Path path = Paths.get(System.getProperty("user.dir"))
				.resolve("combine.txt");
		
		BufferedReader reader = new BufferedReader(new FileReader(path.toFile()));
		
		Set<String> wordsOfArticle = new HashSet<>();
		
		String line = reader.readLine();
		int totalLines = 0;
		int totalWords = 0;
		
		while(line != null) {
			System.out.println("Processing line: " + line);
			
			// if there is actual content in the line...
			if(!line.trim().equals("")) {
				String [] words = line.split(" ");
				totalWords += words.length;
				
				for(String word : words) {
					String cleanedUpWord = word.toLowerCase() 
							.replace(",", "") 
							.replace(":", "") 
							.replace(".", "")
							.replace("\"", "");
					
					wordsOfArticle.add(cleanedUpWord);
				}	
			}
			totalLines++;
			line = reader.readLine();
		}
		
		System.out.println("Uniq" + " " + wordsOfArticle);
		System.out.println("--------------------------------------");
                for (String uniWord : wordsOfArticle){
                    System.out.println(uniWord);
                }
                System.out.println("--------------------------------------");
                
		System.out.println();
		System.out.println("How many unique words were in the article?");
		System.out.println(wordsOfArticle.size());
		System.out.println();
		System.out.println("Total lines:");
		System.out.println(totalLines);
		System.out.println("Total Words: ");
		System.out.println(totalWords);
        
        
        
        
        
        
        
        
    }

}
