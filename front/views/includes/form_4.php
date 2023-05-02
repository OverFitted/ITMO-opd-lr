<?php	
	if (empty($_POST['email4']) && strlen($_POST['email4']) == 0 || empty($_POST['email4']) && strlen($_POST['email4']) == 0)
	{
		return false;
	}
	
	$name4 = $_POST['name4'];
	$email4 = $_POST['email4'];
	$email4 = $_POST['email4'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Name4: $name4 \nEmail4: $email4 \nEmail4: $email4 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: $email4";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>