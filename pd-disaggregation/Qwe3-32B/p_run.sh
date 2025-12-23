#export MMC_LOCAL_CONFIG_PATH=/usr/local/memcache_hybrid/latest/config/mmc-local.conf
export PYTHONPATH=${PWD}/sglang/python:$PYTHONPATH

#PD
export ASCEND_MF_STORE_URL="tcp://141.61.29.203:24000"

python -m sglang.launch_server \
    --model-path /data/Qwen3-32B \
    --disaggregation-mode prefill \
    --disaggregation-bootstrap-port 8998 \
    --disaggregation-transfer-backend ascend \
    --host 141.61.29.203 \
    --port 8080 \
    --trust-remote-code \
    --tp-size 2 \
    --mem-fraction-static 0.8 \
    --attention-backend ascend \
    --device npu \
    --attention-backend ascend \
    --max-running-requests 8 --context-length 3800 --chunked-prefill-size 57344 \
    --disable-cuda-graph --disable-radix-cache
