default: plan

plan:
	/usr/local/bin/terraform plan
apply:
	echo "yes" | /usr/local/bin/terraform apply
