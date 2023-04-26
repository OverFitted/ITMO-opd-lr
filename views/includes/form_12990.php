<?php	
	
	
	$select_544_[data_blocs_cloned_obj="true"] = $_POST['select_544_[data_blocs_cloned_obj="true"]'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from a Blocs website.";
	$email_body = "You have received a new message. \n\n".
				  "Select_544_[Data_Blocs_Cloned_Obj="True"]: $select_544_[data_blocs_cloned_obj="true"] \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\r\n";
	$headers .= "Reply-To: DoNotReply@yoursite.com";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>