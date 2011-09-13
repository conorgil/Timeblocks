jQuery(function($){ 
   // create a convenient toggleLoading function
  var toggleLoading = function() { $("#loading").toggle() };

  $("#add_timeblock")
    .bind("ajax:success", function(event, data, status, xhr) {
    	alert('success!!!! ' + xhr.responseText);
			$("#timeblocks_table_body").append(xhr.responseText);
		})
		.bind("ajax:failure", function() {
			//alert("failure!!!");
		})
		.bind("ajax:complete", function() {
			//alert("complete!!!");
		})
		.bind("ajax:error", function(xhr, status, error) {
			//alert("error!!! " + error);
		});
});
