import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.planId, required this.businessId}) : super(key: key);

  final String planId;
  final String businessId;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

String paymentUrl = 'https://pospro.acnoo.com/payments-gateways/plan_id/business_id';
const String successUrl = 'order-status?status=success';
const String failureUrl = 'order-status?status=failed';

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentUrl = paymentUrl.replaceAll('plan_id', widget.planId).replaceAll('business_id', widget.businessId);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (url.contains(successUrl)) {
              print('This is susses');
              Navigator.pop(context,true);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const SuccessScreen(),
              //     ));
              return;
            }
            if (url.contains(failureUrl)) {
              print('This is Field');
              Navigator.pop(context,false);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const FailureScreen(),
              //     ));
              return;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: WebViewWidget(
        controller: controller,

        // initialUrl: paymentUrl,
        // javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller = webViewController;
        // },
        // navigationDelegate: (NavigationRequest request) {
        //   if (request.url == successUrl) {
        //     // Handle success
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => SuccessScreen()),
        //     );
        //     return NavigationDecision.prevent;
        //   } else if (request.url == failureUrl) {
        //     // Handle failure
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => FailureScreen()),
        //     );
        //     return NavigationDecision.prevent;
        //   }
        //   return NavigationDecision.navigate;
        // },
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
      ),
      body: const Center(
        child: Text('Payment was successful!'),
      ),
    );
  }
}

class FailureScreen extends StatelessWidget {
  const FailureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Failed'),
      ),
      body: const Center(
        child: Text('Payment failed. Please try again.'),
      ),
    );
  }
}
