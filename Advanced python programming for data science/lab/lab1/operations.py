def total(student_info):
    sum = 0
    for key in student_info.marks:
        sum += student_info.marks[key]
    return sum
def average(student_info):
    sum = 0
    num = 0
    for key in student_info.marks:
        sum += student_info.marks[key]
        num += 1
    return sum / num
