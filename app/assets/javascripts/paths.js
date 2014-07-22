/* Hide off all non 1a courses initially */
$( document ).ready(function() {
	var paths1 = $("button").not(".1a, .navbar-toggle, .help");
	paths1.hide();
	$('.carousel').carousel({
    interval: false
}) 
});



$( document ).on('click', ".btn-circle",function() {
		var ci = $(".courseinfo");
		$(ci).fadeIn();	
		var course = $(this).html();
		$( "cname" ).text( course );
		var sAddr = "/course/next_courses.json?selected_courses=" + course;
		$.get(sAddr, function(r){
			console.log(r);
			console.log(course);
			var courseArray = r.next_courses;
			for(var i = 0; i < courseArray.length; i++){
				if(courseArray[i].short_form == course){
					$("#cdesc").html(courseArray[i].description);
					$("ctitle").html(courseArray[i].title);
				}
			}
		});
					
});

// $("#cdesc").append(res.next_courses);

/* toggle depending on path */
$( document ).on('dblclick',".1a",function() {
var others = $( ".1a" ).not($(this));
$( others ).fadeOut();

/* 1a courses */
if (this.id == "cs135") {
var oneB = $( ".s135" );
$( oneB ).fadeIn();

};

if (this.id == "cs115") {
var oneB = $( ".s115" );
$( oneB ).fadeIn();
};

if (this.id == "cs145") {
var oneB = $( ".s145" );
$( oneB ).fadeIn();
};

if (this.id == "phys111") {
var oneB = $( ".s111" );
$( oneB ).fadeIn();
};

if (this.id == "chem120") {
var oneB = $( ".s120" );
$( oneB ).fadeIn();
};

if (this.id == "biol130") {
var oneB = $( ".s130" );
$( oneB ).fadeIn();
};

if (this.id == "math137") {
var oneB = $( ".s137" );
$( oneB ).fadeIn();
};

if (this.id == "math135") {
var oneB = $( ".sm135" );
$( oneB ).fadeIn();
};


});

/* 2a courses */
$(document).on('dblclick', ".1b", function() {
	var others = $( ".1b" ).not($(this));
	$( others ).fadeOut();

	if (this.id == "cs136") {
		var twoA = $( ".s136" );
		$( twoA ).fadeIn();
	};

	if (this.id == "math136") {
		var twoA = $( ".sm136" );
		$( twoA ).fadeIn();
	};

	if (this.id == "stat230") {
		var twoA = $( ".s230" );
		$( twoA ).fadeIn();
	};

	if (this.id == "math138") {
		var twoA = $( ".s138" );
		$( twoA ).fadeIn();
	};

	if (this.id == "phys112") {
		var twoA = $( ".s112" );
		$( twoA ).fadeIn();
	};

	if (this.id == "chem123") {
		var twoA = $( ".s123" );
		$( twoA ).fadeIn();
	};

	if (this.id == "biol150") {
		var twoA = $( ".s150" );
		$( twoA ).fadeIn();
	};
});