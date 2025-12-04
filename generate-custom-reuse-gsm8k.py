import json
from transformers import AutoTokenizer

# 以BERT为例（其他模型只需替换模型名称）
tokenizer = AutoTokenizer.from_pretrained("/mnt/share/weights/GLM/glm4.6_w8a8_with_float_mtp")

batch_size = 1024
input_len = 32768
reuse_rate = 0.7
reuse_len = int(input_len * reuse_rate)
unreuse_len = input_len - reuse_len

dataset = []
dataset_path = "/home/t00882532/Qwen2-5-72B/Code/gsm8k.jsonl"
with open(dataset_path, 'r', encoding="utf-8") as f:
    for line in f:
        data = json.loads(line)
        dataset.append(data['question'])

# compute reuse tokens
reuse_tokens = []
first = dataset[0]
words = tokenizer.tokenize(first)
len_num = len(words) // reuse_len
if len_num == 0:
    multiplier = (reuse_len // len(words)) + 1
    repeated_words = words * multiplier
    reuse_tokens = repeated_words[:reuse_len]
else:
    reuse_tokens = words[:reuse_len]

# repeat input_len
dataset_2k = []
for sentence in dataset:
    words = tokenizer.tokenize(sentence)
    # print(len(words))
    len_num = len(words)
    # generate unreuse len
    if len_num < unreuse_len:
        multiplier = (unreuse_len // len_num) + 1
        repeated_unreuse = words * multiplier
        unreuse_tokens = repeated_unreuse[:unreuse_len]
    else:
        unreuse_tokens = words[:unreuse_len]

    # merge reuse and unreuse tokens
    full_tokens = reuse_tokens + unreuse_tokens
    decoded_text = tokenizer.convert_tokens_to_string(full_tokens)
    dataset_2k.append(decoded_text)

# repeat to batch_size
batch_num = len(dataset_2k) // batch_size
if batch_num == 0:
    multiplier = (batch_size // len(dataset_2k)) + 1
    repeated_batch = dataset_2k * multiplier
    dataset_2k = repeated_batch[:batch_size]
else:
    dataset_2k = dataset_2k[:batch_size]

#print(len(dataset_2k))

json_str = json.dumps(dataset_2k, ensure_ascii=False, indent=4)
with open(f'GSM8K-in{input_len}-bs{batch_size}-reuse{int(reuse_rate*100)}.jsonl', 'w', encoding='utf-8') as f:
    for i in range(len(dataset_2k)):
        f.write(json.dumps({"question": f"{dataset_2k[i]}", "answer": "none"}, ensure_ascii=False))
        f.write("\n")

