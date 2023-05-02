<?php	
	
	
	$input_1636 = $_POST['input_1636'];
	$input_290 = $_POST['input_290'];
	$input_1788 = $_POST['input_1788'];
	$input_329 = $_POST['input_329'];
	$input_1774 = $_POST['input_1774'];
	$input_1648 = $_POST['input_1648'];
	$input_1040 = $_POST['input_1040'];
	$input_1900 = $_POST['input_1900'];
	$input_521 = $_POST['input_521'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Input_1636: $input_1636 \nInput_290: $input_290 \nInput_1788: $input_1788 \nInput_329: $input_329 \nInput_1774: $input_1774 \nInput_1648: $input_1648 \nInput_1040: $input_1040 \nInput_1900: $input_1900 \nInput_521: $input_521 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: DoNotReply@yoursite.com";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>