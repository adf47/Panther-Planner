import java.io.*;
import java.net.*;

public class html{
	
 static int classNum = 31235;		//last found class
 public static void main(String [] args) throws IOException
 {
 	//classNum = 10000;
 	int cnt = 0;

      

        PrintWriter writer = new PrintWriter("Courses.txt", "UTF-8"); //instanciate print writer

       	while(classNum != 40000) //gets 1000 classes from the website
       	{
			/* if(classNum == 11003 || classNum == 11004)
				classNum++;
			else
			{ */
       		String url = getUrlSource("http://www.courses.as.pitt.edu/detail.asp?CLASSNUM="+classNum+"&TERM=2174");
       		if(!url.equals("")) //make sure the webspage actually exsists
      		{
      			//System.out.println("Class # - " + classNum);
      			//System.out.println(url);

            //write to text file here
              System.out.println(classNum); //writes class number to file
              System.out.println(url); //writes all other info to file
			  writer.println(classNum); //writes class number to file
              writer.println(url); //writes all other info to file

      		}
       		cnt++;
       		classNum++;
			System.out.println(classNum);
			
       	}

        writer.close(); //close the file here
    
    /* catch(Exception e){
      System.out.println("ERROR! Exiting Program!" + e);
      System.exit(0);
    } */


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
				else if(inputLine.contains(">Description<")) //GET DESCRIPTION!!
				{
					temp.append(inputLine+"\n");
					temp.delete(0,39);
					while(temp.indexOf("<") != -1)
					{
						int start = temp.indexOf("<");
						int end = temp.indexOf(">");
						temp.delete(start,end+1);
					}
					//move to description -- deleting <> characters until description is reached
					int x = 0;
					while(x < 3)
					{
						temp.append(in.readLine());
						int start = temp.indexOf("<");
						int end = temp.indexOf(">");
						temp.delete(start,end+1);
						x++;
					}
					temp.append(in.readLine()); //this is the description
					
					a.append(temp.toString() + "\n");
					temp.setLength(0);
				}
				else if(inputLine.contains(">Prerequisite")) //GET Prerequisite(s)
				{
					temp.append(inputLine+"\n");
					temp.delete(0,55);
					
					
					temp.append(in.readLine());
					temp.append(in.readLine());
					temp.append(in.readLine());
					
						
					temp.append(in.readLine()); //prereq.
					if(temp.indexOf("&") != -1)
					{
						int _and = temp.indexOf("&");
						int y = temp.indexOf("p;");
						temp.delete(_and, y+2);
					}
					/* //remove table tag yet again!!
					while(temp.indexOf("<") != -1)
					{
						int start = temp.indexOf("<");
						int end = temp.indexOf(">");
						temp.delete(start,end+1);
					} */
					a.append(temp.toString() + "\n");
					temp.setLength(0);
				}
				else if(inputLine.contains(Integer.toString(classNum))) 	//GET to row containing classNum
				{
					
					//move to class time/room -- deleting <> characters until reached
					temp.append(inputLine);
					
					/* int start = temp.indexOf("<");
					int end = temp.indexOf(">");
					temp.delete(start,end+1); */
					
					temp.delete(0,13);
					
					temp.append(in.readLine()); 
					
					temp.append(in.readLine());
					/* while(temp.indexOf("<") != -1)
					{
						int start2 = temp.indexOf("<");
						int end2 = temp.indexOf(">");
						temp.delete(start2,end2+1);
					} */
					
					temp.delete(0,40);
					temp.append(in.readLine());
					temp.delete(0,20);
					temp.append(in.readLine());		//get to class time/room
					temp.delete(0,20);
					/* int start2 = temp.indexOf("<");
					int end2 = temp.indexOf(">");
					temp.delete(start2,end2+1); */
					
					/* int _and = temp.indexOf("&");
					int semi = temp.indexOf(";");
					temp.delete(_and, semi); */
					a.append(temp.toString() + "\n");
					temp.setLength(0);						//PLACE CLASS TIME/ROOM in TEMP
					
					//NOW GET PROFESSOR
					for(int i = 0; i<14; i++)
						in.readLine();
					temp.append(in.readLine());
					
					while(temp.indexOf("<") != -1)
					{
						int start = temp.indexOf("<");
						int end = temp.indexOf(">");
						temp.delete(start,end+1);
					} 
					
					a.append(temp.toString() + "\n");
					temp.setLength(0);
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
