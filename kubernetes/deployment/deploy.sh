# !/Bin/bash

NAMESPACE=openshift-operators

function deploy_operator()
{
    oc apply -f $1 -n $NAMESPACE

    sleep 2
    # get the csv name
    RESOURCE=$(oc get subscription $2 -n openshift-operators -o template --template '{{.status.currentCSV}}')
    LOOP="TRUE"
    while [ $LOOP == "TRUE" ]
    do
        sleep 5
        # get the status of csv 
        RESP=$(oc get csv $RESOURCE --no-headers 2>/dev/null)
        RC=$(echo $?)
        STATUS=""
        if [ "$RC" -eq 0 ]
        then
            STATUS=$(oc get csv $RESOURCE -o template --template '{{.status.phase}}')
            RC=$(echo $?)
        fi
        # Check the CSV state
        if [ "$RC" -eq 0 ] && [ "$STATUS" == "Succeeded" ]
        then
            echo $2 "operator is deployed"
            LOOP="FALSE" 
        else
            echo "waiting for Succeeded state"
        fi 
    done
}


echo "Deploying RH service mesh"
echo ""

echo "Deploying elasticsearch operator"
deploy_operator elasticsearch.yaml elasticsearch
echo ""

echo "Deploying jaeger operator"
deploy_operator jaeger.yaml jaeger
echo ""

echo "Deploying kiali operator"
deploy_operator kiali.yaml kiali
echo ""

echo "Deploying service mesh operator"
deploy_operator servicemesh.yaml servicemesh
echo ""

echo "deployment completed"
