# 单机混布
# cpu高性能
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sysctl -w vm.swappiness=0
sysctl -w kernel.numa_balancing=0
sysctl -w kernel.sched_migration_cost_ns=50000
# 绑核
export SGLANG_SET_CPU_AFFINITY=1
# 设置PYTHONPATH
export PYTHONPATH=/home/husf/sgl/sglang/python:$PYTHONPATH
unset https_proxy
unset http_proxy
unset HTTPS_PROXY
unset HTTP_PROXY
unset ASCEND_LAUNCH_BLOCKING
source /usr/local/Ascend/ascend-toolkit/set_env.sh
# source /home/chenxu/atb/set_env.sh
source /usr/local/Ascend/nnal/atb/set_env.sh
# 内存碎片
export PYTORCH_NPU_ALLOC_CONF=expandable_segments:True
export STREAMS_PER_DEVICE=32
# 网卡
export HCCL_SOCKET_IFNAME=enp194s0f0
export GLOO_SOCKET_IFNAME=enp194s0f0
# 通信buffer
export SGLANG_DEEPEP_NUM_MAX_DISPATCH_TOKENS_PER_RANK=32
export HCCL_BUFFSIZE=1600
# mtp quant path
#MODEL_PATH=/home/weights/DeepSeek-R1_w8a8
MODEL_PATH=/data/DeepSeek-R1_w8a8

export DEEP_NORMAL_MODE_USE_INT8_QUANT=1
export SGLANG_NPU_USE_MLAPO=1
export SGLANG_ENABLE_SPEC_V2=1
export SGLANG_ENABLE_OVERLAP_PLAN_STREAM=1

export SGLANG_USE_FIA_NZ=1
export ENABLE_MOE_NZ=1
#export ENABLE_PROFILING=1
#export SGLANG_DEBUG_MEMORY_POOL=1
#export ASCEND_MF_LOG_LEVEL=0
export ASCEND_MF_STORE_URL="tcp://141.61.29.202:24668"
export MMC_LOCAL_CONFIG_PATH=/home/husf/memcache/config/mmc-local.conf
#export ASCEND_MF_TRANSFER_PROTOCOL="device_rdma"
python3 -m sglang.launch_server --model-path ${MODEL_PATH} \
--tp 16 \
--trust-remote-code \
--disaggregation-mode prefill \
--disaggregation-bootstrap-port 8998 \
--attention-backend ascend \
--disaggregation-transfer-backend ascend \
--device npu \
--quantization w8a8_int8 \
--host 141.61.29.202 --port 18001 \
--cuda-graph-bs 16 \
--mem-fraction-static 0.8 \
--max-running-requests 16 \
--context-length 9260 \
--chunked-prefill-size -1 --max-prefill-tokens 16384 \
--enable-hierarchical-cache --hicache-storage-backend memcache \
--dtype bfloat16

#--disable-radix-cache
#--enable-hierarchical-cache --hicache-storage-backend memcache \
#--dp-size 2 --enable-dp-attention \
#--moe-a2a-backend deepep --deepep-mode auto \
#--speculative-algorithm NEXTN --speculative-num-steps 1 --speculative-eagle-topk 1 --speculative-num-draft-tokens 2 \
#--moe-a2a-backend deepep --enable-dp-attention --deepep-mode low_latency --enable-dp-lm-head --dp 2 \
#--enable-beta-spec \

#--disable-cuda-graph
exit 1

curl --location 'http://127.0.0.1:6699/generate' --header 'Content-Type: application/json' --data '{
    "text": "The capital of France is",
    "sampling_params": {
        "temperature": 0,
        "max_new_tokens": 200
    }
}'

python3 -m sglang.bench_serving --dataset-path ${PWD}/test.jsonl --dataset-name gsm8k --backend sglang --host 127.0.0.1 --port 6699 --max-concurrency 96 --random-output-len 1500 --random-input-len 3500 --num-prompts 384
