#!/bin/bash

##########################################################
# Get informations about Kubernets Pods
# Autor: JozNeto
# Data V1 Creation: 19/07/2022
##########################################################


#gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION_NAME --project $PROJECT_NAME
echo
echo "Input values for gcloud container clusters get-credentials"
echo
read -p "Input Cluster Name: " CLUSTER_NAME
read -p "Input Region: " REGION_NAME
read -p "Input Project Name: " PROJECT_NAME
echo
echo "Connecting..."
echo
sleep 3

K8S_CONNECTION=$(gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION_NAME --project $PROJECT_NAME 2> connection.log)

# Variable containing connection log informations
SUCCESS_CONNECTION=$(grep "kubeconfig entry generated for $CLUSTER_NAME" connection.log)

# Variables to check pods name running from Default NameSpace
#DEFAULT=$(kubectl get pods | grep -i Running | awk '{ print $1 }')

# Variable to check pods running from all NameSpace except default Kube-* NameSpace
#ALL_NAMESPACE=$(kubectl get namespaces | grep -i -v "kube*" | grep -i -v "Name" | awk '{print $1}')
ALL_PODS_INFO=$(kubectl top pod -A | grep -i -v "kube*")


#Confirm connection to the K8S Cluster
if [ -n "$SUCCESS_CONNECTION" ]; then
    echo 
    echo "Connected to the $CLUSTER_NAME successfully!"
    echo
    echo "RUNNING!!!"
    echo
    sleep 3
else
    echo "Failed! Please Check The Values For Get-credentials or GCP Account Auth!"
    echo
    echo "CLOSING!!!" 
    sleep 5
    exit
fi

if [ -n "$ALL_PODS_INFO" ]; then  
    echo "Looking Pods Informations from $CLUSTER_NAME K8S "
    echo
    echo "$ALL_PODS_INFO" | tee pods_info.txt
    echo
    echo "DONE. A TXT File Was Created in Script Root Path!"
    echo
else
    echo "Do Not Found Any Pods"
fi 
