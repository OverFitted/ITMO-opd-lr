<?php	
	
	
	$name5 = $_POST['name5'];
	$email5 = $_POST['email5'];
	$email5 = $_POST['email5'];
	$email5 = $_POST['email5'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Name5: $name5 \nEmail5: $email5 \nEmail5: $email5 \nEmail5: $email5 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: $email5";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>