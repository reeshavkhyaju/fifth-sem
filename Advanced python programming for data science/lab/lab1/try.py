from student import student_info
import operations as op

a = student_info("Alice", 101, {"Math": 90, "Science": 85, "English": 88})

a.display()

print()
print(f" The total marks of the student is: {op.total(a)}")
print()
print(f" The average marks of the student is: {op.average(a)}")