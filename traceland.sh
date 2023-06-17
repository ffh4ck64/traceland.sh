#!/bin/bash
#
#
host=$1

get_ip_addrs_cmd="traceroute -I $host | awk '{print \$3}' | tr -d '()'"
#get_place_by_ip="curl -s \"http://ipinfo.io/$ip/json\" | jq --raw-output '.country'"

readarray -t ip_addrs < <(eval $get_ip_addrs_cmd)
ip_addrs=("${ip_addrs[@]:1}")

for ip in "${ip_addrs[@]}"; do
    if [[ $ip == "*" ]]; then
        echo "*"
    else
        place=$(curl -s "http://ipinfo.io/$ip/json" | jq -r '[.country, .region, .city, .org] | join(", ")')
        echo "$ip : $place"

    fi
done

# curl -s "http://ipinfo.io/$ip/json" | jq --raw-output '.country'
