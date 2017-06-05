function initRequest() {
       if (window.XMLHttpRequest) {
           return new XMLHttpRequest();
       } else if (window.ActiveXObject) {
           isIE = true;
           return new ActiveXObject("Microsoft.XMLHTTP");
       }
   }

   function doCompletion(type) {
       if (completeField.value == "") {
           clearTable();
       } else {
           var url = "autocomplete?type=type&id=" + 
                   escape(completeField.value);
           var req = initRequest();
           req.onreadystatechange = function() {
               if (req.readyState == 4) {
                   if (req.status == 200) {
                       parseMessages(req.responseXML);
                   } else if (req.status == 204){
                       clearTable();
                   }
               }
           };
           req.open("GET", url, true);
           req.send(null);
       }
   }