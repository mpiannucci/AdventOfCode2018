
two_count = 0
three_count = 0

with open('./../input.txt', 'r') as f:
    for line in f: 
        chars = {}
        for char in line:
            if char in chars:
                chars[char] += 1
            else: 
                chars[char] = 1
        
        two_found = False
        three_found = False
        for char, count in chars.items():
            if count == 2 and not two_found:
                two_count += 1
                two_found = True
            elif count == 3 and not three_found:
                three_count += 1
                three_found = True
            if two_found and three_found:
                break

print('Two count: ' + str(two_count))
print('Three count: ' + str(three_count))
print('Result checksum: ' + str(two_count*three_count))