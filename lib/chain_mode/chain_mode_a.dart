void main() {
  var result = funtions.fold(functionBase,
      (NestedFunction previous, NestedFunctionChain chain) {
    return chain(previous);
  });

  print(result(1000));
}

typedef int NestedFunction(int num);
typedef NestedFunction NestedFunctionChain(NestedFunction chain);

var funtions = <NestedFunctionChain>[functionA, functionB];

NestedFunction functionBase = (int num) => num;

NestedFunctionChain functionA = (NestedFunction nestedFunction) {
  return (int num) {
    var nextNum = nestedFunction(num);
    return nextNum + 1;
  };
};

NestedFunctionChain functionB = (NestedFunction nestedFunction) {
  return (int num) {
    var nextNum = nestedFunction(num);
    return nextNum * 2;
  };
};
