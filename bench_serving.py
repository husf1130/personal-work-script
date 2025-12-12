# 1. get_dataset中增加：
# 800行左右
    elif args.dataset_name == "gsm8k":
        input_requests = sample_gsm8k_requests(
            dataset_path=args.dataset_path,
            num_prompts=args.num_prompts,
            input_len=args.random_input_len,
            output_len=args.random_output_len,
        )

# 2. 1100行左右增加：
def sample_gsm8k_requests(
    dataset_path: str,
    num_prompts: int,
    input_len: int,
    output_len: int,
) -> List[DatasetRow]:
    dataset = []
    with open(dataset_path) as f:
        for line in f:
            data = json.loads(line.strip())
            dataset.append(data)

    random.shuffle(dataset)
    sampled_dataset = []
    for i in range(min(len(dataset), num_prompts)):
        sampled_dataset.append(
            DatasetRow(
                prompt=dataset[i]["question"],
                prompt_len=input_len,
                output_len=output_len,
            )
        )
    return sampled_dataset

# 3. --dataset-name参数增加，gsm8k
    # parser.add_argument(
    #     "--dataset-name",
    #     type=str,
    #     default="sharegpt",
    #     choices=[
    #         "sharegpt",
    #         "random",
    #         "random-ids",
    #         "generated-shared-prefix",
    #         "mmmu",
    #         "image",
    #         "mooncake",
    #         "gsm8k",
    #     ],
    #     help="Name of the dataset to benchmark on.",
    # )
