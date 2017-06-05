package com.me.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class UrlExampl {
	
	  public static void main(String[] args)
	  {
	    Connection connection = null;
	    try
	    {
	      // the sql server driver string
	      Class.forName("net.sourceforge.jtds.jdbc.Driver");
	    
	      // the sql server url
	      String url = "jdbc:jtds:sqlserver://IP-0A086781:1433/maplookupdb";
	      
	      // get the sql server database connection
	      connection = DriverManager.getConnection(url,"", "");
	      
	      // now do whatever you want to do with the connection
	      // ...
	      
	    }
	    catch (ClassNotFoundException e)
	    {
	      e.printStackTrace();
	      System.exit(1);
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	      System.exit(2);
	    }
	  }
	}


