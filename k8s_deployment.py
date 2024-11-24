import os
import subprocess

base_dir = "k8s"
subdirs = ["elk stack", "wordpress", "mysql", "prometheus+grafana", "haproxy"]

def manage_yaml_files(directory, action):
    for filename in os.listdir(directory):
        if filename.endswith(".yml") or filename.endswith(".yaml"):
            filepath = os.path.join(directory, filename)
            print(f"{action.capitalize()}ing {filepath}...")
            subprocess.run(["kubectl", action, "-f", filepath], check=True)

action = input("Would you like to deploy or destroy resources? (deploy/destroy): ").strip().lower()

if action not in ["deploy", "destroy"]:
    print("Please enter 'deploy' or 'destroy'.")
else:
    for subdir in subdirs:
        full_path = os.path.join(base_dir, subdir)
        if os.path.exists(full_path) and os.path.isdir(full_path):
            print(f"\n{action.capitalize()}ing files in {full_path}...")
            manage_yaml_files(full_path, action)
        else:
            print(f"Directory {full_path} not found.")

    print(f"\n{action.capitalize()}ment complete!")
