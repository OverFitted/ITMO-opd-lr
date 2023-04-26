<?php	
	
	
	$select_544 = $_POST['select_544'];
	$name5_31692_46814 = $_POST['name5_31692_46814'];
	$email5_31692_46814 = $_POST['email5_31692_46814'];
	$email5_31692_46814 = $_POST['email5_31692_46814'];
	$email5_31692_46814 = $_POST['email5_31692_46814'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Select_544: $select_544 \nName5_31692_46814: $name5_31692_46814 \nEmail5_31692_46814: $email5_31692_46814 \nEmail5_31692_46814: $email5_31692_46814 \nEmail5_31692_46814: $email5_31692_46814 \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: $email5_31692_46814";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>