//Making changes - collin


import java.io.*;
import java.net.*;

public class html{ 
 
 public static void main(String [] args) throws IOException
 {
 	int classNum = 23550;
 	int cnt = 0;
 	while(cnt != 1000) //gets 1000 classes from the website
 	{
 		String url = getUrlSource("http://www.courses.as.pitt.edu/detail.asp?CLASSNUM="+classNum+"&TERM=2174");
 		if(!url.equals(""))
		{
			System.out.println("Class # - " + classNum);
			System.out.println(url);
		}
 		cnt++;
 		classNum++;
 	}
 }
 
 private static String getUrlSource(String url) throws IOException {
            URL yahoo = new URL(url);
            URLConnection yc = yahoo.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream(), "UTF-8"));
            String inputLine;
            StringBuilder a = new StringBuilder();
            StringBuilder temp = new StringBuilder();
            while ((inputLine = in.readLine()) != null)
            {
            
            	if(inputLine.contains("<td>2174</td>")) //to find place where we need to start parsing,
            	{												//Always change the term number to current term when updating
            		temp.append(inputLine+"\n");
            		temp.delete(0,8);
            		temp.delete(4,9);
            		a.append(temp.toString());
            		temp.setLength(0);
            		//System.out.println("In Loop\n");
            		int itemCount = 0;
            		while(itemCount < 5)
            		{
            			//THIS SCRAPS THE TERM, SUBJECT, CATALOG #, TITLE(CLASS NAME), CREDITS, GEN EDS. MET
            			temp.append(in.readLine());
            			temp.delete(0,8);
            			if(itemCount < 2)
            			{
            				int start = temp.indexOf("<");
            				int end = temp.indexOf(">");
            				temp.delete(start,end+1);
            			}
						else if(itemCount == 2)//in other words if its the course name / title
						{
							temp.delete(0,12);
            				int start = temp.indexOf("<");
            				int end = temp.indexOf(">");
            				temp.delete(start,end+1);
						}
            			else if(itemCount == 3) //credits
            			{
            				int start = temp.indexOf("<");
            				int end = temp.indexOf(">");
            				temp.delete(start,end+1);
            			}
						else //gen ed requirements that this class meets
						{
							temp.delete(0,9);
							while(temp.indexOf("&") != -1)
							{
								int _and = temp.indexOf("&");
								int _semicolon = temp.indexOf(";");
								temp.delete(_and, _semicolon+1);
								temp.append("\t");
							}
            				int start = temp.indexOf("<");
            				int end = temp.indexOf(">");
            				temp.delete(start,end+1);
						}
						
            			//temp.delete(temp.lastIndexOf(temp.toString())-5,temp.lastIndexOf(temp.toString()));
            			//inputLine.delete(0,3);
            			a.append(temp.toString() + "\n");
            			temp.setLength(0);
            			itemCount++;
            		}
            	}
				
				
            	
            	//CHECK FOR NEW INDICATOR HERE TO GATHER OTHER ITEMS 
            
            }
            
            in.close();
			
            return a.toString();
        }
        
}




/*

	DETAILS OF HOW TO STORE FILE:
	
	Term : Subject(major) : Catalog # : Title(class name) : ..... in order
	

*/