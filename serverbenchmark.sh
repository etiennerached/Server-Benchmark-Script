#!/bin/bash
# A script to benchmark your server
# 1- CPU Benchmark
# 2- Memory Benchmark
# 3- System Benchmark
# 4- Hard Disk Benchmark
# 5- Download Speed Benchmark
# Note: A total of 1GB of data will be downloaded during execution
# Written by: Etienne Rached

echo "========== CPU Info =========="
cpuname=$( awk -F: '/model name/ {modelName=$2} END {print modelName}' /proc/cpuinfo )
cpucores=$( awk -F: '/cpu cores/ {cCores=$2} END {print cCores}' /proc/cpuinfo )
cpucache=$( awk -F: '/cache size/ {cache=$2} END {print cache}' /proc/cpuinfo )
cpufreq=$( awk -F: '/cpu MHz/ {frequency=$2} END {print frequency}' /proc/cpuinfo )
echo "CPU model : $cpuname"
echo "Number of cores : $cpucores"
echo "CPU cache size : $cpucache"
echo "CPU frequency : $cpufreq MHz"
echo "======= END of CPU Info ======="

printf "\n"
echo "========== Memory Info =========="
memorysize=$(free -m | awk 'NR==2'|awk '{ print $2 }')
swapsize=$(free -m | awk 'NR==4'| awk '{ print $2 }')
echo "Total RAM : $memorysize MB"
echo "Total swap : $swapsize MB"
echo "======= END of Memory Info ======="

printf "\n"
echo "========== System Info =========="
uptime=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
echo "System uptime : $uptime"
echo "======= END of System Info ======="

printf "\n"
echo "========== Hard Disk Info =========="
echo "Now Testing I/O Speed. This might take a while..."
io=$( (dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync &&rm -f test_$$) 2>&1 | tail -1| awk '{ print $(NF-1) $NF }')
echo "I/O speed : $io"
hdds=$(df -h | awk '{if ($1 != "Filesystem") print $1 "\t" $2}')
echo "Hard Disk Space:"
echo "$hdds"
echo "======= END of Hard Disk Info ======="

printf "\n"
echo "========== Download Speed Info =========="
cachefly=$( wget -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from CDN CacheFly: $cachefly "

linodeeast=$( wget -O /dev/null http://speedtest.newark.linode.com/100MB-newark.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Linode, East, USA: $linodeeast "

linodecentrale=$( wget -O /dev/null http://speedtest.dallas.linode.com/100MB-dallas.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Linode, Central, USA: $linodecentrale "

linodewest=$( wget -O /dev/null http://speedtest.dallas.linode.com/100MB-dallas.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Linode, West, USA: $linodeeast "

hetznergermany=$( wget -O /dev/null http://speed.hetzner.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Hetzner, Germany: $hetznergermany "

ovhfrance=$( wget -O /dev/null http://ovh.net/files/100Mb.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from OVH, France: $ovhfrance "

linodeuk=$( wget -O /dev/null http://speedtest.london.linode.com/100MB-london.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Linode, UK, London: $linodeuk "

leasewebnl=$( wget -O /dev/null http://mirror.leaseweb.com/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Leaseweb, Haarlem, NL: $leasewebnl "

linodejapan=$( wget -O /dev/null http://speedtest.tokyo.linode.com/100MB-tokyo.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Linode, Tokyo, JP: $linodejapan "

softlayersingapore=$( wget -O /dev/null http://speedtest.sng01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
echo "Download speed from Softlayer, Singapore: $softlayersingapore "
echo "======= END of Download Speed Info ======="
