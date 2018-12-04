import numpy as np

class Rectangle:
    def __init__(self, claim_id, left, top, width, height):
        self.claim_id = claim_id
        self.left = left
        self.top = top
        self.width = width
        self.height = height

    @staticmethod
    def from_str(input):
        params = input.replace('\n', '').split(' ')
        claim_id = params[0].replace('#', '')
        
        coords = params[2].replace(':', '').split(',')
        left = int(coords[0])
        top = int(coords[1])

        dims = params[3].split('x')
        width = int(dims[0])
        height = int(dims[1])

        return Rectangle(claim_id, left, top, width, height)

rects = []
with open('./../input.txt', 'r') as f:
    for line in f:
        rects.append(Rectangle.from_str(line))

design_space = np.zeros((1000, 1000))
for rect in rects:
    design_space[rect.top:rect.top+rect.height, rect.left:rect.left+rect.width] += 1
design_space[design_space < 2] = 0
design_space[design_space > 0] = 1

print('Resulting overlapping square inches: ' + str(design_space.sum()))