export PYTHONPATH=/home/husf/sgl/upstream_251031/python/:$PYTHONPATH
#export PYTHONPATH=/home/husf/sgl/sgl-project/sglang/python/:$PYTHONPATH
export MMC_LOCAL_CONFIG_PATH=/usr/local/mxc/memfabric_hybrid/latest/config/mmc-local.conf
export SGLANG_LOG_PATH=/home/husf/sgl/logs/sglang.log

rm -f $SGLANG_LOG_PATH
touch $SGLANG_LOG_PATH
pkill -9 python
python3 -m sglang.launch_server \
    --model-path /data/Qwen3-32B \
    --host 141.61.29.202 \
    --port 8000 \
    --trust-remote-code \
    --tp-size 2 \
    --mem-fraction-static 0.8 \
    --base-gpu-id 14 \
    --attention-backend ascend \
    --device npu \
    --disable-overlap-schedule \
    --log-level info \
    --disable-cuda-graph \
    --max-running-requests 8 \
    --context-length 3800 \
    --chunked-prefill-size 57344 \
    --max-prefill-tokens 30400 \
    --hicache-write-policy write_through \
    --hicache-ratio 5 \
    --enable-hierarchical-cache &



    #--disable-radix-cache \
