<?php	
	if (empty($_POST['name5_31692']) && strlen($_POST['name5_31692']) == 0 || empty($_POST['email5_31692']) && strlen($_POST['email5_31692']) == 0 || empty($_POST['email5_31692']) && strlen($_POST['email5_31692']) == 0 || empty($_POST['email5_31692']) && strlen($_POST['email5_31692']) == 0)
	{
		return false;
	}
	
	$name5_31692 = $_POST['name5_31692'];
	$email5_31692 = $_POST['email5_31692'];
	$email5_31692 = $_POST['email5_31692'];
	$email5_31692 = $_POST['email5_31692'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Name5_31692: $name5_31692 \nEmail5_31692: $email5_31692 \nEmail5_31692: $email5_31692 \nEmail5_31692: $email5_31692 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: $email5_31692";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>