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

    def do_rectangles_overlap(self, other_rect):
        if self.left + self.width < other_rect.left:
            return False
        elif self.left > other_rect.left + other_rect.width:
            return False
        elif self.top + self.height < other_rect.top:
            return False
        elif self.top > other_rect.top + other_rect.height:
            return False

        return True

rects = []
with open('./../input.txt', 'r') as f:
    for line in f:
        rects.append(Rectangle.from_str(line))

non_overlapping_claim_id = ''
for rect in rects:
    overlaps = False
    for other_rect in rects:
        if rect.claim_id == other_rect.claim_id:
            continue
        if rect.do_rectangles_overlap(other_rect):
            overlaps = True
            break
    if not overlaps:
        non_overlapping_claim_id = rect.claim_id
        break

print('Resulting non-overlapping claim id: ' + non_overlapping_claim_id)