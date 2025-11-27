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
