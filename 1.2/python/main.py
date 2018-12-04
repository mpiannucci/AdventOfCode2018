
freq = 0
found_freqs = set()

buffer = ''
with open('./../input.txt', 'r') as f:
    buffer = f.read()

found_duplicate = False
iteration_count = 0
while not found_duplicate:
    for line in buffer.split('\n'):
        if line[0] == '+':
            freq += int(line[1:])
        else:
            freq -= int(line[1:])
        if freq in found_freqs:
            found_duplicate = True
            break
        else: 
            found_freqs.add(freq)
    iteration_count += 1
    print('Searching... iteration ' + str(iteration_count))


print('Result frequency: ' + str(freq))
