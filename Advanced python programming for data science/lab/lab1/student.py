class student_info:
    def __init__(self, name, roll, marks):
        self.name = name
        self.roll = roll
        self.marks = marks

    def display(self):
        print(f"Name: {self.name}")
        print(f"Roll Number: {self.roll}")
        print("Marks:")
        for key in self.marks:
            print(f"  {key}: {self.marks[key]}")