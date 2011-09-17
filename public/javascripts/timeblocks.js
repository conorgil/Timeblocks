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
    	var $updatedTimeblockRow = updateTimeblockTableRow($(this), xhr.responseText);
    	indicateResultStatus($updatedTimeblockRow, true);
		})
		.live("ajax:failure", function() {
			//alert("failure!!!");
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

function updateTimeblockTableRow($form, newRowHtml) {
	return $form.closest('tr').replaceWith(newRowHtml);
}

function updateFormInputsFromCorrespondingTimeblock($form) {
	// update start date in form with value from table
	var $startInput = $form.closest('tr').find('#start');
	$form.children('#timeblock_start').attr('value', $startInput.attr('value'));
	
	// update end date in form with value from table
	var $endInput = $form.closest('tr').find('#end');
	$form.children('#timeblock_end').attr('value', $endInput.attr('value'));

	// update tag string in form with value from table
	var $tagInput = $form.closest('tr').find('#tag_string');
	$form.children('#timeblock_tag_string').attr('value', $tagInput.attr('value'));
	
	//debugShowFormAlert($form);
}

function debugShowFormAlert($form) {
	alert('{ tag = ' + $form.children("#timeblock_tag_string").attr('value')+ ', ' +
					'start = ' + $form.children("#timeblock_start").attr('value') + ', ' +
					'end = ' + $form.children("#timeblock_end").attr('value') + ' }');
}

function indicateResultStatus($timeblockRow, isSuccessful) {
	var v = isSuccessful ? "success" : "failure";
	var $form = $timeblockRow.find('form');
	var $formTdCell = $form.parent();

	// hide the form
	$form.hide();

	// change parent table cell class to success/failure
	$formTdCell.attr('class', v);
	
	// show text
	$formTdCell.append('<p class="tempText">Successfully updated!</p>');
	
	// set back to normal
	setTimeout(function() {
		$formTdCell.children('.tempText').remove();
		$formTdCell.attr('class', '');
		$form.show();
	}, 1000);
}
