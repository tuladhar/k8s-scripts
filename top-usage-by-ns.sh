#!/bin/bash
if [[ $1 == "cpu" ]]
then
    NAMESPACES=$(kubectl get ns -A | awk '{print $1}' | grep -v NAME)
    get_cpuusage() {
    local NAMESPACE=$1
    usage=$(kubectl top pods -n $NAMESPACE | awk '{print $2}' | grep -v CPU | tr -d 'm' | paste -sd+  | bc)
    echo "$NAMESPACE  ${usage}m"
    }
    gather_cpuusage() {
    for NAMESPACE in $NAMESPACES
    do
        get_cpuusage $NAMESPACE &
    done
    wait
    }
    echo "--- Top CPU Usage By Namespace ---"
    {
    echo "NAMESPACE CPU(cores)"
    gather_cpuusage 2>/dev/null | sort -k2 -nr
    } | column -t | head -n10
elif [[ $1 == "memory" ]]
then
    NAMESPACES=$(kubectl get ns -A | awk '{print $1}' | grep -v NAME)
    get_memusage() {
    local NAMESPACE=$1
    memusage=$(kubectl top pods -n $NAMESPACE | awk '{print $3}' | grep -v MEM | tr -d 'Mi' | paste -sd+  | bc)
    echo "$NAMESPACE  ${memusage}Mi"
    }
    gather_memusage() {
    for NAMESPACE in $NAMESPACES
    do
        get_memusage $NAMESPACE &
    done
    wait
    }
    echo "--- Top Memory Usage By Namespace ---"
    {
    echo "NAMESPACE MEMORY(bytes)"
    gather_memusage 2>/dev/null | sort -k2 -nr
    } | column -t | head -n10
else
    echo "Wrong Option!!"
fi
