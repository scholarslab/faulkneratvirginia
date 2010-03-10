$(document).ready(function() {
	var href= window.location.href.split('#')[0];
	$('.addthis_button') .each(function(){
		$(this).attr('addthis:url', href + '#' + $(this).attr('id'));
	});
});

