<?php	
	if (empty($_POST['name3']) && strlen($_POST['name3']) == 0 || empty($_POST['email3']) && strlen($_POST['email3']) == 0)
	{
		return false;
	}
	
	$name3 = $_POST['name3'];
	$email3 = $_POST['email3'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Новый вход";
	$email_body = "You have received a new message. \n\n".
				  "Name3: $name3 \nEmail3: $email3 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: $name3";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>