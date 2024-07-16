#!/bin/bash
# Description : This script deploys the openshift operators that Service Mesh depends on.  
#               This is based on the code sample from 
#               https://medium.com/@jerome_tarte/deploy-service-mesh-operators-and-control-plane-with-cli-on-openshift-container-platform-1ef6dafce080
# Author : A.J.Amabile
# Date : 15th July 2024
# Parameters:
#   TODO: Optional : names of dependent operators, in order, to be configured, if not default
#
# 
# Set up the list of dependent operators, including servicemesh, in order.
set -a deps_on
deps_on=( elasticsearch jaeger kiali servicemesh )

NAMESPACE=openshift-operators


function deploy_operator()
{
#  Arguments : 
# 1: Path to operator configuration file (.yaml)
# 2: Name of operator
    oc apply -f "$1" -n $NAMESPACE
    sleep 2
    # get the csv name
    RESOURCE=$(oc get subscription $2 -n openshift-operators -o template --template '{{.status.currentCSV}}')
    LOOP="TRUE"
    while [ $LOOP == "TRUE" ]
    do
        sleep 5
        # get the status of csv 
        RESP=$(oc get csv $RESOURCE --no-headers 2>/dev/null)
        RC=$?
        STATUS=""
        if (( ${RC} == 0 )); then
            oc get csv $RESOURCE -o template --template '{{.status.phase}}'
            RC=$?
        fi
        # Check the CSV state
        if (( $RC == 0 )) && [[ "$STATUS" == "Succeeded" ]]; then
            echo $2 "operator is deployed"
            LOOP="FALSE" 
        else
            echo "waiting for Succeeded state"
        fi 
    done
}


echo "Deploying RedHat Operator service mesh and dependencies"
echo ""

for oper in ${deps_on[@]}: do
  echo "Deploying ${oper} operator"
  if [[ -f ${oper}.yaml ]]; then
    echo "$(date) : Deploying ${oper}"
    deploy_operator ${oper}.yaml ${oper}
    echo "$(date) : Completed ${oper}"
  else
    echo "Required file ${oper}.yaml not found"
  fi
done

echo "deployment completed at $(date)"
