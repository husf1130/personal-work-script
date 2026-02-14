# System Settings
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sysctl -w vm.swappiness=10
sysctl -w kernel.numa_balancing=0

export PYTORCH_NPU_ALLOC_CONF=expandable_segments:False
export SGLANG_SET_CPU_AFFINITY=1
export STREAMS_PER_DEVICE=32

# sglang
export PYTHONPATH=/home/husf/sgl/sglang/python:$PYTHONPATH
cd /home/husf/sgl/sglang/python

# plog
echo "" > /etc/resolv.conf
rm -rf /root/ascend/log/debug/plog/*
rm -rf /root/atb/log/*
# export ASCEND_GLOBAL_LOG_LEVEL=1
# export ASCEND_LAUNCH_BLOCKING=1

# profiling
# export ENABLE_PROFILING=1
#export MODEL_PATH=/home/zkk/Kimi-K2.5
export MODEL_PATH=/home/zkk/Kimi-K2-Thinking
export SGLANG_DEEPEP_BF16_DISPATCH=1
export SGLANG_SET_CPU_AFFINITY=1
export PYTORCH_NPU_ALLOC_CONF=expandable_segments:True
export STREAMS_PER_DEVICE=32
export HCCL_BUFFSIZE=1536
export ENABLE_ASCEND_MOE_NZ=1

ASCEND_RT_VISIBLE_DEVICES=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 python3 -m sglang.launch_server --model-path /home/zkk/Kimi-K2-Thinking/ --moe-a2a-backend deepep --deepep-mode auto --tp 16 --mem-fraction-static 0.8 --max-total-tokens 66000 --trust-remote-code --attention-backend ascend --device npu --host 127.0.0.1 --port 30112 --disable-radix-cache --context-length 8192 --chunked-prefill-size 8192 --max-prefill-tokens 8000

#python -m sglang.launch_server \
#    --model-path $MODEL_PATH \
#    --host 127.0.0.1 --port 8101 \
#    --trust-remote-code --attention-backend ascend --device npu \
#    --tp-size 4 --base-gpu-id 8 --mem-fraction-static 0.8 \
#    --model-loader-extra-config '{"enable_multithread_load": true}'

#--moe-a2a-backend deepep --deepep-mode auto

exit 1

curl --location 'http://0.0.0.0:8101/generate' --header 'Content-Type: application/json' --data '{
    "text": "The capital of france is ",
    "sampling_params": {
        "temperature": 0,
        "max_new_tokens": 10
    }
}'
