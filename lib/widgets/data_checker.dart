import 'package:flutter/material.dart';

class DataChecker extends StatelessWidget {
  final String title;
  final bool? isLoading;
  final String? isError;
  final bool? isEmpty;
  final Widget? customLoaderIndicator;
  final Widget? customEmptyIndicator;
  final Widget? customErrorIndicator;
  final Widget? customEmptyMessage;
  final Widget children;

  const DataChecker({
    super.key,
    required this.title,
    this.isLoading,
    this.isError,
    this.isEmpty,
    this.customLoaderIndicator,
    this.customEmptyIndicator,
    this.customErrorIndicator,
    this.customEmptyMessage,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading != null  && isLoading!) {
      if (customLoaderIndicator != null) return customLoaderIndicator!;
      return _getLoadingWidget();
    }
    if (isError != null) {
      if (customErrorIndicator != null) return customErrorIndicator!;
      return _getErrorWidget();
    }
    if (isEmpty != null && isEmpty!) {
      if (customEmptyIndicator != null) return customEmptyIndicator!;
      return _getEmptyWidget();
    }
    return children;
  }

  Padding _getLoadingWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title.isNotEmpty ? title : 'Items'),
              const Text(' loading, please wait...'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getErrorWidget() {
    return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
          margin: const EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Error!', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20)),
              const SizedBox(height: 8.0),
              Text(isError!, style: const TextStyle(color: Colors.white, fontSize: 14),),
            ],
          ),
        );
  }

  Widget _getEmptyWidget() {
    return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
          margin: const EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No ${title.toLowerCase()} found!', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20)),
              const SizedBox(height: 8.0),
              customEmptyMessage ?? Text('There are no ${title.toLowerCase()} in our system yet!', style: const TextStyle(color: Colors.white, fontSize: 14),),
              const SizedBox(height: 8.0),
            ],
          ),
        );
  }
}
