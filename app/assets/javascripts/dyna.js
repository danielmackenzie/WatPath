function getBrowserWidth(){
		if (window.innerWidth){
			return window.innerWidth;}	
		else if (document.documentElement && document.documentElement.clientWidth != 0){
			return document.documentElement.clientWidth;	}
		else if (document.body){return document.body.clientWidth;}		
			return 0;
	}



function dynamicLayout(){
	var browserWidth = getBrowserWidth();
	var page = document.URL;

	if (browserWidth < 680){
		changeLayout("thin");
	}

	if ((browserWidth >= 680) && (browserWidth <= 950)){
		changeLayout("wide");
	}

	if (browserWidth > 950){
		changeLayout("wider");
	}

	if (page == "file:///C:/Users/MSI/Dropbox/Surf%20Guys/watpath/watpath.html"){
		changeLayout("wp")
	}
}



function changeLayout(nl){
   document.body.className = nl;
}

	function addEvent( obj, type, fn ){ 
	   if (obj.addEventListener){ 
	      obj.addEventListener( type, fn, false );
	   }
	   else if (obj.attachEvent){ 
	      obj["e"+type+fn] = fn; 
	      obj[type+fn] = function(){ obj["e"+type+fn]( window.event ); } 
	      obj.attachEvent( "on"+type, obj[type+fn] ); 
	   } 
	} 
	
	addEvent(window, 'load', dynamicLayout);
	addEvent(window, 'resize', dynamicLayout);