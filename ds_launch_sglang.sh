export PYTHONPATH=/home/husf/sgl/ascend-sglang/python/:$PYTHONPATH
export MMC_LOCAL_CONFIG_PATH=/home/husf/memcache/config/mmc-local.conf
#export SGLANG_LOG_PATH=/home/husf/sgl/logs/sglang.log

rm -f $SGLANG_LOG_PATH
touch $SGLANG_LOG_PATH
pkill -9 python
python -m sglang.launch_server \
    --host 141.61.29.202 \
    --port 8000 \
    --context-length 3800 \
    --trust-remote-code \
    --attention-backend ascend \
    --device npu \
    --disable-overlap-schedule \
    --disable-cuda-graph \
    --max-running-requests 8 \
    --max-prefill-tokens 30400 \
    --chunked-prefill-size 57344 \
    --quantization w8a8_int8 \
    --model-path /data/DeepSeek-R1_w8a8/ \
    --tp-size 16 \
    --base-gpu-id 0 \
    --mem-fraction-static 0.8 \
    --log-level debug \
    --enable-hierarchical-cache \
    --hicache-ratio 2 \
    --hicache-size 0 \
    --hicache-storage-backend memcache &
