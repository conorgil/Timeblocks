$(document).ready(
	function() {
		$("#add_timeblock").click(addTimeblockClickHandler);
	}
)

function addTimeblockClickHandler() {
	$.ajax({
		type:"POST",
		url:"new",
		success: function(html) {
			$("#timeblocks_list").append(html);
		},
		failure: function() {
			alert("ajax call failed");
		}
	});
	return false;
}
