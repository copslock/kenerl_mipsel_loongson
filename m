Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 05:36:07 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:32907 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8224843AbUJFEgD>;
	Wed, 6 Oct 2004 05:36:03 +0100
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: mips linux glibc-2.3.3 build - Unknown ABI problem
Date: Tue, 5 Oct 2004 21:35:41 -0700
Message-ID: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF4D2@avtrex-server.hq.avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mips linux glibc-2.3.3 build - Unknown ABI problem
Thread-Index: AcSrW6uyj8EPf7l8Q1m1B7UnZS83jgAAa14B
From: "David Daney" <ddaney@avtrex.com>
To: "T. P. Saravanan" <sara@procsys.com>
Cc: <linux-mips@linux-mips.org>
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

U29ycnkgZm9yIHRoZSBob3JrZWQgdXAgbWFpbCBtZXNzYWdlIGZvcm1hdCwgYnV0IHRoZXNlIHdl
YiBiYXNlZCBlLW1haWwgY2xpZW50cyBtYWtlIGl0IGRpZmZpY3VsdC4uLg0KIA0Kc3lzZGVwcy9t
aXBzL21hY2hpbmUtZ21vbi5oIHZlcnNpb24gMS44IGhhcyB0aGUgI2luY2x1ZGUgPHNnaWRlZnMu
aD4gd2hpY2ggd2lsbCBzb2x2ZSB0aGUgcHJvYmxlbSB3aGVuIHVzaW5nIGdjYyAzLjQueC4NCiAN
CiANCk90aGVycyBoYXZlIHJlcG9ydGVkIHRoYXQgcmVjZW50IHZlcnNpb25zIG9mIGdsaWJjIGZy
b20gdGhlIGdsaWJjIENWUyBzZXJ2ZXIgd2lsbCBjb21waWxlIHdpdGhvdXQgcGF0Y2hpbmcuICBQ
ZXJoYXBzIHlvdSBzaG91bGQgdHJ5IGl0LiAgVGhhdCBpcyB3aGF0IEkgYW0gZ29pbmcgdG8gZG8g
cmlnaHQgbm93Lg0KIA0KRGF2aWQgRGFuZXkuDQoNCgktLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LSANCglGcm9tOiBULiBQLiBTYXJhdmFuYW4gW21haWx0bzpzYXJhQHByb2NzeXMuY29tXSANCglT
ZW50OiBUdWUgMTAvNS8yMDA0IDk6MTQgUE0gDQoJVG86IERhdmlkIERhbmV5IA0KCUNjOiBsaW51
eC1taXBzQGxpbnV4LW1pcHMub3JnIA0KCVN1YmplY3Q6IFJlOiBtaXBzIGxpbnV4IGdsaWJjLTIu
My4zIGJ1aWxkIC0gVW5rbm93biBBQkkgcHJvYmxlbQ0KCQ0KCQ0KDQoJVC4gUC4gU2FyYXZhbmFu
IHdyb3RlOg0KCQ0KCT4gRGF2aWQgRGFuZXkgd3JvdGU6DQoJPg0KCT4+PiBXaGF0IHNob3VsZCBJ
IGRvIHRvIGZpeCB0aGUgYnVpbGQ/DQoJPj4+ICANCgk+Pg0KCT4+DQoJPj4gZ2V0IHRoZSBtb3N0
IHJlY2VudCBtYWNoaW5lLWdtb24uaCBmcm9tIGdsaWJjIENWUy4NCgk+Pg0KCT4+IFlvdSB3aWxs
IHByb2JhYmx5IGZpbmQgYSBwcm9ibGVtIGxpbmtpbmcgbGliYyBhdCBhIGxhdGVyIHN0ZXAuICBC
dXQgdGhlDQoJPj4gbmV3ZXIgbWFjaGluZS1nbW9uLmggd2lsbCBmaXggdGhpcyBwcm9ibGVtLg0K
CT4+IA0KCT4+DQoJPiBPSy4gVGhhdCB3b3JrZWQuICBUaGFua3MgYSBsb3QuDQoJPg0KCU9vcHMh
ICBJIHdpbGwgdGFrZSB0aGF0IGJhY2suIEkgc3VzcGVjdCBpdCBpcyBub3Qgd29ya2luZy4NCgkN
CglXaGVuIHlvdSBzYWlkIENWUyBJIGFzc3VtZWQgdGhlIG9uZSBpbiBodHRwOi8vbGludXgtbWlw
cy9jdnN3ZWIvbGliYy4gDQoJT24gY2xvc2VyDQoJbG9vayBpdCBsb29rcyB2ZXJ5IG9sZC4gIEZy
b20gZGlzY3Vzc2lvbnMgaW4gYW5vdGhlciB0aHJlYWQgSSBnYXRoZXIgQ1ZTDQoJbWVhbnMgaHR0
cDovL3NvdXJjZXMucmVkaGF0LmNvbS9jZ2ktYmluL2N2c3dlYi5jZ2kvbGliYy8/Y3Zzcm9vdD1n
bGliYy4NCgkoQ29ycmVjdCBtZQ0KCWlmIHRoaXMgaXMgd3JvbmcuKSBJZiBJIHRha2UgdGhlIG1h
Y2hpbmUtZ21vbi5oIGZyb20gaGVyZSAtIEl0IHN0aWxsIGhhcw0KCXRoZQ0KCXNhbWUgcHJvYmxl
bSA6LSgNCgkNCgktU2FyYXZhbmFuLg0KCQ0KCQ0KCQ0KDQo=
