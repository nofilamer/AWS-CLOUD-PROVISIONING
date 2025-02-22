aws ec2 run-instances --key-name nofil  --security-groups cloudperf --count 1 --instance-type t2.micro --region us-east-1 --image-id ami-0e1bed4f06a3b463d --placement "AvailabilityZone=us-east-1a"  --iam-instance-profile Name=EC2 --user-data file://VOLUME_CNAME_APACHE.sh

