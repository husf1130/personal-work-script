pkill -9 mmc_meta_s
rm -rf /home/husf/memcache/logs/*
source /usr/local/mxc/memfabric_hybrid/set_env.sh
export MMC_META_CONFIG_PATH=/home/husf/memcache/config/mmc-meta.conf
/usr/local/mxc/memfabric_hybrid/latest/aarch64-linux/bin/mmc_meta_service &
[root@localhost husf]# cat run_benchmark.sh
export PYTHONPATH=/home/husf/sgl/upstream_251031/python/:$PYTHONPATH
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs200-100_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 8000 \
    --max-concurrency 8 \
    --random-output-len 1 \
    --random-input-len 3584 \
    --num-prompts 200

# /data/GSM8K-in3584-bs200.jsonl
