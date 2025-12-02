import json
import requests
import time

url = "http://141.61.29.202:18001/generate"
request_count = 100
max_new_tokens = 4

def read_questions_from_jsonl(file_path):
    questions = []
    with open(file_path, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if line:
                try:
                    data = json.loads(line)
                    if 'question' in data:
                        questions.append(data['question'])
                    else:
                        print(f"error")
                except json.JSONDecodeError as e:
                    print(f"error: {e}")

    return questions

questions = read_questions_from_jsonl('/home/husf/GSM8K-in3584-bs3000.jsonl')

def generate_requests():
    ids = []
    for i in range(request_count):
#        if i == 24 or i == 40:
#            continue
        data = {
            "text": questions[i],
            "sampling_params": {
                "temperature": 0,
                "max_new_tokens": max_new_tokens
            }
        }
        response = requests.post(url, json=data)
        print(f"req {i=} {response.json()['text']=} {response.json()['output_ids']=}")
        for id in response.json()['output_ids']:
            ids.append(id)
    return ids

first_start = time.time()
first_ids = generate_requests()


second_start = time.time()
# url = "http://61.47.1.122:12100/generate"
second_ids = generate_requests()

print(f"{first_ids=} cost {int(second_start - first_start)}s")
print(f"{second_ids=} cost {int(time.time() - second_start)}s")

if len(first_ids) != len(second_ids):
    print(f"output tokens not same, {len(first_ids)=} {len(second_ids)=}")
else:
    equal = 0
    for i in range(len(first_ids)):
        if first_ids[i] == second_ids[i]:
            equal = equal + 1

total_tokens = len(first_ids) + len(second_ids)
print(f"{total_tokens=} {equal*2=}")
