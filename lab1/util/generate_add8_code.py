
for i in range(8):
    print(f'assign sum[{i}] = a[{i}] ^ b[{i}]] ^ carry[{i}];')
    print(f'assign carry[{i+1}] = a[{i}] && b[{i}] || a[{i}] && carry[{i}] || b[{i}] && carry[{i}];')
