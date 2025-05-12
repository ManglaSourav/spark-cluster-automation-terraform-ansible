import json
import os

# Load Terraform output
output = json.loads(os.popen('cd ../terraform && terraform output -json').read())
# print(os.popen('cd ../terraform && terraform output -json').read())
# print(output)
public_ips = output['public_ips']['value']
private_ips = output['private_ips']['value']

# Write to Ansible inventory file
with open('../ansible/inventory.ini', 'w') as f:
    f.write("[master]\n")
    f.write(f"{public_ips[0]} private_ip={private_ips[0]}\n")

    f.write("\n[slaves]\n")
    for pub, priv in zip(public_ips[1:], private_ips[1:]):
        f.write(f"{pub} private_ip={priv}\n")
