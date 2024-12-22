#person class
class Person:
    # Initializing the person class with attributes name and id_number
    def __init__(self, name:str, id_number:str) -> str:
        self.name = name
        self.id_number = id_number

    def __str__(self) -> str:
        return f"Name: {self.name}, ID: {self.id_number}"
        
    
#student class
class Student (Person):
    """
    initializing the student class which is a child class of the person to 
    include the major of the student 
    """
    def __init__(self, name: str, id_number: str, major: str) -> str:
        super().__init__(name, id_number)
        self.major = major

    def __str__(self) -> str:
        return f"{super().__str__()}, Major: {self.major}"

#instructor class
class Instructor (Person):
    """
    initializing the instructor class which is a child class of the person to 
    include the department of the instructor 
    """
    def __init__(self, name: str, id_number: str, department: str) -> str:
        super().__init__(name, id_number)
        self.department = department

    def __str__(self) -> str:
        return f"{super().__str__()}, Department: {self.department}"

#course class
class Course:
    def __init__(self, course_name: str, course_id: str) -> None:
        self.course_name = course_name
        self.course_id = course_id
        self.enrolled_students = []

    # method to add a student to a course
    def add_student(self, student):
        if isinstance(student, Student):
            self.enrolled_students.append(student)
            return True
        else:
            return False
        
    # Method to remove a student from a course
    def remove_student(self, student):
        #Find  the student with their id_number  and remove them using their id 
        if student in self.enrolled_students:
            self.enrolled_students.remove(student)
            return True
        else: 
            return False

    def __str__(self) -> str:
        return f"Course: {self.course_name}, course id: {self.course_id}, enrolled students: {self.enrolled_students}"
    

#enrollment class
class Enrollment:
    def __init__(self, student: str, course: str) -> None:
        self.student = student
        self.course = course
        self.grade = None

    # Method to assign a grade to the student   
    def assign_grade(self, grade):
        self.grade = grade
    
    def __str__(self) -> str:
        grade_str = self.grade if self.grade is not None else "Not grade"
        return f"Enrollment: {self.student.name} in {self.course.name} - Grade: {grade_str}"

#SMS (student management system)
class StudentManagementSystem:
    def __init__(self):
        self.student = {}
        self.instructor = {}
        self.course = {}
        self.enrollments = []

    # Student methods
    def add_student(self, student):
        if isinstance(student, Student):
            self.student[student.id_number] = student
            return f"Student {student.name} has been added."

    def remove_student(self, id_number):
        if id_number in self.student:
            del self.students[id_number]
            self.enrollments = [e for e in self.enrollments if e.student.id_number != id_number]
            return f"Student with ID {id_number} has been removed."
    

    def update_student(self, id_number, name =None, major = None):
        if id_number in self.student:
            student = self.students[id_number]
            if name: 
                student.name = name
            if major: 
                student.major = major
            return f"Student with ID {id_number} has been updated."
        else:
            return f"Student with ID {id_number} not found."
        

    # Instructor method
    def add_instructor(self, instructor):
        if isinstance(instructor, Instructor):
            self.instructor[instructor.id_number] = instructor
            return f"Instructor {instructor.name} has been added."

    def remove_instructor(self, id_number):
        if id_number in self.instructor:
            del self.instructor[id_number]
            return f"Instructor with ID {id_number} has been removed."
    

    def update_instructor(self, id_number, name =None, department = None):
        if id_number in self.instructor:
            instructor = self.instructor[id_number]
            if name: 
                instructor.name = name
            if department: 
                instructor.department = department
            return f"Instructor with ID {id_number} has been updated."
        else:
            return f"Instructor with ID {id_number} not found."
        
    # Course methods 
    def add_course(self, course):
        if isinstance(course, Course):
            self.course[course.id_number] = course
            return f"Student {course.name} has been added."

    def remove_course(self, course_id):
        if course_id in self.course:
            del self.course[course_id]
            self.enrollments = [e for e in self.enrollments if e.course.course_id != course_id]
            return f"Student with ID {course_id} has been removed."
    

    def update_course(self, course_id, course_name =None):
        if course_id in self.course:
            course = self.course[course_id]
            if course_name: 
                course.course_name = course_name
            return f"Student with ID {course_id} has been updated."
        else:
            return f"Student with ID {course_id} not found."

    #Enrollment method
    def enroll_student(self, id_number, course_id):
        if id_number in self.student and course_id in self.course:
            student = self.student[id_number]
            course = self.course[course_id]
            course.add_student(student)
            enrollment = Enrollment(student=student, course=course)
            self.enrollments.append(enrollment)

    def assign_grade(self, id_number, course_id, grade):
        for enrollment in self.enrollments:
            if enrollment.student.id_number == id_number and enrollment.course.course_id == course_id:
                enrollment.assign_grade(grade)
                return 
            
    def get_courses_for_student(self, id_number):
        if id_number in self.student:
            student = self.student[id_number]
            return [e.course for e in self.enrollments if e.student.id_number == id_number]
        else:
            return []
        
    def students_in_course(self, course_id):
        if course_id in self.course:
            course = self.course[course_id]
            return [e.student for e in self.enrollments if e.course.course_id == course_id]
        else:
            return []
        
    def __str__(self) -> str:
        return (f"StudentManagementSystem(students = {self.student}, "
            f"instructor = {self.instructor},  courses = {self.course}, "
            f"enrollments = {self.enrollments})")
        
    