from itertools import islice

default_rows = 10
max_rows = 100

def pascals_triangle():
  row = []
  while True:
    l = len(row)
    row = [1 if i == 0 or i == l else row[i - 1] + row[i] for i in range(l + 1)]
    yield row

def handler(event, context):
  rows = int(event['rows'] or default_rows)
  clamped_rows = min(max(rows, 0), max_rows)
  return list(islice(pascals_triangle(), clamped_rows))
