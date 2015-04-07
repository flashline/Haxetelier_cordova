<?php	
	move_uploaded_file($_FILES["file"]["tmp_name"],$_FILES["file"]["name"]);
	echo "Saved file is ".$_FILES["file"]["name"] ; // actual shortname of saved file
?>