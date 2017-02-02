
import java.io.*;
import java.net.*;

public class html{ 
 
 public static void main(String [] args) throws IOException
 {
 	System.out.println(getUrlSource("http://www.courses.as.pitt.edu/detail.asp?CLASSNUM=25391&TERM=2171"));
 }
 
 private static String getUrlSource(String url) throws IOException {
            URL yahoo = new URL(url);
            URLConnection yc = yahoo.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream(), "UTF-8"));
            String inputLine;
            StringBuilder a = new StringBuilder();
            while ((inputLine = in.readLine()) != null)
                a.append(inputLine+"\n");
            in.close();

            return a.toString();
        }
        
}