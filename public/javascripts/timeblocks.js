jQuery(function($){ 
   // create a convenient toggleLoading function
  var toggleLoading = function() { $("#loading").toggle() };

  $("#add_timeblock")
    .bind("ajax:success", function(event, data, status, xhr) {
    	//alert('success!!!! ' + xhr.responseText);
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

	$(".timeblock_form")
    .live("ajax:success", function(event, data, status, xhr) {
    	//alert('success!!!! ' + xhr.responseText);
    	indicateResultStatus($(this), true);
		})
		.live("ajax:failure", function() {
			//alert("failure!!!");
			flashBorder($(this), false);
		})
		.live("ajax:complete", function() {
			//alert("complete!!!");
		})
		.live("ajax:error", function(xhr, status, error) {
			//alert("error!!! " + error);
		})
		.live("ajax:before", function() {
			updateFormInputsFromCorrespondingTimeblock($(this));
		});
});

function updateFormInputsFromCorrespondingTimeblock($form) {
	// update start date in form with value from table
	var $startDateInputElement = $form.parent().prev('td').prev('td').children('input');
	$form.children("#timeblock_start").attr('value', $startDateInputElement.attr('value'));
	
	// update end date in form with value from table
	var $endDateInputElement = $form.parent().prev('td').children('input');
	$form.children("#timeblock_end").attr('value', $endDateInputElement.attr('value'));
		
	//alert('{ start = ' + $form.children("#timeblock_start").attr('value') + 
	//				' end = ' + $form.children("#timeblock_start").attr('value') + ' }');
}

function indicateResultStatus($elem, isSuccessful) {
	var v = isSuccessful ? "success" : "failure";
	
	// hide the form
	$elem.hide();

	// change parent table cell class to success/failure
	$elem.parent().attr('class', v);
	
	// show text
	$elem.parent().append('<p class="tempText">Successfully updated!</p>');
	
	// set back to normal
	setTimeout(function() {
		$elem.parent().children('.tempText').remove();
		$elem.parent().attr('class', '');
		$elem.show();
	}, 1000);
}
