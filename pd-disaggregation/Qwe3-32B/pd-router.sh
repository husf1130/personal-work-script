export PYTHONPATH=${PWD}/sglang/python:$PYTHONPATH

python -m sglang_router.launch_router \
--pd-disaggregation \
--prefill http://141.61.29.203:8080 8998 \
--decode http://141.61.29.203:8081 \
--host 141.61.29.203 \
--port 6688 \
--policy cache_aware \

exit 0

curl --location 'http://141.61.29.203:6688/generate' --header 'Content-Type:application/json' --data '{"text": "The capital of France is", "sampling_params": {"temperature": 0, "max_new_tokens": 100}}'
