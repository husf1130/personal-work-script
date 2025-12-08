export PYTHONPATH=/home/husf/sgl/sglang/python/:$PYTHONPATH
python3 -u -m sglang_router.launch_router --pd-disaggregation --host 141.61.29.202 --port 6688 --prefill http://141.61.29.202:18001 8998 --decode http://141.61.29.203:18001
