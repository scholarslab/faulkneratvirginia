/*****************
Use jQuery to populate a hidden sort field with the string necessary for sorting in solr.
*****************/
$(function () {
	$('#submit_button') .click(function () {
		var sort = $('#sort') .attr('value');
		if ($('#sort') .attr('value') != 'relevance') {
			$('input[name=sort]') .attr('value', sort);
		}
		else{
			$('input[name=sort]') .removeAttr('name');
		}
	});
});