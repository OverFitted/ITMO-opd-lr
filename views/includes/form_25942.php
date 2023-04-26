<?php	
	if (empty($_POST['name5_31692_7100_20971_16004_25942']) && strlen($_POST['name5_31692_7100_20971_16004_25942']) == 0)
	{
		return false;
	}
	
	$name5_31692_7100_20971_16004_25942 = $_POST['name5_31692_7100_20971_16004_25942'];
	$undefined_25942 = $_POST['undefined_25942'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Name5_31692_7100_20971_16004_25942: $name5_31692_7100_20971_16004_25942 \nUndefined_25942: $undefined_25942 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: DoNotReply@yoursite.com";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>