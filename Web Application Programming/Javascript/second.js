// //call back
// const add=(x,y,callbackfuncation)=>{
//     let sum = x+y;
//     // return sum;
//     callbackfuncation(sum);
// }

// // console.log("The sum is: ", add(5,10));

// add(5,6,(res)=>{
//     console.log("The result is: ", res);
// })

// setTimeout(()=>{
//     console.log("Hello world after 3 seconds");
// },3000);

// const arr=["Apple","Banana","Mango","Orange"];
// for(x of arr){
//     console.log(x);
// }
// arr.forEach((x)=>{
//     console.log(x);
// });

// const arr = [1, 2, 3, 4, 5];
// const arr1 = arr.map((x) => {return x * 2;  });
// console.log("arr1", arr1);

// const arrFiltered = arr.filter((x) => { return x > 2; });
// console.log("arrFiltered", arrFiltered);

// const students = [
//     {
//         name: "John", 
//         address: "Bkt"
//     },
//     {
//         name: "Jane", 
//         address: "Kathmandu"
//     },
//     {
//         name: "Jim", 
//         address: "Lalitpur"
//     },
//     {
//         name: "Jake", 
//         address: "Bhaktapur"
//     }
// ];
// const BhaktapurStudents = students.filter((s) => {
//     return s.address === "Bhaktapur";
// });
// console.log("Bhaktapur Students: ", BhaktapurStudents);

// 1. Write a program to check if a nümber is positive, negative, or zero. (Using If else)
// 2. Take a student's marks and print grade: (Using if..
// elseif... else)
// a.90+ -->A
// b. 80+ -->B
// c.70+ -->C
// d. else -->Fall
// 3. Ask the user for a number (use prompt). Print whether it's even or odd.
// Syntax:
// let value = prompt("Enter something:");
// 4. Given three numbers, print the largest number.
// 5. Write a switch-case program to print day of the week (1-7).
// 6. Print the sum of numbers from 1 to 100.

// let number = 5;
// if (number > 0) {
//     console.log('The number ' + number + ' is Positive.');
// } else if (number < 0) {
//     console.log('The number ' + number + ' is Negative.');
// } else {
//     console.log('The number ' + number + ' is Zero.');
// }

// // let marks = parseInt(prompt("Enter student's marks:"));
// let marks = 85;
// if (marks >= 90) {
//     console.log("Grade: A");
// }
// else if (marks >= 80) {
//     console.log("Grade: B");
// }
// else if (marks >= 70) {
//     console.log("Grade: C");
// }
// else {
//     console.log("Grade: Fail");
// }

// // let value = prompt("Enter a number:");
// let value = 8;

// value = Number(value); // convert input to number
// if (value % 2 === 0) {
//     console.log("The number is Even");
// }
// else {
//     console.log("The number is Odd");
// }

// // let a = Number(prompt("Enter first number:"));
// // let b = Number(prompt("Enter second number:"));
// // let c = Number(prompt("Enter third number:"));
// let a = 10;
// let b = 25;
// let c = 15;
// let largest;
// if (a >= b && a >= c) {
//     largest = a;
// } 
// else if (b >= a && b >= c) {
//     largest = b;
// } 
// else {
//     largest = c;
// }
// console.log("The largest number is: " + largest);

// // let day = Number(prompt("Enter a number (1-7):"));
// let day = 3;
// switch (day) {
//     case 1:
//         console.log("Sunday");
//         break;
//     case 2:
//         console.log("Monday");
//         break;
//     case 3:
//         console.log("Tuesday");
//         break;
//     case 4:
//         console.log("Wednesday");
//         break;
//     case 5:
//         console.log("Thursday");
//         break;
//     case 6:
//         console.log("Friday");
//         break;
//     case 7:
//         console.log("Saturday");
//         break;
//     default:
//         console.log("Invalid input! Enter a number from 1 to 7.");
// }

// let sum = 0;

// for (let i = 1; i <= 100; i++) {
//     sum += i;
// }

// console.log("Sum of numbers from 1 to 100 is: " + sum);

// 7. Print multiples of 5 from 5 to 100.
// 8. Print all even numbers between 1 and 30,
// 9 Write a function isPrime(n) that checks if a number is prime.

// for (let i = 5; i <= 100; i += 5) {
//     console.log(i);
// }

// for (let i = 1; i <= 30; i++) {
//     if (i % 2 === 0) {
//         console.log(i);
//     }
// }

// function isPrime(n) {
//     if (n <= 1) {
//         return false; 
//     }

//     for (let i = 2; i <= Math.sqrt(n); i++) {
//         if (n % i === 0) {
//             return false; 
//         }
//     }

//     return true; 
// }
// console.log(isPrime(7));  // true
// console.log(isPrime(10)); // false

// 10. Write a function that takes a string and returns the number of vowels.
// 11 Write a function that reverses a string (without using built-in reverse()).
// 12. Write a function to check whether a string is a palindrome.
// 13. Write a function that returns the second largest number in an array.
// 14 Given an array of numbers, return a new array with only even numbers
// 15. Create a calculator function (add, sub, mul, div) using switch-case.

// function countVowels(str) {
//     let count = 0;
//     let vowels = "aeiouAEIOU";

//     for (let char of str) {
//         if (vowels.includes(char)) {
//             count++;
//         }
//     }

//     return count;
// }
// console.log(countVowels("Hello World"));

// function reverseString(str) {
//     let reversed = "";

//     for (let i = str.length - 1; i >= 0; i--) {
//         reversed += str[i];
//     }

//     return reversed;
// }
// console.log(reverseString("hello"));

// function isPalindrome(str) {
//     let reversed = "";

//     for (let i = str.length - 1; i >= 0; i--) {
//         reversed += str[i];
//     }

//     return str === reversed;
// }
// console.log(isPalindrome("madam")); // true
// console.log(isPalindrome("hello")); // false

// function secondLargest(arr) {
//     let max = -Infinity;
//     let second = -Infinity;

//     for (let num of arr) {
//         if (num > max) {
//             second = max;
//             max = num;
//         } else if (num > second && num !== max) {
//             second = num;
//         }
//     }

//     return second;
// }
// console.log(secondLargest([10, 20, 5, 30, 25]));  // 25

// function getEvenNumbers(arr) {
//     let result = [];

//     for (let num of arr) {
//         if (num % 2 === 0) {
//             result.push(num);
//         }
//     }

//     return result;
// }
// console.log(getEvenNumbers([1, 2, 3, 4, 5, 6]));

// function calculator(a, b, operation) {
//     switch (operation) {
//         case "add":
//             return a + b;
//         case "sub":
//             return a - b;
//         case "mul":
//             return a * b;
//         case "div":
//             return b !== 0 ? a / b : "Cannot divide by zero";
//         default:
//             return "Invalid operation";
//     }
// }
// console.log(calculator(10, 5, "add"));
// console.log(calculator(10, 5, "mul"));
