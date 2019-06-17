void main() {
  var result = funtions.fold(functionBase,
      (NestedFunction previous, NestedFunctionChain chain) {
    return chain(previous);
  });
  result(10000);
}

typedef void NestedFunction(int num);
typedef NestedFunction NestedFunctionChain(NestedFunction chain);

var funtions = <NestedFunctionChain>[functionA, functionB];

NestedFunction functionBase = (int num) {
  print('functionBase   $num');
};

NestedFunctionChain functionA = (NestedFunction nestedFunction) {
  return (int num) {
    print('before functionA');
    nestedFunction(num);
    print('after functionA');
  };
};

NestedFunctionChain functionB = (NestedFunction nestedFunction) {
  return (int num) {
    print('before functionB');
    nestedFunction(num);
    print('after functionB');
  };
};
