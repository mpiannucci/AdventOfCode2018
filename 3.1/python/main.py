
class Rectangle:
    def __init__(self, claim_id, left, top, width, length):
        self.claim_id = claim_id
        self.left = left
        self.top = top
        self.width = width
        self.length = length

    @staticmethod
    def from_str(input):
        params = input.replace('\n').split(' ')
        claim_id = params[0].replace('#', '')
        
        coords = params[2].replace(':', '').split(',')
        left = int(coords[0])
        top = int(coords[1])

        dims = params[3].split('x')
        width = int(dims[0])
        length = int(dims[1])

        return Rectangle(claim_id, left, top, width, length)

rects = []
with open('./../input.txt', 'r') as f:
    for line in f:
        rects.append(Rectangle.from_str(line))