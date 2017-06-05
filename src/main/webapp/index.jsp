<%@page session="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="manifest" href="/manifest.json">
    <link rel="stylesheet" href="css/jquery-ui.min.css">
    <!-- <link rel="stylesheet" href="css/jquery.typeahead.css"> -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- <script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script> -->
    <!-- <script src="js/jquery.typeahead.min.js"></script> -->
    <script src="js/jquery-ui.min.js"></script>
   	
	<script>
  if ('serviceWorker' in navigator) {
    console.log("Will the service worker register?");
    navigator.serviceWorker.register('service-worker.js')
      .then(function(reg){
        console.log("Yes, it did.");
      }).catch(function(err) {
        console.log("No it didn't. This happened: ", err)
      });
  }
</script>
</head>
<body>
<h1>Hello word!</h1>
</body>
</html>