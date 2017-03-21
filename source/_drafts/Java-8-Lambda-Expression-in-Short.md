---
title: Java 8 Lambda Expression in Short
tags:
  - Java
  - Lambda
  - Functional
categories:
  - Programming Languages
comments: true
date: 2016-05-08 00:00:00
---

# Anonymous class in a new form

Simply speaking, Java 8 Lambda expressions are just anonymous classes which have occasionally made their appearances in the previous Java versions. But now they appears in much more concise forms with the new syntactic level support. Here are a couple of examples how concise we can archive in Java coding with the help of lambda expression.

```Java
//Anonymous class
Collections.sort(names, new Comparator<String>() {
  @Override
  public int compare(String o1, String o2) {
    return o1.compareTo(o2);
  }
});

//Java 8 Lambda expression in complete 
Collections.sort(names, (String o1, String o2) -> {
  return o1.compareTo(o2);
});

//Parameter type can be omitted, because the types can be inferred
Collections.sort(names, (o1, o2) -> {
  return o1.compareTo(o2);
});

//return can be omitted for one line lambda
Collections.sort(names, (o1, o2) -> o1.compareTo(o2));

//method reference can make it even shorter
Collections.sort(names, String::compareTo);
```
# Default method is necessary for lambdas
With anonymous classes, it is possible to define a new utility method, e.g.

```Java
//Anonymous class
Collections.sort(names, new Comparator<String>() {
  @Override
  public int compare(String o1, String o2) {
    return o1.compareTo(o2);
  }
  public Comparator<String> reversed() {
    return Collections.reverseOrder(this);
  }
});
```

But the utility method cannot fit into a concise lambda. This is why Java 8 has made default methods possible in interfaces. The example above can now be re-written in Java 8 as follow: 
```Java    
Collections.sort(names, ((Comparator<String>)String::compareTo).reversed());
```
>Note: the type casting is necessary, because type inference is not that smart in that context.

# Using functional features rather than being functional
The introduction of lambda and the re-written interfaces/classes makes Java 8 look like functional programming language. But as a matter of fact, it is not. Type is still the the first-class citizen, not functions. Everything in Java is still type of either predefined types or primitives. Passing lambdas around is actually just passing usual objects around. 

However, this is what is needed for most of the Java developers -- writing concise code as well as thinking in a functional programming way. 

# References
* https://github.com/winterbe/java8-tutorial
* http://www.infoq.com/articles/How-Functional-is-Java-8
