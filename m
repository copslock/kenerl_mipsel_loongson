Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2002 03:12:29 +0100 (MET)
Received: from [IPv6:::ffff:202.145.53.89] ([IPv6:::ffff:202.145.53.89]:58592
	"EHLO miao.coventive.com") by ralf.linux-mips.org with ESMTP
	id <S868815AbSKZCMT>; Tue, 26 Nov 2002 03:12:19 +0100
Received: from jefflee (PC193.ia.kh.coventive.com [192.168.23.193] (may be forged))
	by miao.coventive.com (8.11.6/8.11.6) with SMTP id gAQ2Hqx24014;
	Tue, 26 Nov 2002 10:17:52 +0800
From: "jeff" <jeff_lee@coventive.com>
To: <henaldohzh@hotmail.com>, <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: RE: Problem about porting mips kernel
Date: Tue, 26 Nov 2002 10:23:05 +0800
Message-ID: <LPECIADMAHLPOFOIEEFNEEOBCLAA.jeff_lee@coventive.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <F61cMzfoV1qdiixjnzi000000e5@hotmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Return-Path: <jeff_lee@coventive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff_lee@coventive.com
Precedence: bulk
X-list: linux-mips

SGksIGNhbiB5b3UgdHVybiBvZmYgdGhlIGNhY2hlIG9uIG1lbnVjb25maWcgYW5kIHRyeSBhZ2Fp
bj8NCg0KUmVnYXJkcywNCg0KSmVmZg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogbGludXgtbWlwcy1ib3VuY2VAbGludXgtbWlwcy5vcmcgW21haWx0bzpsaW51eC1taXBzLWJv
dW5jZUBsaW51eC1taXBzLm9yZ11PbiBCZWhhbGYgT2YgaGVuYWxkb2h6aEBob3RtYWlsLmNvbQ0K
U2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjYsIDIwMDIgMTA6MDYgQU0NClRvOiByYWxmQGxpbnV4
LW1pcHMub3JnDQpDYzogbGludXgtbWlwc0BsaW51eC1taXBzLm9yZw0KU3ViamVjdDogUmU6IFBy
b2JsZW0gYWJvdXQgcG9ydGluZyBtaXBzIGtlcm5lbA0KDQoNCkkgdGhpbmsgdGhhdCBrZXJuZWwg
aGFkIGJlZW4gY29uZmlndXJlZCBwcm9wZXJseSwgYmVjYXVzZSBJIGNhbiBvcGVuIHRoZSANCnR0
eVMwIGRldmljZSBpbiByYW1kaXNrLiBJdCBtZWFucyBubyByYW1kaXNrIHByb2JsZW0uIEJ1dCBJ
IGhhdmUgbm90IGFueSANCmV4cGVyaWVuY2UgdG8gZml4IHRsYiBvciBjYWNoZSBidWcuIElmIHlv
dSBjYW4gZ2l2ZSBzb21lIG1vcmUgYWR2aWNlPyBUaHguDQoNCg0KDQoNCj5Gcm9tOiBSYWxmIEJh
ZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+DQo+VG86IGhlbmFsZG9oemhAaG90bWFpbC5jb20N
Cj5DQzogbGludXgtbWlwc0BsaW51eC1taXBzLm9yZw0KPlN1YmplY3Q6IFJlOiBQcm9ibGVtIGFi
b3V0IHBvcnRpbmcgbWlwcyBrZXJuZWwNCj5EYXRlOiBNb24sIDI1IE5vdiAyMDAyIDEzOjUzOjEw
ICswMTAwDQo+DQo+T24gTW9uLCBOb3YgMjUsIDIwMDIgYXQgMTI6NDc6MjhQTSArMDAwMCwgaGVu
YWxkb2h6aEBob3RtYWlsLmNvbSB3cm90ZToNCj4NCj4gPiAgIHRoZXNlIGRheXMsIEkgYW0gYnVz
eSB3aXRoIHBvcnRpbmcgbWlwcyBrZXJuZWwgdG8gYSBib2FyZCB3aXRoIHZyNDEzMQ0KPiA+IGNv
cmUuIFRoaXMgYm9hcmQgaGFzIG9ubHkgU0lVIHNlcmlhbCBwb3J0LCBhbmQgc29tZSBodyBoYXZl
IGJlZW4gDQptb2RpZmllZC4NCj4gPiBOb3csIEkgaGF2ZSBwb3J0ZWQgdGhlIGtlcm5lbCB0byBp
dCwgYW5kIG1vZGlmaWVkIGh3IHJ1biB3ZWxsLiBCdXQgc28NCj4gPiBwdXp6bGluZyBtZSwgdGhl
IGV4ZWN1dGlvbiBmaWxlIGNhbm4ndCBydW4gYXQgYWxsLiBJZiBzb21lIG9uZSBjYW4gaGVscCAN
Cm1lDQo+ID4gb3IgZ2l2ZSBzb21lIGFkdmljZXMuIEkgaGF2ZSBiZWVuIGNyYXp5IGZvciB0aGUg
cHJvYmxlbS4gT2ZmIGhhdCBmb3IgDQp5b3VyDQo+ID4gaGVscC4gVGhhbmtzIGEgbG90Lg0KPiA+
ICBidHcsIEkgdXNlIHRoZSByYW1kaXNrIHdpdGggYnVzeWJveC4NCj4NCj5JbiBnZW5lcmFsIHRo
aXMga2luZCBvZiBwcm9ibGVtIG1lYW5zIHRoZSB0bGIgb3IgY2FjaGUgY29kZSBmb3IgYSANCnBh
cnRpY3VsYXINCj5wbGF0Zm9ybSBpcyBmYXVsdHkgb3IgdGhlIGtlcm5lbCBub3QgY29uZmlndXJl
ZCBwcm9wZXJseS4NCj4NCj4gICBSYWxmDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCsPit9HPwtTYIE1TTiBFeHBs
b3JlcjogIGh0dHA6Ly9leHBsb3Jlci5tc24uY29tL2xjY24vIA0K
