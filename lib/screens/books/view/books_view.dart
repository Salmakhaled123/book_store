import 'package:bookstore/screens/books/view/widgets/book_view_body.dart';
import 'package:flutter/material.dart';


class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(body: BookViewBody());
  }
}
