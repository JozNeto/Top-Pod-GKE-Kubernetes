# README
### Input Cluster Name:

### Input Region:

### Input Project Name:

After the script asks you for this information above it will show the following variable:
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION_NAME --project $PROJECT_NAME

If the connection to the K8S fails, run the command:
$ gcloud auth application-default login --no-launch-browser
or
$ gcloud auth application-default login