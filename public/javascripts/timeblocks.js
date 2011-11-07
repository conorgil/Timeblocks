jQuery(function($){ 
   updateMetricsTable();

  $("#add_timeblock")
    .bind("ajax:success", function(event, data, status, xhr) {
    	//alert('success!!!! ' + xhr.responseText);
			$("#timeblocks_table_body").append(xhr.responseText);
		});

	$(".timeblock_form")
    .live("ajax:success", function(event, data, status, xhr) {
    	//alert('success!!!! ' + xhr.responseText);
    	var $updatedTimeblockRow = $(xhr.responseText);
    	updateTimeblockTableRow($(this), $updatedTimeblockRow);
    	indicateResultStatus($updatedTimeblockRow, true);
    	updateMetricsTable();
		})
		.live("ajax:before", function() {
			updateFormInputsFromCorrespondingTimeblock($(this));
		});
		
	$(".destroy_timeblock_link")
    .live("ajax:success", function(event, data, status, xhr) {
    	//alert('success!!!! ' + xhr.responseText);
    	removeClosestTableRow($(this));
    	updateMetricsTable();
		});
		
	$(".remove_timeblock_row")
    .live("click", function() {
    	removeClosestTableRow($(this));
    	updateMetricsTable();
		});
		
	$(function() {
		$( ".datepicker" ).datepicker();
	});
});

function updateTimeblockTableRow($form, newRowHtml) {
	return $form.closest('tr').replaceWith(newRowHtml);
}

function updateFormInputsFromCorrespondingTimeblock($form) {
	// update start date in form with value from table
	var $startInput = $form.closest('tr').find('#start');
	$form.children('#timeblock_start').attr('value', createDateTimeFromHourMinString($startInput.attr('value')));
	
	// update end date in form with value from table
	var $endInput = $form.closest('tr').find('#end');
	$form.children('#timeblock_end').attr('value', createDateTimeFromHourMinString($endInput.attr('value')));

	// update tag string in form with value from table
	var $tagInput = $form.closest('tr').find('#tag_string');
	$form.children('#timeblock_tag_string').attr('value', $tagInput.attr('value'));
	
	// update notes in form with value from table
	var $noteInput = $form.closest('tr').find('#note');
	$form.children('#timeblock_note').attr('value', $noteInput.attr('value'));
	
	//debugShowFormAlert($form);
}

function debugShowFormAlert($form) {
	alert('{ tag = ' + $form.children("#timeblock_tag_string").attr('value')+ ', ' +
					'start = ' + $form.children("#timeblock_start").attr('value') + ', ' +
					'end = ' + $form.children("#timeblock_end").attr('value') + ' }');
}

function indicateResultStatus($timeblockRow, isSuccessful) {
	var c = isSuccessful ? "success" : "failure";
	var $form = $timeblockRow.find('form');
	var $formContainingTd = $form.closest('td');
	var $formContainingTr = $form.closest('tr');

	// hide the form
	$form.hide();

	// change parent table cell class to success/failure
	$formContainingTr.find('td').addClass(c);
	
	// show text
	$formContainingTd.append('<p class="tempText">Successfully updated!</p>');
	
	// set back to normal
	setTimeout(function() {
		$formContainingTd.children('.tempText').remove();
		$formContainingTr.find('td').removeClass(c);
		$form.show();
	}, 1000);
}

function updateMetricsTable() {
	var $timeblocksTable = $('#timeblocks_table');
	var $timeblocksRows = $timeblocksTable.find('tbody').find('tr');
	
	var metrics = [];
	$timeblocksRows.each(function() {
		var tags = $(this).find('#tag_string').val().split(',');
		var startTimeVal = $(this).find('#start').val();
		var endTimeVal = $(this).find('#end').val();
		if(endTimeVal) {			
			var durationMillis = createDateTimeFromHourMinString(endTimeVal) - createDateTimeFromHourMinString(startTimeVal);
			var durationHours = durationMillis / (1000 * 60 * 60);
			for(var i in tags) {
				var tag = tags[i];
				if(metrics[tag]) {
					metrics[tag].totalMin = metrics[tag].totalMin + durationHours;
				} else {
					metrics[tag] = {tag: tag, totalMin: durationHours };
				}
			}
		}
	});
	
	var	$metricsTableBody = $('#metrics_table').find('tbody');
	$metricsTableBody.find('tr').remove();
	
	for(var m in metrics) {
			var metric = metrics[m];
			var html = '<tr>';
			html += '<td>'+metric.tag+'</td>';
			html += '<td>'+metric.totalMin+'</td>';
			html += '</tr>';
			$metricsTableBody.append(html);
	}
}

function createDateTimeFromHourMinString(hour_min) {
	var dateShownStringArray = $("#date_shown").text().split("-");
	var dateShownYear = dateShownStringArray[0];
	var dateShownMonth = dateShownStringArray[1];
	var dateShownDay = dateShownStringArray[2];
	
	var timeEnteredStringArray = hour_min.split(":");
	var hour = timeEnteredStringArray[0];
	var min = timeEnteredStringArray[1];
	return new Date(dateShownYear, dateShownMonth-1, dateShownDay, hour, min, 0, 0);
}

function removeClosestTableRow($obj) {
	$obj.closest('tr').remove();
}






















