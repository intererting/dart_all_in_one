import 'dart:async';
import 'dart:io';

void main() {
//  fun1();
//  fun2();
//  fun3();
//  fun4();
  copyFileByStream();
}

void fun4() {
  var directory = new Directory("d:\\");
  directory.list(recursive: false, followLinks: false).listen((data) {
    print(data.absolute.path);
  });
}

void fun1() {
  var directory = new Directory("d:\\dart_file");
  directory.createSync();
  //absolute返回path为绝对路径的Directory对象
  print(directory.absolute.path);
}

void fun2() {
  new Directory("d:\\dart_file")
      .create()
      .then((dir) => print(dir.absolute.path));
}

//Dart中变量的类型可以省略，包括函数
fun3() async {
  var directory = await new Directory("d:\\dart_file").create();
  print(directory.absolute.path);
}

copyFileByStream() async {
  //电子书文件大小：10.9 MB (11,431,697 字节)
  File file = new File(r"D:\test.txt");
  assert(await file.exists() == true);
  //以只读方式打开源文件数据流
  Stream<List<int>> inputStream = file.openRead();
  //数据流监听事件，这里onData是null
  //会在后面通过StreamSubscription来修改监听函数
  StreamSubscription subscription = inputStream.listen(null);

  File target = new File(r"D:\test.back.txt");
  //以WRITE方式打开文件，创建缓存IOSink
  IOSink sink = target.openWrite();

  //常用两种复制文件的方法，就速度来说，File.copy最高效
//  //经测试，用时21毫秒
//  await file.copy(target.path);
//  //输入流连接缓存，用时79毫秒，比想象中高很多
//  //也许是数据流存IOSink缓存中之后，再转存到文件中的原因吧！
//  await sink.addStream(inputStream);

  //手动处理输入流
  //接收数据流的时候，涉及一些简单的计算
  //如：当前进度、当前时间、构造字符串
  //但是最后测试下来，仅用时68毫秒，有些不可思议

  //文件大小
  int fileLength = await file.length();
  //已读取文件大小
  int count = 0;

  //当输入流传来数据时，设置当前时间、进度条，输出信息等
  subscription.onData((list) {
    count = count + list.length;
    //进度百分比
    double num = (count * 100) / fileLength;

    //输出样式：[1:19:197]**********[20.06%]
    //进度每传输2%，多一个"*"
    //复制结束进度为100%，共50个"*"
    print(num);
    //将数据添加到缓存池
    sink.add(list);
  });

  //数据流传输结束时，触发onDone事件
  subscription.onDone(() {
    print("复制文件结束！");
    //关闭缓存释放系统资源
    sink.close();
    subscription.cancel();
  });
}
