default: fmt plan

fmt:
	/usr/local/bin/terraform fmt
plan:
	/usr/local/bin/terraform plan
apply:
	echo "yes" | /usr/local/bin/terraform apply
