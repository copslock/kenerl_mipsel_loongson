Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 02:13:54 +0000 (GMT)
Received: from smtp016.mail.yahoo.com ([IPv6:::ffff:216.136.174.113]:32875
	"HELO smtp016.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225402AbTKDCNn>; Tue, 4 Nov 2003 02:13:43 +0000
Received: from unknown (HELO wzf) (yikok9@61.149.150.135 with login)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 4 Nov 2003 02:12:55 -0000
Date: Tue, 4 Nov 2003 10:13:09 +0800
From: "Wang Zaifang" <yikok9@yahoo.com.cn>
Reply-To: yikok9@yahoo.com.cn
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: boot pb1500 from flash through 16-bit data bus?
X-mailer: Foxmail 5.0 beta1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Message-Id: <20031104021343Z8225402-1272+8745@linux-mips.org>
Return-Path: <yikok9@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yikok9@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

aGksIA0KICBEb2VzIGFueW9uZSBoYXZlIGV4cGVyaWVuY2Ugb24gd3JpdGluZyAxNi1iaXQgYm9v
dGluZyBjb2RlIGZvciBQQjE1MDA/DQogIEknbSB3b3JraW5nIG9uIGEgY3VzdG9taXplZCBhdTE1
MDAgYm9hcmQgdGhhdCBoYXMgcHV6emxlZCB1cyBmb3Igc2VydmVyYWwgZGF5cywgOi0oIFRoZSBi
b2FyZCBpcyBkZXNpZ25lZCB0byBib290IGZyb20gZmxhc2ggdXNpbmcgMTYtYml0IGRhdGEgYnVz
LCBob3dldmVyIGl0IHNlZW1lZCB0aGF0IHRoZSBjb2RlIHdlIHN0b3JlZCBpbiB0aGUgZmxhc2gg
ZG9lcyBub3QgcnVuIGF0IGFsbC4gVGhlcmUgbWlnaHQgYmUgc29tZSBlcnJvcnMgaW4gb3VyIGRl
c2lnbiwgc28gd2UgdHVybiB0byB0aGUgUEIxNTAwIGV2YWwtYm9hcmQuDQogIEkgd3JvdGUgYSBw
aWVjZSBvZiB0ZXN0aW5nIGNvZGUgdGhhdCBzZW5kcyAwMTAxMDEuLi4gc2VyaWVzIHRvIEdQSU9b
MF0gY29udGludW91c2VseSBhZnRlciByZXNldC4gVGhlIGNvZGUgcnVucyB3ZWxsIHdoZW4gdGhl
IFNSQU0gZGF0YSBidXMgaXMgc2V0IHRvIDMyLWJpdCB3aWR0aCwgaS5lLiBhIHNxdWFyZSB3YXZl
Zm9ybSBhcHBlYXJzIG9uIEdQSU9bMF0uIFRoZW4gSSBidXJuIHRoZSBjb2RlIGludG8gZmxhc2gg
dGhyb3VnaCBZQU1PTiwgYXNzdXJpbmcgdGhlIGNvZGUgb25seSByZXNpZGUgaW4gb25lIGZsYXNo
IGNoaXAgb2YgdGhlIHR3by4gQ29udGVudCBvZiB0aGUgZmxhc2ggbG9va3MgbGlrZSB0aGlzIGlu
IFlBTU9OOg0KDQpZQU1PTj4gZHVtcCBiZGMwMDAwMA0KDQpCREMwMDAwMDogOTAgQjEgMDAgMDAg
MDggM0MgMDAgMDAgODAgODAgMDAgMDAgMDkgMzQgMDAgMDAgIC6hwC4uLjwuLi4uLi4uNC4uDQpC
REMwMDAxMDogMkMgMDAgMDAgMDAgMDkgQUQgMDAgMDAgRkYgRkYgMDAgMDAgMDkgMzQgMDAgMDAg
ICwuLi4uLS4uLi4uLi40Li4NCkJEQzAwMDIwOiAwMCAwMSAwMCAwMCAwOSBBRCAwMCAwMCAwMCAw
MCAwMCAwMCAwOSAyNCAwMCAwMCAgLi4uLi4tLi4uLi4uLiQuLg0KLi4uDQoNCiAgRWFjaCBpbnN0
cnVjdGlvbiB3b3JkIGlzIHNwbGl0IGludG8gdHdvIGhhbGYtd29yZHMsIGFuZCBwdXQgaW50byBs
b3dlciAxNi1iaXRzIG9mIHR3byB3b3Jkcy4gVGhlbiBJIHJlc2V0IHRoZSBQQjE1MDAgYm9hcmQs
IHN3aXRjaCBTMTUgdG8gc2V0IHRoZSBTUkFNIGRhdGEgYnVzIHRvIDE2LWJpdCBtb2RlLCBzd2l0
Y2ggUzEzIHRvIGJvb3QgZnJvbSB0aGUgc3BlY2lmaWVkIGZsYXNoIGNoaXAuIEJ1dCB0aGUgY29k
ZSB3aWxsIG5vdCBydW4sIGV2ZW4gYWZ0ZXIgSSBzd2FwIHRoZSBieXRlLW9yZGVyIGFuZCB0aGUg
aGFsZndvcmQtb3JkZXIuDQoNCiAgQW55IGFkdmljZSB3aWxsIGJlIGFwcHJlY2lhdGVkLCA6LSkN
Cg0KoaGhoaGhoaGhoaGhoaGhoVdhbmcgWmFpZmFuZw0KoaGhoaGhoaGhoaGhoaGhoXlpa29rOUB5
YWhvby5jb20uY24NCqGhoaGhoaGhoaGhoaGhoaGhoaGhMjAwMy0xMS0wNA0K
