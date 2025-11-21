pkill -9 mmc_meta_s
rm -rf /home/husf/memcache/logs/*
source /usr/local/mxc/memfabric_hybrid/set_env.sh
export MMC_META_CONFIG_PATH=/home/husf/memcache/config/mmc-meta.conf
/usr/local/mxc/memfabric_hybrid/latest/aarch64-linux/bin/mmc_meta_service &
