local model_name = "bert-base-uncased";
{
  "dataset_reader": {
    "type": "vqav2",
    #"image_dir": "/Users/dirkg/Documents/data/vision/coco",
    "image_dir": "/net/nfs.corp/allennlp/dirkg/data/vision/coco",
    #"feature_cache_dir": "/Users/dirkg/Documents/data/vision/coco/feature_cache/vqa",
    "feature_cache_dir": "/net/nfs.corp/allennlp/dirkg/data/vision/coco/feature_cache/vqa",
    "image_loader": "detectron",
    "image_featurizer": "resnet_backbone",
    "region_detector": "faster_rcnn",
    "tokenizer": {
      "type": "pretrained_transformer",
      "model_name": model_name
    },
    "token_indexers": {
      "tokens": {
        "type": "pretrained_transformer",
        "model_name": model_name
      }
    },
    #"max_instances": 10000,
    "image_processing_batch_size": 16
  },
  "train_data_path": "balanced_real_train",
  "validation_data_path": "balanced_real_val",
  "model": {
    "type": "vqa_vilbert",
    "text_embeddings": {
      "vocab_size": 30522,
      "hidden_size": 22,
      "pad_token_id": 0,
      "max_position_embeddings": 50,
      "type_vocab_size": 4,
      "dropout": 0.0
    },
    "image_embeddings": {
      "feature_dim": 2048,
      "hidden_dim": 28
    },
    "encoder": {
      "text_num_hidden_layers": 2,
      "image_num_hidden_layers": 2,
      "text_hidden_size": 22,
      "image_hidden_size": 28,
      "combined_hidden_size": 26,
      "text_intermediate_size": 5,
      "image_intermediate_size": 7,
      "num_attention_heads": 2,
      "text_attention_dropout": 0.1,
      "image_attention_dropout": 0.1,
      "text_hidden_dropout": 0.1,
      "image_hidden_dropout": 0.1,
      "activation": "gelu",
      "v_biattention_id": [0, 1, 2],
      "t_biattention_id": [0, 1, 2],
      "fixed_t_layer": 0,
      "fixed_v_layer": 0
    },
    "pooled_output_dim": 3,
    "fusion_method": "sum"
  },
  "data_loader": {
    "batch_size": 32,
    "shuffle": true,
    #"max_instances_in_memory": 1024,
  },
  "trainer": {
    "optimizer": {
      "type": "huggingface_adamw",
      "lr": 0.00005
    },
    "num_epochs": 3
  },
}