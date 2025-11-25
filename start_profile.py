# 启动SGLang时, 增加如下环境变量
export ENABLE_PROFILING=1
export SGLANG_TORCH_PROFILER_DIR="/home/husf/profiling"

# 单独的python脚本通知sglang 进行profiling
import os
import requests


def _start_profile(**kwargs):
    """Start profiling with optional parameters."""
    requests.post(
        f"http://141.61.39.237:8000/start_profile",
        json=kwargs if kwargs else None,
    )


if __name__ == "__main__":
    _start_profile(start_step="25", num_steps=5)
