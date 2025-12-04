export PYTHONPATH=/home/husf/sgl/sglang/python/:$PYTHONPATH

echo "=========================================================================================================================="
echo "start to send req to sglang server 1: "
curl --location 'http://141.61.29.202:18001/flush_cache' --header 'Content-Type: application/json'
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs144-72_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 72 \
    --request-rate 4 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 144

curl --location 'http://141.61.29.202:18001/flush_cache' --header 'Content-Type: application/json'
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs144-72_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 72 \
    --request-rate 4 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 144
curl --location 'http://141.61.29.202:18001/flush_cache' --header 'Content-Type: application/json'
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs144-72_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 72 \
    --request-rate 4 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 144
curl --location 'http://141.61.29.202:18001/flush_cache' --header 'Content-Type: application/json'
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs144-72_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 72 \
    --request-rate 5 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 144
curl --location 'http://141.61.29.202:18001/flush_cache' --header 'Content-Type: application/json'
python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs144-72_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 72 \
    --request-rate 6 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 144

exit 0
sleep 5
echo "=========================================================================================================================="
echo "start to send req to sglang server 2: "

python3 -m sglang.bench_serving \
    --dataset-path /home/husf/GSM8K-in3584-bs200-100_2.jsonl \
    --dataset-name gsm8k \
    --backend sglang \
    --host 141.61.29.202 \
    --port 18001 \
    --warmup-requests 0 \
    --max-concurrency 32 \
    --random-output-len 1536 \
    --random-input-len 3584 \
    --num-prompts 200
