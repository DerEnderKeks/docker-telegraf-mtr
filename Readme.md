# Telegraf Docker image with mtr

This image is derived from the [telegraf](https://hub.docker.com/_/telegraf):alpine image and additionally includes an up-to-date version of mtr (current master branch at build time).

Include the following in your config to use mtr: 

```
[[inputs.exec]]
  interval = "60s"
  commands=["mtr -C -n example.com"]
  timeout = "45s"
  data_format = "csv"
  csv_skip_rows = 1
  csv_column_names=["", "", "status", "dest", "hop", "ip", "loss", "snt", "", "", "avg", "best", "worst", "stdev"]
  name_override = "mtr"
  csv_tag_columns = ["dest", "hop", "ip"]
```