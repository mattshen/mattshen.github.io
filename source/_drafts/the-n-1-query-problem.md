---
title: the n+1 query problem
tags: 
  - FP
  - IO
---

# The problem
Most of us know the [N+1 query problem](https://secure.phabricator.com/book/phabcontrib/article/n_plus_one/). It originated from SQL query problem domain, especially ORM. However, it applies to most IO operations.

# Example in imperative programming 
Following is a simple example of it. 
```java

List<Box> getAllBoxesOwnedByUser(String userId) {
  //do some slow IO query to get a list of user boxes
  //...
  return boxes;
}

List<Item> getAllItemsInTheBox(String boxId) {
  //do some slow IO query to get a list of user boxes
  //...
  return items;
}

List<Item> getAllItemsOwnedByUser(String userId) {
  List<Box> boxes = getAllBoxesOwnedByUser(userId);
  List<Item> allItems = new List<>();
  for(Box box: boxes) {
    allItems.addAll(getAllItemsInTheBox(box.getId()));
  }
  return allItems;
}

```

Most developers with some years of experience won't do a method like `getAllItemsOwnedByUser` as above, because the imperative style of the method indicates explicitly of performance. 

# Example in FP
But the situation changes a little bit when it comes to FP style. Here it is, 

```java
List<Item> getAllItemsOwnedByUser(String userId) {
  return getAllBoxesOwnedByUser(userId).flatMap(box -> {
    return getAllItemsInTheBox(box.getId());
  })
}
```

This particular piece of code might not impose much greater difficulty than the previous imperative implementation. But it would very likely make a difference in a large code base when `getAllBoxesOwnedByUser` and `getAllItemsOwnedByUser` are from different locations of the code base. It's not uncommon to see developers simply pick `map` or `flatMap` and celebrate the easily archived correctness. 

# Summary
When it comes to IO, FP hides the performance implications so well, which requires us to pay extra attention.