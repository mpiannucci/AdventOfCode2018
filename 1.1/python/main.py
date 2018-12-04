
freq = 0

with open('./../input.txt', 'r') as f:
    for line in f:
        if line[0] == '+':
            freq += int(line[1:])
        else:
            freq -= int(line[1:])

print('Result frequency: ' + str(freq))
