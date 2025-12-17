python3 -m sglang.bench_serving \
    --dataset-name generated-shared-prefix \
    --backend sglang --host 61.47.1.123 \
    --port 8000 \
    --max-concurrency 8 \
    --gsp-num-groups 100 \
    --gsp-prompts-per-group 2 \
    --gsp-system-prompt-len 3456 \
    --gsp-question-len 1 \
    --gsp-output-len 1

export PYTHONPATH=/home/husf/sgl/sglang/python/:$PYTHONPATH
    
python3 -m sglang.bench_serving --backend sglang --host 127.0.0.1 --port 8899 --dataset-name random-ids --num-prompts 1 --max-concurrency 1 --random-input-len 1048576 --random-output-len 1024 --random-range-ratio 1 --request-rate 1
