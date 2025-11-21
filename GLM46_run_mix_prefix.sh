# docker exec -it sglang_perf_b150 bash
#pkill -9 python | pkill -9 sglang
#pkill -9 python | pkill -9 sglang
# cpu高性能
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sysctl -w vm.swappiness=0
sysctl -w kernel.numa_balancing=0
sysctl -w kernel.sched_migration_cost_ns=50000
# 绑核
export SGLANG_SET_CPU_AFFINITY=1
# 设置PYTHONPATH
# cd /home/t00882532/Qwen2-5-72B/Code
export PYTHONPATH=/home/t00882532/Qwen2-5-72B/Code/husf/main_qwen/python/:$PYTHONPATH
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
export HCCL_SOCKET_IFNAME=lo
export GLOO_SOCKET_IFNAME=lo
# 通信buffer
export SGLANG_DEEPEP_NUM_MAX_DISPATCH_TOKENS_PER_RANK=32
export HCCL_BUFFSIZE=1536
# model path
MODEL_PATH=/mnt/share/weights/GLM/glm4.6_w8a8_with_float_mtp

#export ENABLE_ASCEND_MOE_NZ=1
#export SGLANG_USE_MLAPO=1
export SGLANG_USE_FIA_NZ=1
#export ENABLE_PROFILING=1
#export SGLANG_DEEPEP_BF16_DISPATCH=1
export HCCL_OP_EXPANSION_MODE=AIV

python3 -m sglang.launch_server --model-path ${MODEL_PATH} \
--tp-size 16 \
--quantization w8a8_int8 \
--trust-remote-code \
--attention-backend ascend \
--device npu \
--watchdog-timeout 9000 \
--host 141.61.105.148 --port 6689 \
--mem-fraction-static 0.82 \
--dtype bfloat16 \
--chunked-prefill-size 16384 --max-prefill-tokens 65535 \
--enable-dp-attention \
--dp-size 2 \
--enable-dp-lm-head \
--cuda-graph-bs 8 \
--moe-a2a-backend deepep \
--deepep-mode auto \
--enable-hierarchical-cache \
--hicache-write-policy write_through \
--hicache-ratio 2

# --chunked-prefill-size 32768 --max-prefill-tokens 131072
#--max-running-requests 1 \
# --cuda-graph-bs 8 \
# --moe-a2a-backend deepep --deepep-mode auto \

#--disable-cuda-graph

#--speculative-algorithm NEXTN --speculative-num-steps 1 --speculative-eagle-topk 1 --speculative-num-draft-tokens 2
#--disable-overlap-schedule
# chunked-prefill-size和max-prefill-tokens都是所有dp的
#--quantization w8a8_int8 \
