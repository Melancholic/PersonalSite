$(document).ready(function(){
    //for modal with tabs
	$('.modal-toggle').click(function (e) {
		var tab = e.target.hash;
		$('li > a[href="' + tab + '"]').tab("show");
	});
});

