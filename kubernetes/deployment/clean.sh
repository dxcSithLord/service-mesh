#!/bin/bash

NAMESPACE=openshift-operators

function clean
{
    echo "removing" $1 "operator"
    RESOURCE=$(oc get subscription $1 -n openshift-operators -o template --template '{{.status.currentCSV}}')
    if [ "$RESOURCE" != "<no value>" ]
    then 
        oc delete subscription $1 -n $NAMESPACE
        sleep 1
        oc delete clusterserviceversion $RESOURCE -n $NAMESPACE
        echo $1 "operator is removed from environment"
    fi
    sleep 5
}

echo "Service mesh operators cleaning"

clean servicemesh
echo""

clean kiali
echo""

clean jaeger
echo""

clean elasticsearch
echo""

echo "cleaning terminated"


