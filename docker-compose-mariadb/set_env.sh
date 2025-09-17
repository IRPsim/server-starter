#!/bin/bash
if [ -z "$1" ]; then 
    echo "Parameter 1 fehlt - Angabe der Version fehlt."
    exit 1
else
    export build_version=$1
fi

if [ -z "$2" ]; then 
    echo "Parameter 2 fehlt - Angabe des Apache Ports fehlt."
    exit 1
else
    export apache_port=$2
fi

if [ -z "$3" ]; then
    echo "Parameter 3 fehlt - Angabe des oeffentlichen Backendports (Dokumentation)"
    exit 1
else
    export backend_port=$3
fi

if [ -z "$4" ]; then
    echo "Parameter 4 fehlt - Angabe des oeffentlichen JMX-Ports (Zugriff auf Backendprocess mit JVisualVM)"
    exit 1
else
    export backend_jmx_port=$4
fi

# ./volumes/backend-data
if [ -z "$5" ]; then 
    echo "Parameter 5 fehlt - Angabe des Backend Data Ordners fehlt."
    exit 1
else
    export backend_data_path=$5
fi

if [ -n "$6" ]; then 
    export db_password=$6
  else
    echo "Parameter 6 - Passwort fuer DB nicht gesetzt, verwende Standardpasswort."
    export db_password=Standardpasswort
fi

if [ -n "$7" ]; then
    export subnet_cidr=$7
  else
    echo "Parameter 7 - Subnetzmaske nicht gesetzt, setze Standard 10.5.0.0/24."
    export subnet_cidr="10.5.0.0/24"
fi

if [ -n "$8" ]; then 
    export mem_limit="$8"
  else
    echo "Parameter 8 - Memory limit wurde nicht gesetzt. Setze 10 GB by default."
    export mem_limit="10G"
fi

if [ -n "$9" ]; then
    export ram="$9"
    onlyRAM=${ram:4}
    echo "Memory: $mem_limit RAM: $onlyRAM"
  else
    echo "Parameter 9 - Arbeitsspeicher wurde nicht gesetzt. Setzte 3 GB."
    export ram="-Xmx3g"
fi

if [ -n "${10}" ]; then
    export parallel_jobs=${10}
  else
    echo "Parameter 10 - Parallele Jobs wurde nicht gesetzt. Setze 1."
    export parallel_jobs=1
fi

if [ -n "${11}" ]; then
    export MONITORING=${11}
  else
    echo "Parameter 11 - Aktivierung Monitoring wurde nicht gesetzt. Setze 0 (kein Monitoring)."
    export MONITORING=0
fi

cat > .environment <<EOF
export build_version=$build_version
export apache_port=$apache_port
export backend_port=$backend_port
export backend_jmx_port=$backend_jmx_port
export backend_data_path=$backend_data_path
export db_password=$db_password
export mem_limit=$mem_limit
export ram=$ram
export subnet_cidr=$subnet_cidr
export parallel_jobs=$parallel_jobs
export MONITORING=$MONITORING
export IRPSIM_DISK=/dev/sdc1
EOF

