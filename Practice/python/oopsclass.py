class student():
    school = "Dav"
    def __init__(self,id,name,std):
        self.id = id
        self.name = name
        self.std = std 

    def __str__(self):
        return f"Hello {self.name} , your ID is {self.id}"   
    def printname(self):
        print(f"hello i am {self.name}")
        return self.id


obj = student(123,"Abhishek",12)
print(obj)

class subject(student):
    common = "English"
    def __init__(self,id,name,std,subjects):
        self.subjects = subjects
        self.id = id
        self.name = name
        self.std = std 
        
    def  printname(self):
         print(super().printname())
        
    
obj2 = subject(12,"Amna",23,"hindi")
obj2.printname()

