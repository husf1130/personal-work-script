import json
import requests

url = "http://141.61.105.148:6689/generate"

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

questions = read_questions_from_jsonl('/home/husf/Qwen2-5-72B/Code/GSM8K-in32768-bs1024-reuse70.jsonl')

data = {
    "text": questions[101],
    "sampling_params": {
        "temperature": 0,
        "max_new_tokens": 128
    }
}
response = requests.post(url, json=data)
print(f"RESPONSE: {response.json()}")
# print(f"req {len(questions[0])=} {response.json()['text']=} {response.json()['output_ids']=}")
