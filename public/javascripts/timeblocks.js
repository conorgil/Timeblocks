$(document).ready(
	function() {
		$("#add_timeblock").click(function(e) {
			$.ajax({
				type:"POST",
				url:"new",
				success: function(html) {
					$("#timeblocks_table").append(html);
				},
				failure: function() {
					alert("ajax call failed");
				}
			});
			return false;
	  });
	}
)
