---
title: Javascript Re-learn - the types
tags:
  - Test
  - Blog
categories:
  - Hexo
comments: true
date: 2017-03-20 10:02:00
---

# The reason
This is the first post of a series of Javascript re-learn posts. Why am I writing it when there are some many similar stuff out on Internet? If there has to be a reason, the first one would be to review my knowledge on Javascript and hopefully I can get some levle of "学而时习之,可以为师矣".

# Types
One of the best ways to learn a programming language is to think like I'm going to design it. 

Just like the natural languages, first we need to properly express the things in nouns, like apple, orange, etc. As an advance programming language, Javascript's types are very properly designed, not too simple not too complex. 

It starts with `Number`, then `String` and `Boolean`. Then a little more complex, `Object` and `Function`. And that's all, not too over-whelming for beignner to start. 

## Number
Rather that some other languages, e.g. Java, with which the programmer has to remember `Integer`, `Long`, `Float`, `Double`, `BigDecimal` and `BigInteger`, etc, Javascript relieves the beginners from this burden. All numbers start with Type number. 

## String
After much pain with the C, most programming language designers have added `String` as a primitive type ever since, which is proved to be the very right thing to do. 

## Boolean
`Boolean` is not necessary to be a primitive, e.g. C. But defining a Boolean type has been well accepted. It makes the readability of the program better. see following negative example: 

Example 1
```C
int a = 0; 

//Then change a to some other value

if (a) { // do something if expression "a" is true
  //do something
}
```

To be honest, after so many years, I still have to google to find out whether `0` is true or `non-0` is true. 

## Object
When Javascript is designed, OOP is already well accepted. So the author adopted some OOP into the language. But probably he doesn't like the complexities of OOP -- classes, interfaces, abstract classes, inheritance, etc. So he just pick one very simple concept -- `Object` -- to express all the different real life objects, just like he picked only `Number` to express all the numbers. 


## Function
Imagine (脑洞大开) the first human beings who invented the word "apple", then they can use it communicate with their peers. But soon after that, they would have the need to express "pick" and "eat".

In the programming languages, "pick" and "eat" are functions. Once programmers have the objects, they would need functions to operate the object. Unlike some languages like Java (sorry), Javascript's functions can work independently. They are first-class citizen just like the objects. This little difference opens the door for Javascript to become a properly player in the functional programming area. 

