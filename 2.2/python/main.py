
ids = set()
with open('./../input.txt', 'r') as f:
    for line in f:
        ids.add(line.rstrip())

like_ids = []
for first_id in ids:
    found = False
    for other_id in ids:
        diff_count = 0
        for i in range(0, len(first_id)):
            if first_id[i] == other_id[i]:
                continue
            diff_count += 1
        if diff_count == 1:
            like_ids = [first_id, other_id]
            found = True
            break

replace_index = -1
for i in range(0, len(like_ids[0])):
    if like_ids[0][i] != like_ids[1][i]:
        replace_index = i

like_ids[0] = like_ids[0][:replace_index] + like_ids[0][replace_index+1:]
like_ids[1] = like_ids[1][:replace_index] + like_ids[1][replace_index+1:]

print('Result common Letters: ' + like_ids[0])