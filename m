Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 16:10:12 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:59813 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492012Ab0D2OKF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 16:10:05 +0200
Received: (snipe 29222 invoked by uid 0); 29 Apr 2010 23:09:49 +0900
Received: from sanjay.kumar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.031613 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 29 Apr 2010 23:09:49 +0900
X-RCPTTO: linux-mips@linux-mips.org,
        u-boot@lists.denx.de
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 29 Apr 2010 23:09:49 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----_=_NextPart_001_01CAE7A5.A129BFBB"
Subject: Exception in U-Boot
Date:   Thu, 29 Apr 2010 23:04:54 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104E05772@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Exception in U-Boot
Thread-Index: AcrnpNuHHTaZvFXdTrSJGGPJ8yCNNQAABWmI
References: <5858DE952C53A441BDA3408A0524130104CCE0A3@mkegmal01>
From:   "Sanjay Kumar" <sanjay.kumar@gmobis.com>
To:     <u-boot@lists.denx.de>
X-OriginalArrivalTime: 29 Apr 2010 14:09:49.0751 (UTC) FILETIME=[A16F0C70:01CAE7A5]
Return-Path: <sanjay.kumar@gmobis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjay.kumar@gmobis.com
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.

------_=_NextPart_001_01CAE7A5.A129BFBB
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQWxsLA0KICAgICAgV2UgYXJlIHBvcnRpbmcgVS1ib290LiAyMDEwLjAzICB2ZXJzaW9uIGZv
ciBNSVBTMzIgcHJvY2Vzc29yIChBdTEzNTApLiBDdXJyZW50bHkgd2UgYXJlIGZhY2luZyBvbmUg
cHJvYmxlbToNCg0KV2hlbiBJIGNvbXBpbGUgdS1ib290IGFuZCBwcm9ncmFtIHRvIE5PUiBGbGFz
aCB1c2luZyBiZGlHREIgdGhyb3VnaCBCREkzMDAwIERlYnVnZ2VyLCBJIGFtIG9ic2VydmluZyB1
LWJvb3QgaGFuZ3MgYXQgZXhjZXB0aW9uIGkuZS4gYXQgYWRkcmVzcyAweGJmYzAwNTcwIGFmdGVy
IHJlc2V0IC4NCg0KZXJyb3IgbG9nIGlzIGJlbG93Og0KDQoNCkF1MTM1MD50aQ0KICAgIENvcmUg
bnVtYmVyICAgICAgIDogMA0KICAgIENvcmUgc3RhdGUgICAgICAgIDogRGVidWcgTW9kZQ0KICAg
IERlYnVnIGVudHJ5IGNhdXNlIDogc2luZ2xlIHN0ZXANCiAgICBDdXJyZW50IFBDICAgICAgICA6
IDB4YmZjMDA0MDANCiAgICBDdXJyZW50IFNSICAgICAgICA6IDB4MDA0MDAwMDQNCiAgICBDdXJy
ZW50IExSICAocjMxKSA6IDB4YmZjMGY2ZTQNCiAgICBDdXJyZW50IFNQICAocjI5KSA6IDB4ODAz
ZmZmMDANCkF1MTM1MD5nbw0KQXUxMzUwPmhhbHQNCiAgICBDb3JlIG51bWJlciAgICAgICA6IDAN
CiAgICBDb3JlIHN0YXRlICAgICAgICA6IERlYnVnIE1vZGUNCiAgICBEZWJ1ZyBlbnRyeSBjYXVz
ZSA6IEpUQUcgYnJlYWsgcmVxdWVzdA0KICAgIEN1cnJlbnQgUEMgICAgICAgIDogMHhiZmMwMDU3
MA0KICAgIEN1cnJlbnQgU1IgICAgICAgIDogMHgwMDQwMDAwMg0KICAgIEN1cnJlbnQgTFIgIChy
MzEpIDogMHhiZmMwZjZlNA0KICAgIEN1cnJlbnQgU1AgIChyMjkpIDogMHg4MDNmZmYwMA0KQXUx
MzUwPg0KDQpBZnRlciByZXNldCBhZGRyZXNzIDB4YmZjMDA0MDAsIGNvZGUgZXhlY3V0ZXMgbG93
bGV2ZWxfaW5pdCBhbmQgc3Vic2VxdWVudGx5IGhhbmdzIGF0IDB4YmZjMDA1NzAgKFJvbUV4Y2Vw
dGlvbikuDQoNCkknbSBhdHRhY2hpbmcgc3RhcnQuUyBhbmQgbG93bGV2ZWxfaW5pdC5TIGZpbGVz
IHdlIGFyZSB1c2luZy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIGFtIGRvaW5nIGFueXRoaW5n
IHdyb25nIG9yIG1pc3Npbmcgc29tZXRoaW5nLg0KDQpXaXRoIFRoYW5rcyBhbmQgUmVnYXJkcywN
ClNhbmpheSBLdW1hcg0KS1BJVCBDdW1taW5zIEluZm9zeXN0ZW1zIFB2dCBMdGQNCg0KDQoNCg==

------_=_NextPart_001_01CAE7A5.A129BFBB
Content-Type: application/octet-stream;
	name="start.S"
Content-Transfer-Encoding: base64
Content-Description: start.S
Content-Disposition: attachment;
	filename="start.S"

LyoKICogIFN0YXJ0dXAgQ29kZSBmb3IgTUlQUzMyIENQVS1jb3JlCiAqCiAqICBDb3B5cmlnaHQg
KGMpIDIwMDMJV29sZmdhbmcgRGVuayA8d2RAZGVueC5kZT4KICoKICogU2VlIGZpbGUgQ1JFRElU
UyBmb3IgbGlzdCBvZiBwZW9wbGUgd2hvIGNvbnRyaWJ1dGVkIHRvIHRoaXMKICogcHJvamVjdC4K
ICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRl
IGl0IGFuZC9vcgogKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBhcwogKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZgogKiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiAqIGJ1dCBXSVRIT1VUIEFO
WSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAqIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUK
ICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICoKICogWW91
IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UKICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZy
ZWUgU29mdHdhcmUKICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAz
MzAsIEJvc3RvbiwKICogTUEgMDIxMTEtMTMwNyBVU0EKICovCgojaW5jbHVkZSA8Y29uZmlnLmg+
CiNpbmNsdWRlIDxhc20vcmVnZGVmLmg+CiNpbmNsdWRlIDxhc20vbWlwc3JlZ3MuaD4KCgkvKgoJ
ICogRm9yIHRoZSBtb21lbnQgZGlzYWJsZSBpbnRlcnJ1cHRzLCBtYXJrIHRoZSBrZXJuZWwgbW9k
ZSBhbmQKCSAqIHNldCBTVDBfS1ggc28gdGhhdCB0aGUgQ1BVIGRvZXMgbm90IHNwaXQgZmlyZSB3
aGVuIHVzaW5nCgkgKiA2NC1iaXQgYWRkcmVzc2VzLgoJICovCgkubWFjcm8Jc2V0dXBfYzBfc3Rh
dHVzIHNldCBjbHIKCS5zZXQJcHVzaAoJbWZjMAl0MCwgQ1AwX1NUQVRVUwoJb3IJdDAsIFNUMF9D
VTAgfCBcc2V0IHwgMHgxZiB8IFxjbHIKCXhvcgl0MCwgMHgxZiB8IFxjbHIKCW10YzAJdDAsIENQ
MF9TVEFUVVMKCS5zZXQJbm9yZW9yZGVyCglzbGwJemVybywgMwkJCQkjIGVoYgoJLnNldAlwb3AK
CS5lbmRtCgoJLm1hY3JvCXNldHVwX2MwX3N0YXR1c19yZXNldAojaWZkZWYgQ09ORklHXzY0QklU
CglzZXR1cF9jMF9zdGF0dXMgU1QwX0tYIDAKI2Vsc2UKCXNldHVwX2MwX3N0YXR1cyAwIDAKI2Vu
ZGlmCgkuZW5kbQoKI2RlZmluZSBSVkVDRU5UKGYsbikgXAogICBiIGY7IG5vcAojZGVmaW5lIFhW
RUNFTlQoZixiZXYpIFwKICAgYiBmICAgICA7ICAgICAgICAgICBcCiAgIGxpIGswLGJldgoKCS5z
ZXQgbm9yZW9yZGVyCgoJLmdsb2JsIF9zdGFydAoJLnRleHQKX3N0YXJ0OgoJUlZFQ0VOVChyZXNl
dCwwKQkvKiBVLWJvb3QgZW50cnkgcG9pbnQgKi8KCVJWRUNFTlQocmVzZXQsMSkJLyogc29mdHdh
cmUgcmVib290ICovCiNpZiBkZWZpbmVkKENPTkZJR19JTkNBX0lQKQoJLndvcmQgSU5GSU5FT05f
RUJVX0JPT1RDRkcgLyogRUJVIGluaXQgY29kZSwgZmV0Y2hlZCBkdXJpbmcgYm9vdGluZyAqLwoJ
LndvcmQgMHgwMDAwMDAwMCAgICAgICAgICAgLyogcGhhc2Ugb2YgdGhlIGZsYXNoICAgICAgICAg
ICAgICAgICAgICAqLwojZWxpZiBkZWZpbmVkKENPTkZJR19QVVJQTEUpCgkud29yZCBJTkZJTkVP
Tl9FQlVfQk9PVENGRyAvKiBFQlUgaW5pdCBjb2RlLCBmZXRjaGVkIGR1cmluZyBib290aW5nICov
Cgkud29yZCBJTkZJTkVPTl9FQlVfQk9PVENGRyAvKiBFQlUgaW5pdCBjb2RlLCBmZXRjaGVkIGR1
cmluZyBib290aW5nICovCiNlbHNlCglSVkVDRU5UKHJvbVJlc2VydmVkLDIpCiNlbmRpZgoJUlZF
Q0VOVChyb21SZXNlcnZlZCwzKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw0KQoJUlZFQ0VOVChyb21S
ZXNlcnZlZCw1KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw2KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw3
KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw4KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw5KQoJUlZFQ0VO
VChyb21SZXNlcnZlZCwxMCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTEpCglSVkVDRU5UKHJvbVJl
c2VydmVkLDEyKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMykKCVJWRUNFTlQocm9tUmVzZXJ2ZWQs
MTQpCglSVkVDRU5UKHJvbVJlc2VydmVkLDE1KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxNikKCVJW
RUNFTlQocm9tUmVzZXJ2ZWQsMTcpCglSVkVDRU5UKHJvbVJlc2VydmVkLDE4KQoJUlZFQ0VOVChy
b21SZXNlcnZlZCwxOSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMjApCglSVkVDRU5UKHJvbVJlc2Vy
dmVkLDIxKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwyMikKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMjMp
CglSVkVDRU5UKHJvbVJlc2VydmVkLDI0KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwyNSkKCVJWRUNF
TlQocm9tUmVzZXJ2ZWQsMjYpCglSVkVDRU5UKHJvbVJlc2VydmVkLDI3KQoJUlZFQ0VOVChyb21S
ZXNlcnZlZCwyOCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMjkpCglSVkVDRU5UKHJvbVJlc2VydmVk
LDMwKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwzMSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMzIpCglS
VkVDRU5UKHJvbVJlc2VydmVkLDMzKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwzNCkKCVJWRUNFTlQo
cm9tUmVzZXJ2ZWQsMzUpCglSVkVDRU5UKHJvbVJlc2VydmVkLDM2KQoJUlZFQ0VOVChyb21SZXNl
cnZlZCwzNykKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMzgpCglSVkVDRU5UKHJvbVJlc2VydmVkLDM5
KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw0MCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNDEpCglSVkVD
RU5UKHJvbVJlc2VydmVkLDQyKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw0MykKCVJWRUNFTlQocm9t
UmVzZXJ2ZWQsNDQpCglSVkVDRU5UKHJvbVJlc2VydmVkLDQ1KQoJUlZFQ0VOVChyb21SZXNlcnZl
ZCw0NikKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNDcpCglSVkVDRU5UKHJvbVJlc2VydmVkLDQ4KQoJ
UlZFQ0VOVChyb21SZXNlcnZlZCw0OSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNTApCglSVkVDRU5U
KHJvbVJlc2VydmVkLDUxKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw1MikKCVJWRUNFTlQocm9tUmVz
ZXJ2ZWQsNTMpCglSVkVDRU5UKHJvbVJlc2VydmVkLDU0KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw1
NSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNTYpCglSVkVDRU5UKHJvbVJlc2VydmVkLDU3KQoJUlZF
Q0VOVChyb21SZXNlcnZlZCw1OCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNTkpCglSVkVDRU5UKHJv
bVJlc2VydmVkLDYwKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw2MSkKCVJWRUNFTlQocm9tUmVzZXJ2
ZWQsNjIpCglSVkVDRU5UKHJvbVJlc2VydmVkLDYzKQoJWFZFQ0VOVChyb21FeGNIYW5kbGUsMHgy
MDApCS8qIGJmYzAwMjAwOiBSNDAwMCB0bGJtaXNzIHZlY3RvciAqLwoJUlZFQ0VOVChyb21SZXNl
cnZlZCw2NSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNjYpCglSVkVDRU5UKHJvbVJlc2VydmVkLDY3
KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw2OCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNjkpCglSVkVD
RU5UKHJvbVJlc2VydmVkLDcwKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw3MSkKCVJWRUNFTlQocm9t
UmVzZXJ2ZWQsNzIpCglSVkVDRU5UKHJvbVJlc2VydmVkLDczKQoJUlZFQ0VOVChyb21SZXNlcnZl
ZCw3NCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNzUpCglSVkVDRU5UKHJvbVJlc2VydmVkLDc2KQoJ
UlZFQ0VOVChyb21SZXNlcnZlZCw3NykKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsNzgpCglSVkVDRU5U
KHJvbVJlc2VydmVkLDc5KQoJWFZFQ0VOVChyb21FeGNIYW5kbGUsMHgyODApCS8qIGJmYzAwMjgw
OiBSNDAwMCB4dGxibWlzcyB2ZWN0b3IgKi8KCVJWRUNFTlQocm9tUmVzZXJ2ZWQsODEpCglSVkVD
RU5UKHJvbVJlc2VydmVkLDgyKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw4MykKCVJWRUNFTlQocm9t
UmVzZXJ2ZWQsODQpCglSVkVDRU5UKHJvbVJlc2VydmVkLDg1KQoJUlZFQ0VOVChyb21SZXNlcnZl
ZCw4NikKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsODcpCglSVkVDRU5UKHJvbVJlc2VydmVkLDg4KQoJ
UlZFQ0VOVChyb21SZXNlcnZlZCw4OSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsOTApCglSVkVDRU5U
KHJvbVJlc2VydmVkLDkxKQoJUlZFQ0VOVChyb21SZXNlcnZlZCw5MikKCVJWRUNFTlQocm9tUmVz
ZXJ2ZWQsOTMpCglSVkVDRU5UKHJvbVJlc2VydmVkLDk0KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw5
NSkKCVhWRUNFTlQocm9tRXhjSGFuZGxlLDB4MzAwKQkvKiBiZmMwMDMwMDogUjQwMDAgY2FjaGUg
dmVjdG9yICovCglSVkVDRU5UKHJvbVJlc2VydmVkLDk3KQoJUlZFQ0VOVChyb21SZXNlcnZlZCw5
OCkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsOTkpCglSVkVDRU5UKHJvbVJlc2VydmVkLDEwMCkKCVJW
RUNFTlQocm9tUmVzZXJ2ZWQsMTAxKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMDIpCglSVkVDRU5U
KHJvbVJlc2VydmVkLDEwMykKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTA0KQoJUlZFQ0VOVChyb21S
ZXNlcnZlZCwxMDUpCglSVkVDRU5UKHJvbVJlc2VydmVkLDEwNikKCVJWRUNFTlQocm9tUmVzZXJ2
ZWQsMTA3KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMDgpCglSVkVDRU5UKHJvbVJlc2VydmVkLDEw
OSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTEwKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMTEpCglY
VkVDRU5UKHJvbUV4Y0hhbmRsZSwweDM4MCkJLyogYmZjMDAzODA6IFI0MDAwIGdlbmVyYWwgdmVj
dG9yICovCglSVkVDRU5UKHJvbVJlc2VydmVkLDExMykKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTE0
KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMTUpCglSVkVDRU5UKHJvbVJlc2VydmVkLDExNikKCVJW
RUNFTlQocm9tUmVzZXJ2ZWQsMTE2KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMTgpCglSVkVDRU5U
KHJvbVJlc2VydmVkLDExOSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTIwKQoJUlZFQ0VOVChyb21S
ZXNlcnZlZCwxMjEpCglSVkVDRU5UKHJvbVJlc2VydmVkLDEyMikKCVJWRUNFTlQocm9tUmVzZXJ2
ZWQsMTIzKQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMjQpCglSVkVDRU5UKHJvbVJlc2VydmVkLDEy
NSkKCVJWRUNFTlQocm9tUmVzZXJ2ZWQsMTI2KQoJUlZFQ0VOVChyb21SZXNlcnZlZCwxMjcpCgoJ
LyogV2UgaG9wZSB0aGVyZSBhcmUgbm8gbW9yZSByZXNlcnZlZCB2ZWN0b3JzIQoJICogMTI4ICog
OCA9PSAxMDI0ID09IDB4NDAwCgkgKiBzbyB0aGlzIGlzIGFkZHJlc3MgUl9WRUMrMHg0MDAgPT0g
MHhiZmMwMDQwMAoJICovCiNpZmRlZiBDT05GSUdfUFVSUExFCi8qIDB4YmZjMDA0MDAgKi8KCS53
b3JkCTB4ZGM4NzAwMDAKCS53b3JkCTB4ZmNhNzAwMDAKCS53b3JkCTB4MjA4NDAwMDgKCS53b3Jk
CTB4MjBhNTAwMDgKCS53b3JkCTB4MjBjNmZmZmYKCS53b3JkCTB4MTRjMGZmZmEKCS53b3JkCTB4
MDAwMDAwMDAKCS53b3JkCTB4MDNlMDAwMDgKCS53b3JkCTB4MDAwMDAwMDAKCS53b3JkCTB4MDAw
MDAwMDAKLyogMHhiZmMwMDQyOCAqLwoJLndvcmQJMHhkYzg3MDAwMAoJLndvcmQJMHhmY2E3MDAw
MAoJLndvcmQJMHgyMDg0MDAwOAoJLndvcmQJMHgyMGE1MDAwOAoJLndvcmQJMHgyMGM2ZmZmZgoJ
LndvcmQJMHgxNGMwZmZmYQoJLndvcmQJMHgwMDAwMDAwMAoJLndvcmQJMHgwM2UwMDAwOAoJLndv
cmQJMHgwMDAwMDAwMAoJLndvcmQJMHgwMDAwMDAwMAojZW5kaWYgLyogQ09ORklHX1BVUlBMRSAq
LwoJLmFsaWduIDQKcmVzZXQ6CgoJLyogQ2xlYXIgd2F0Y2ggcmVnaXN0ZXJzLgoJICovCgltdGMw
CXplcm8sIENQMF9XQVRDSExPCgltdGMwCXplcm8sIENQMF9XQVRDSEhJCgoJLyogV1AoV2F0Y2gg
UGVuZGluZyksIFNXMC8xIHNob3VsZCBiZSBjbGVhcmVkLiAqLwoJbXRjMAl6ZXJvLCBDUDBfQ0FV
U0UKCglzZXR1cF9jMF9zdGF0dXNfcmVzZXQKCgkvKiBJbml0IFRpbWVyICovCgltdGMwCXplcm8s
IENQMF9DT1VOVAoJbXRjMAl6ZXJvLCBDUDBfQ09NUEFSRQoKLyojaWYgIWRlZmluZWQoQ09ORklH
X1NLSVBfTE9XTEVWRUxfSU5JVCkqLwoJLyogQ09ORklHMCByZWdpc3RlciAqLwoJbGkJdDAsIENP
TkZfQ01fVU5DQUNIRUQKCW10YzAJdDAsIENQMF9DT05GSUcKLyojZW5kaWYqLyAvKiAhQ09ORklH
X1NLSVBfTE9XTEVWRUxfSU5JVCAqLwoKCS8qIEluaXRpYWxpemUgJGdwLgoJICovCgliYWwJMWYK
CW5vcAoJLndvcmQJX2dwCjE6CglsdwlncCwgMChyYSkKCi8qI2lmICFkZWZpbmVkKENPTkZJR19T
S0lQX0xPV0xFVkVMX0lOSVQpKi8KCS8qIEluaXRpYWxpemUgYW55IGV4dGVybmFsIG1lbW9yeS4K
CSAqLwoJbGEJdDksIGxvd2xldmVsX2luaXQKCWphbHIJdDkKCW5vcAoKCS8qIEluaXRpYWxpemUg
Y2FjaGVzLi4uCgkgKi8KCWxhCXQ5LCBtaXBzX2NhY2hlX3Jlc2V0CglqYWxyCXQ5Cglub3AKCgkv
KiAuLi4gYW5kIGVuYWJsZSB0aGVtLgoJICovCglsaQl0MCwgQ09ORl9DTV9DQUNIQUJMRV9OT05D
T0hFUkVOVAoJbXRjMAl0MCwgQ1AwX0NPTkZJRwovKiNlbmRpZiovIC8qICFDT05GSUdfU0tJUF9M
T1dMRVZFTF9JTklUICovCgoJLyogU2V0IHVwIHRlbXBvcmFyeSBzdGFjay4KCSAqLwojaWZkZWYg
Q09ORklHX1NZU19JTklUX1JBTV9MT0NLX01JUFMKCWxpCWEwLCBDT05GSUdfU1lTX0lOSVRfU1Bf
T0ZGU0VUCglsYQl0OSwgbWlwc19jYWNoZV9sb2NrCglqYWxyCXQ5Cglub3AKI2VuZGlmCgoJbGkJ
dDAsIENPTkZJR19TWVNfU0RSQU1fQkFTRSArIENPTkZJR19TWVNfSU5JVF9TUF9PRkZTRVQKCWxh
CXNwLCAwKHQwKQoKCWxhCXQ5LCBib2FyZF9pbml0X2YKCWpyCXQ5Cglub3AKCi8qCiAqIHZvaWQg
cmVsb2NhdGVfY29kZSAoYWRkcl9zcCwgZ2QsIGFkZHJfbW9uaSkKICoKICogVGhpcyAiZnVuY3Rp
b24iIGRvZXMgbm90IHJldHVybiwgaW5zdGVhZCBpdCBjb250aW51ZXMgaW4gUkFNCiAqIGFmdGVy
IHJlbG9jYXRpbmcgdGhlIG1vbml0b3IgY29kZS4KICoKICogYTAgPSBhZGRyX3NwCiAqIGExID0g
Z2QKICogYTIgPSBkZXN0aW5hdGlvbiBhZGRyZXNzCiAqLwoJLmdsb2JsCXJlbG9jYXRlX2NvZGUK
CS5lbnQJcmVsb2NhdGVfY29kZQpyZWxvY2F0ZV9jb2RlOgoJbW92ZQlzcCwgYTAJCS8qIFNldCBu
ZXcgc3RhY2sgcG9pbnRlcgkqLwoKCWxpCXQwLCBDT05GSUdfU1lTX01PTklUT1JfQkFTRQoJbGEJ
dDMsIGluX3JhbQoJbHcJdDIsIC0xMih0MykJLyogdDIgPC0tIHVib290X2VuZF9kYXRhCSovCglt
b3ZlCXQxLCBhMgoJbW92ZQlzMiwgYTIJCS8qIHMyIDwtLSBkZXN0aW5hdGlvbiBhZGRyZXNzCSov
CgoJLyoKCSAqIEZpeCAkZ3A6CgkgKgoJICogTmV3ICRncCA9IChPbGQgJGdwIC0gQ09ORklHX1NZ
U19NT05JVE9SX0JBU0UpICsgRGVzdGluYXRpb24gQWRkcmVzcwoJICovCgltb3ZlCXQ2LCBncAoJ
c3ViCWdwLCBDT05GSUdfU1lTX01PTklUT1JfQkFTRQoJYWRkCWdwLCBhMgkJLyogZ3Agbm93IGFk
anVzdGVkCQkqLwoJc3ViCXMxLCBncCwgdDYJLyogczEgPC0tIHJlbG9jYXRpb24gb2Zmc2V0CSov
CgoJLyoKCSAqIHQwID0gc291cmNlIGFkZHJlc3MKCSAqIHQxID0gdGFyZ2V0IGFkZHJlc3MKCSAq
IHQyID0gc291cmNlIGVuZCBhZGRyZXNzCgkgKi8KCgkvKgoJICogU2F2ZSBkZXN0aW5hdGlvbiBh
ZGRyZXNzIGFuZCBzaXplIGZvciBsYXRlciB1c2FnZSBpbiBmbHVzaF9jYWNoZSgpCgkgKi8KCW1v
dmUJczAsIGExCQkvKiBzYXZlIGdkIGluIHMwCQkqLwoJbW92ZQlhMCwgdDEJCS8qIGEwIDwtLSBk
ZXN0aW5hdGlvbiBhZGRyCSovCglzdWIJYTEsIHQyLCB0MAkvKiBhMSA8LS0gc2l6ZQkJCSovCgoJ
LyogT24gdGhlIHB1cnBsZSBib2FyZCB3ZSBjb3B5IHRoZSBjb2RlIGVhcmxpZXIgaW4gYSBzcGVj
aWFsIHdheQoJICogaW4gb3JkZXIgdG8gc29sdmUgZmxhc2ggcHJvYmxlbXMKCSAqLwojaWZuZGVm
IENPTkZJR19QVVJQTEUKMToKCWx3CXQzLCAwKHQwKQoJc3cJdDMsIDAodDEpCglhZGR1CXQwLCA0
CglibGUJdDAsIHQyLCAxYgoJYWRkdQl0MSwgNAkJLyogZGVsYXkgc2xvdAkJCSovCiNlbmRpZgoK
CS8qIElmIGNhY2hlcyB3ZXJlIGVuYWJsZWQsIHdlIHdvdWxkIGhhdmUgdG8gZmx1c2ggdGhlbSBo
ZXJlLgoJICovCgoJLyogYTAgJiBhMSBhcmUgYWxyZWFkeSBzZXQgdXAgZm9yIGZsdXNoX2NhY2hl
KHN0YXJ0LCBzaXplKSAqLwoJbGEJdDksIGZsdXNoX2NhY2hlCglqYWxyCXQ5Cglub3AKCgkvKiBK
dW1wIHRvIHdoZXJlIHdlJ3ZlIHJlbG9jYXRlZCBvdXJzZWx2ZXMuCgkgKi8KCWFkZGkJdDAsIHMy
LCBpbl9yYW0gLSBfc3RhcnQKCWpyCXQwCglub3AKCgkud29yZAlfZ3AKCS53b3JkCV9HTE9CQUxf
T0ZGU0VUX1RBQkxFXwoJLndvcmQJdWJvb3RfZW5kX2RhdGEKCS53b3JkCXVib290X2VuZAoJLndv
cmQJbnVtX2dvdF9lbnRyaWVzCgppbl9yYW06CgkvKgoJICogTm93IHdlIHdhbnQgdG8gdXBkYXRl
IEdPVC4KCSAqCgkgKiBHT1RbMF0gaXMgcmVzZXJ2ZWQuIEdPVFsxXSBpcyBhbHNvIHJlc2VydmVk
IGZvciB0aGUgZHluYW1pYyBvYmplY3QKCSAqIGdlbmVyYXRlZCBieSBHTlUgbGQuIFNraXAgdGhl
c2UgcmVzZXJ2ZWQgZW50cmllcyBmcm9tIHJlbG9jYXRpb24uCgkgKi8KCWx3CXQzLCAtNCh0MCkJ
LyogdDMgPC0tIG51bV9nb3RfZW50cmllcwkqLwoJbHcJdDQsIC0xNih0MCkJLyogdDQgPC0tIF9H
TE9CQUxfT0ZGU0VUX1RBQkxFXwkqLwoJbHcJdDUsIC0yMCh0MCkJLyogdDUgPC0tIF9ncAkqLwoJ
c3ViCXQ0LCB0NQkJLyogY29tcHV0ZSBvZmZzZXQqLwoJYWRkCXQ0LCB0NCwgZ3AJLyogdDQgbm93
IGhvbGRzIHJlbG9jYXRlZCBfR0xPQkFMX09GRlNFVF9UQUJMRV8JKi8KCWFkZGkJdDQsIHQ0LCA4
CS8qIFNraXBwaW5nIGZpcnN0IHR3byBlbnRyaWVzLgkqLwoJbGkJdDIsIDIKMToKCWx3CXQxLCAw
KHQ0KQoJYmVxegl0MSwgMmYKCWFkZAl0MSwgczEKCXN3CXQxLCAwKHQ0KQoyOgoJYWRkaQl0Miwg
MQoJYmx0CXQyLCB0MywgMWIKCWFkZGkJdDQsIDQJCS8qIGRlbGF5IHNsb3QJCQkqLwoKCS8qIENs
ZWFyIEJTUy4KCSAqLwoJbHcJdDEsIC0xMih0MCkJLyogdDEgPC0tIHVib290X2VuZF9kYXRhCSov
Cglsdwl0MiwgLTgodDApCS8qIHQyIDwtLSB1Ym9vdF9lbmQJCSovCglhZGQJdDEsIHMxCQkvKiBh
ZGp1c3QgcG9pbnRlcnMJCSovCglhZGQJdDIsIHMxCgoJc3ViCXQxLCA0CjE6CglhZGRpCXQxLCA0
CglibHRsCXQxLCB0MiwgMWIKCXN3CXplcm8sIDAodDEpCS8qIGRlbGF5IHNsb3QJCQkqLwoKCW1v
dmUJYTAsIHMwCQkvKiBhMCA8LS0gZ2QJCQkqLwoJbGEJdDksIGJvYXJkX2luaXRfcgoJanIJdDkK
CW1vdmUJYTEsIHMyCQkvKiBkZWxheSBzbG90CQkJKi8KCgkuZW5kCXJlbG9jYXRlX2NvZGUKCgkv
KiBFeGNlcHRpb24gaGFuZGxlcnMuCgkgKi8Kcm9tUmVzZXJ2ZWQ6CgliCXJvbVJlc2VydmVkCgpy
b21FeGNIYW5kbGU6CgliCXJvbUV4Y0hhbmRsZQo=

------_=_NextPart_001_01CAE7A5.A129BFBB
Content-Type: application/octet-stream;
	name="lowlevel_init.S"
Content-Transfer-Encoding: base64
Content-Description: lowlevel_init.S
Content-Disposition: attachment;
	filename="lowlevel_init.S"

LyogTWVtb3J5IHN1Yi1zeXN0ZW0gaW5pdGlhbGl6YXRpb24gY29kZSAqLwoKI2luY2x1ZGUgPGNv
bmZpZy5oPgojaW5jbHVkZSA8YXNtL3JlZ2RlZi5oPgojaW5jbHVkZSA8YXNtL2F1MXgwMC5oPgoj
aW5jbHVkZSA8YXNtL21pcHNyZWdzLmg+CgojZGVmaW5lIEFVMTUwMF9TWVNfQUREUgkJMHhCMTkw
MDAwMAojZGVmaW5lIHN5c19lbmRpYW4JCTB4MDAzOAojZGVmaW5lIENQMF9Db25maWcwCQkkMTYK
I2RlZmluZSBDUFVfU0NBTEUJCSgoQ09ORklHX1NZU19NSFopIC8gMTIpIC8qIENQVSBjbG9jayBp
cyBhIG11bHRpcGxlIG9mIDEyIE1IeiAqLwojZGVmaW5lIE1FTV8xTVMJCQkoKENPTkZJR19TWVNf
TUhaKSAqIDEwMDApCgoJLnRleHQKCS5zZXQgbm9yZW9yZGVyCgkuc2V0IG1pcHMzMgoKCS5nbG9i
bAlsb3dsZXZlbF9pbml0Cmxvd2xldmVsX2luaXQ6CgkvKgoJICogU3RlcCAxKSBFc3RhYmxpc2gg
Q1BVIGVuZGlhbiBtb2RlLgoJICogRGIxNTAwLXNwZWNpZmljOgoJICogU3dpdGNoIFMxLjEgT2Zm
KGJpdDcgcmVhZHMgMSkgaXMgTGl0dGxlIEVuZGlhbgoJICogU3dpdGNoIFMxLjEgT24gKGJpdDcg
cmVhZHMgMCkgaXMgQmlnIEVuZGlhbgoJICovCgovKiNpZmRlZiBDT05GSUdfREJBVTE1NTAqLwoJ
bGkJdDAsIE1FTV9TVENGRzIKCWxpCXQxLCAweDQyMmMwMWM2Cglzdwl0MSwgMCh0MCkKCglsaQl0
MCwgTUVNX1NUVElNRTIKCWxpCXQxLCAweDAyMjI0NDA3Cglzdwl0MSwgMCh0MCkKCglsaQl0MCwg
TUVNX1NUQUREUjIKCWxpCXQxLCAweDExODAzZjAwCglzdwl0MSwgMCh0MCkKLyojZWxzZSovCgls
aQl0MCwgTUVNX1NUQ0ZHMQoJbGkJdDEsIDB4MDA0MjAwNDUKCXN3CXQxLCAwKHQwKQoKCWxpCXQw
LCBNRU1fU1RUSU1FMQoJbGkJdDEsIDB4MDAwMGRkZDgKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBN
RU1fU1RBRERSMQoJbGkJdDEsIDB4MDAwMDBmZmYKCXN3CXQxLCAwKHQwKQovKiNlbmRpZiovCgoJ
LypsaQl0MCwgREIxWFgwX0JDU1JfQUREUgoJbHcJdDEsOCh0MCkKCWFuZGkJdDEsdDEsMHg4MAoJ
YmVxCXplcm8sdDEsYmlnX2VuZGlhbgoJbm9wKi8KCgoKbGl0dGxlX2VuZGlhbjoKCgkvKiBDaGFu
Z2UgQXUxIGNvcmUgdG8gbGl0dGxlIGVuZGlhbiAqLwoJbGkJdDAsIEFVMTUwMF9TWVNfQUREUgoJ
bGkJdDEsIDEJCQkJLyogY3VycmVudGx5IHNldCB0byBsaXR0bGUgZW5kaWFuKi8KCXN3CXQxLCBz
eXNfZW5kaWFuKHQwKQoJbWZjMAl0MiwgQ1AwX0NPTkZJRwoJbXRjMAl0MiwgQ1AwX0NPTkZJRwoJ
bm9wCglub3AKCgkvKiBCaWcgRW5kaWFuIGlzIGRlZmF1bHQgc28gbm90aGluZyB0byBkbyBidXQg
ZmFsbCB0aHJvdWdoICovCgpiaWdfZW5kaWFuOgoKCS8qCgkgKiBTdGVwIDIpIEVzdGFibGlzaCBT
dGF0dXMgUmVnaXN0ZXIKCSAqIChzZXQgQkVWLCBjbGVhciBFUkwsIGNsZWFyIEVYTCwgY2xlYXIg
SUUpCgkgKi8KCWxpCXQxLCAweDAwNDAwMDAwCgltdGMwCXQxLCBDUDBfU1RBVFVTCgoJLyoKCSAq
IFN0ZXAgMykgRXN0YWJsaXNoIENQMCBDb25maWcwCgkgKiAoc2V0IE9ELCBzZXQgSzA9MykKCSAq
LwoJbGkJdDEsIDB4MDAwODAwMDMKCW10YzAJdDEsIENQMF9DT05GSUcKCgkvKgoJICogU3RlcCA0
KSBEaXNhYmxlIFdhdGNocG9pbnQgZmFjaWxpdGllcwoJICovCglsaSB0MSwgMHgwMDAwMDAwMAoJ
bXRjMAl0MSwgQ1AwX1dBVENITE8KCW10YzAJdDEsIENQMF9JV0FUQ0hMTwoJLyoKCSAqIFN0ZXAg
NSkgRGlzYWJsZSB0aGUgcGVyZm9ybWFuY2UgY291bnRlcnMKCSAqLwoJbXRjMAl6ZXJvLCBDUDBf
UEVSRk9STUFOQ0UKCW5vcAoKCS8qCgkgKiBTdGVwIDYpIEVzdGFibGlzaCBFSlRBRyBEZWJ1ZyBy
ZWdpc3RlcgoJICovCgltdGMwCXplcm8sIENQMF9ERUJVRwoJbm9wCgoJLyoKCSAqIFN0ZXAgNykg
RXN0YWJsaXNoIENhdXNlCgkgKiAoc2V0IElWIGJpdCkKCSAqLwoJbGkJdDEsIDB4MDA4MDAwMDAK
CW10YzAJdDEsIENQMF9DQVVTRQoKCS8qIEVzdGFibGlzaCBXaXJlZCAoYW5kIFJhbmRvbSkgKi8K
CW10YzAJemVybywgQ1AwX1dJUkVECglub3AKI3dhcm5pbmcgImFtIG91dHNpZGUgb2YgY2FjaGUg
YW5kIFRMQiIKI2lmZGVmIENPTkZJR19EQkFVMTU1MAojd2FybmluZyAiIGFtIGluc2lkZSBvZiBj
YWNoZSBhbmQgVExCICIKCS8qIE5vIHdvcmthcm91bmQgaWYgcnVubmluZyBmcm9tIHJhbSAqLwoJ
LypsdWkJdDAsIDB4ZmZjMAoJbHVpCXQzLCAweGJmYzAKCWFuZAl0MSwgcmEsIHQwCglibmUJdDEs
IHQzLCBub0NhY2hlSnVtcAoJbm9wKi8gIC8qY29tbWVudGVkIGhlcmUgYnkgcmVmZXJyaW5nIFlB
TU9OICovCgoJLyoqKiBGcm9tIEFNRCBZQU1PTiAqKiovCgkvKgoJICogU3RlcCA4KSBJbml0aWFs
aXplIHRoZSBjYWNoZXMKCSAqLwoJbGkJCXQwLCAoMTYqMTAyNCkKCWxpCQl0MSwgMzIKCWxpCQl0
MiwgMHg4MDAwMDAwMAoJYWRkdQl0MywgdDAsIHQyCmNhY2hlbG9vcDoKCWNhY2hlCTAsIDAodDIp
CgljYWNoZQkxLCAwKHQyKQoJYWRkdQl0MiwgdDEKCWJuZQkJdDIsIHQzLCBjYWNoZWxvb3AKCW5v
cAoKCS8qIFNhdmUgcmV0dXJuIGFkZHJlc3MgKi8KCW1vdmUJCXQzLCByYQoKCS8qIFJ1biBmcm9t
IGNhY2hlYWJsZSBzcGFjZSBub3cgKi8KCWJhbAkJY2FjaGVoZXJlCglub3AKY2FjaGVoZXJlOgoJ
bGkJCXQxLCB+MHgyMDAwMDAwMCAvKiBjb252ZXJ0IHRvIEtTRUcwICovCglhbmQJCXQwLCByYSwg
dDEKCWFkZGkJdDAsIDUqNAkJCS8qIDUgaW5zbnMgYmV5b25kIGNhY2hlaGVyZSAqLwoJanIJCXQw
Cglub3AKCgkvKiBSZXN0b3JlIHJldHVybiBhZGRyZXNzICovCgltb3ZlCQlyYSwgdDMKCgkvKgoJ
ICogU3RlcCA5KSBJbml0aWFsaXplIHRoZSBUTEIKCSAqLwoJbGkJCXQwLCAwCQkJIyBpbmRleCB2
YWx1ZQoJbGkJCXQxLCAweDAwMDAwMDAwCQkjIGVudHJ5aGkgdmFsdWUKCWxpCQl0MiwgMzIJCQkj
IDMyIGVudHJpZXMKCnRsYmxvb3A6CgkvKiBQcm9iZSBUTEIgZm9yIG1hdGNoaW5nIEVudHJ5SGkg
Ki8KCW10YzAJdDEsIENQMF9FTlRSWUhJCgl0bGJwCglub3AKCgkvKiBFeGFtaW5lIEluZGV4W1Bd
LCAxPW5vIG1hdGNoaW5nIGVudHJ5ICovCgltZmMwCXQzLCBDUDBfSU5ERVgKCWxpCXQ0LCAweDgw
MDAwMDAwCglhbmQJdDMsIHQ0LCB0MwoJYWRkaXUJdDEsIHQxLCAxCQkjIGluY3JlbWVudCB0MSAo
YXNpZCkKCWJlcQl6ZXJvLCB0MywgdGxibG9vcAoJbm9wCgoJLyogSW5pdGlhbGl6ZSB0aGUgVExC
IGVudHJ5ICovCgltdGMwCXQwLCBDUDBfSU5ERVgKCW10YzAJemVybywgQ1AwX0VOVFJZTE8wCglt
dGMwCXplcm8sIENQMF9FTlRSWUxPMQoJbXRjMAl6ZXJvLCBDUDBfUEFHRU1BU0sKCXRsYndpCgoJ
LyogRG8gaXQgYWdhaW4gKi8KCWFkZGl1CXQwLCB0MCwgMQoJYm5lCXQwLCB0MiwgdGxibG9vcAoJ
bm9wCgojZW5kaWYgLyogQ09ORklHX0RCQVUxNTUwICovCgoJLyogRmlyc3Qgc2V0dXAgcGxsOnMg
dG8gbWFrZSBzZXJpYWwgd29yayBvayAqLwoJLyogV2UgaGF2ZSBhIDEyIE1IeiBjcnlzdGFsICov
CglsaQl0MCwgU1lTX0NQVVBMTAoJbGkJdDEsIENQVV9TQ0FMRSAgLyogQ1BVIGNsb2NrICovCglz
dwl0MSwgMCh0MCkKCXN5bmMKCW5vcAoJbm9wCgoJLyogd2FpdCAxbVMgZm9yIGNsb2NrcyB0byBz
ZXR0bGUgKi8KCWxpCXQxLCBNRU1fMU1TCjE6CWFkZAl0MSwgLTEKCWJuZQl0MSwgemVybywgMWIK
CW5vcAoJLyogU2V0dXAgQVVYIFBMTCAqLwoJbGkJdDAsIFNZU19BVVhQTEwKCWxpCXQxLCAweDEw
IC8qIDk2IE1IeiAqLyAgLyogY2hhbmdlZCBmb3IgYXUxMzUwKi8KCXN3CXQxLCAwKHQwKSAvKiBh
dXggcGxsICovCglzeW5jCgojaWZkZWYgQ09ORklHX0RCQVUxNTUwCgkvKiAgU3RhdGljIG1lbW9y
eSBjb250cm9sbGVyICovCgkvKiBSQ0UwIC0gY2FuIG5vdCBjaGFuZ2Ugd2hpbGUgZmV0Y2hpbmcs
IGRvIHNvIGZyb20gaWNhY2hlICovCgltb3ZlCQl0MiwgcmEgLyogU3RvcmUgcmV0dXJuIGFkZHJl
c3MgKi8KCWJhbAkJZ2V0QWRkcgoJbm9wCgpnZXRBZGRyOgoJbW92ZQkJdDEsIHJhCgltb3ZlCQly
YSwgdDIgLyogTW92ZSByZXR1cm4gYWRkZXNzIGJhY2sgKi8KCgljYWNoZQkweDE0LDAodDEpCglj
YWNoZQkweDE0LDMyKHQxKQoJLyoqKiAvRnJvbSBZQU1PTiAqKiovCgpub0NhY2hlSnVtcDoKI2Vu
ZGlmIC8qIENPTkZJR19EQkFVMTU1MCAqLwoKI2lmZGVmIENPTkZJR19EQkFVMTU1MAoJbGkJdDAs
IE1FTV9TVFRJTUUwCglsaQl0MSwgMHgwYmIyYzM2NwoJc3cJdDEsIDAodDApCgoJLyogUkNFMCBB
TUQgTWlycm9yQml0IEZsYXNoICg/KSAqLyAvKk1UMjlXMTYwRVQqLwoJbGkJdDAsIE1FTV9TVENG
RzAKCWxpCXQxLCAweDIwMmQwMDQzCglzdwl0MSwgMCh0MCkKCglsaQl0MCwgTUVNX1NUQUREUjAK
CWxpCXQxLCAweDExYzAzZjAwCglzdwl0MSwgMCh0MCkKI2Vsc2UgLyogQ09ORklHX0RCQVUxNTUw
ICovCglsaQl0MCwgTUVNX1NUVElNRTAKCWxpCXQxLCAweDBiYjJjMzY3Cglzdwl0MSwgMCh0MCkK
CgkvKiBSQ0UwIEFNRCAyOUxWNjQwTSBNaXJyb3JCaXQgRmxhc2ggKi8gLyogTVQyOVcxNjBFVCAq
LwoJbGkJdDAsIE1FTV9TVENGRzAKCWxpCXQxLCAweDIwMmQwMDQzCglzdwl0MSwgMCh0MCkKCgls
aQl0MCwgTUVNX1NUQUREUjAKCWxpCXQxLCAweDExYzAzZjAwCglzdwl0MSwgMCh0MCkKI2VuZGlm
IC8qIENPTkZJR19EQkFVMTU1MCAqLwoKCS8qKiBTYW1zdW5nIEtMTThHMkVFIEhNIC0gOEdCKiov
CglsaQl0MCwgTUVNX1NUQ0ZHMQoJbGkJdDEsIDB4MDA0MjAwNDUKCXN3CXQxLCAwKHQwKQoKCWxp
CXQwLCBNRU1fU1RUSU1FMQoJbGkJdDEsIDB4MDAwMGRkZDgKCXN3CXQxLCAwKHQwKQoKCWxpCXQw
LCBNRU1fU1RBRERSMQoJbGkJdDEsIDB4MDAwMDBmZmYKCXN3CXQxLCAwKHQwKQoKI2lmZGVmIENP
TkZJR19EQkFVMTU1MAoJLyogUkNFMiBDUExEIEJvYXJkIExvZ2ljICovCglsaQl0MCwgTUVNX1NU
Q0ZHMgoJbGkJdDEsIDB4NDIyYzAxYzYKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU1RUSU1F
MgoJbGkJdDEsIDB4MDIyMjQ0MDcKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU1RBRERSMgoJ
bGkJdDEsIDB4MTE4MDNmMDAKCXN3CXQxLCAwKHQwKQojZWxzZQoJbGkJdDAsIE1FTV9TVENGRzIK
CWxpCXQxLCAweDQyMmMwMWM2Cglzdwl0MSwgMCh0MCkKCglsaQl0MCwgTUVNX1NUVElNRTIKCWxp
CXQxLCAweDAyMjI0NDA3Cglzdwl0MSwgMCh0MCkKCglsaQl0MCwgTUVNX1NUQUREUjIKCWxpCXQx
LCAweDExODAzZjAwCglzdwl0MSwgMCh0MCkKI2VuZGlmCgoJLyogUkNFMyBQQ01DSUEgMjUwbnMg
Ki8KCWxpCXQwLCBNRU1fU1RDRkczCglsaQl0MSwgMHgwMDA0MDA0MgoJc3cJdDEsIDAodDApCgoJ
bGkJdDAsIE1FTV9TVFRJTUUzCglsaQl0MSwgMHg1MDIwOGJmMAoJc3cJdDEsIDAodDApCgoJbGkJ
dDAsIE1FTV9TVEFERFIzCglsaQl0MSwgMHgxMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJc3luYwoK
CS8qIFNldCBwZXJpcGhlcmFscyB0byBhIGtub3duIHN0YXRlICovCglsaQl0MCwgSUMwX0NGRzBD
TFIKCWxpCXQxLCAweEZGRkZGRkZGCglzdwl0MSwgMCh0MCkKCglsaQl0MCwgSUMwX0NGRzBDTFIK
CXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBJQzBfQ0ZHMUNMUgoJc3cJdDEsIDAodDApCgoJbGkJdDAs
IElDMF9DRkcyQ0xSCglzdwl0MSwgMCh0MCkKCglsaQl0MCwgSUMwX1NSQ1NFVAoJc3cJdDEsIDAo
dDApCgoJbGkJdDAsIElDMF9BU1NJR05TRVQKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBJQzBfV0FL
RUNMUgoJc3cJdDEsIDAodDApCgoJbGkJdDAsIElDMF9SSVNJTkdDTFIKCXN3CXQxLCAwKHQwKQoK
CWxpCXQwLCBJQzBfRkFMTElOR0NMUgoJc3cJdDEsIDAodDApCgoJbGkJdDAsIElDMF9URVNUQklU
CglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIElDMV9DRkcw
Q0xSCglsaQl0MSwgMHhGRkZGRkZGRgoJc3cJdDEsIDAodDApCgoJbGkJdDAsIElDMV9DRkcwQ0xS
Cglzdwl0MSwgMCh0MCkKCglsaQl0MCwgSUMxX0NGRzFDTFIKCXN3CXQxLCAwKHQwKQoKCWxpCXQw
LCBJQzFfQ0ZHMkNMUgoJc3cJdDEsIDAodDApCgoJbGkJdDAsIElDMV9TUkNTRVQKCXN3CXQxLCAw
KHQwKQoKCWxpCXQwLCBJQzFfQVNTSUdOU0VUCglzdwl0MSwgMCh0MCkKCglsaQl0MCwgSUMxX1dB
S0VDTFIKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBJQzFfUklTSU5HQ0xSCglzdwl0MSwgMCh0MCkK
CglsaQl0MCwgSUMxX0ZBTExJTkdDTFIKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBJQzFfVEVTVEJJ
VAoJbGkJdDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoJc3luYwoKCWxpCXQwLCBTWVNfRlJF
UUNUUkwwCglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJbGkJdDAsIFNZU19GUkVR
Q1RSTDEKCWxpCXQxLCAweDAwMDAwMDAwCglzdwl0MSwgMCh0MCkKCglsaQl0MCwgU1lTX0NMS1NS
QwoJbGkJdDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBTWVNfUElOSU5QVVRF
TgoJbGkJdDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoJc3luYwoKCWxpCXQwLCAweEIxMTAw
MTAwCglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJbGkJdDAsIDB4QjE0MDAxMDAK
CWxpCXQxLCAweDAwMDAwMDAwCglzdwl0MSwgMCh0MCkKCgoJbGkJdDAsIFNZU19XQUtFTVNLCgls
aQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJbGkJdDAsIFNZU19XQUtFU1JDCglsaQl0
MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJLyogd2FpdCAxbVMgYmVmb3JlIHNldHVwICov
CglsaQl0MSwgTUVNXzFNUwoxOglhZGQJdDEsIC0xCglibmUJdDEsIHplcm8sIDFiCglub3AKCiNp
ZmRlZiBDT05GSUdfREJBVTE1NTAKLyogU0RDUyAwLDEsMiBERFIgU0RSQU0gKi8KCWxpCXQwLCBN
RU1fU0RNT0RFMAoJbGkJdDEsIDB4NGEyZDQzYjYKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1f
U0RNT0RFMQoJbGkJdDEsIDB4NGEyZDQzYjYKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU0RN
T0RFMgoJbGkJdDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU0RBRERS
MAoJbGkJdDEsIDB4MjMzMDAzYzAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU0RBRERSMQoJ
bGkJdDEsIDB4MjMzMDAzYzAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU0RBRERSMgoJbGkJ
dDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoKCXN5bmMKCglsaQl0MCwgTUVNX1NEQ09ORklH
QQoJbGkJdDEsIDB4YjJhMDA1NDAgLyogUHJvZ3JhbSByZWZyZXNoIC0gZGlzYWJsZWQgKi8KCXN3
CXQxLCAwKHQwKQoJc3luYwoKCWxpCXQwLCBNRU1fU0RDT05GSUdCCglsaQl0MSwgMHhiMDAwNjE0
YwoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIE1FTV9TRFBSRUNNRCAvKiBQcmVjaGFyZ2Ug
YWxsICovCglsaQl0MSwgMAoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIE1FTV9TRFdSTUQw
CglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIE1FTV9TRFdS
TUQxCglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIE1FTV9T
RFdSTUQyCglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAsIE1F
TV9TRFdSTUQwCglsaQl0MSwgMHgwMDAwMDA2MwoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJdDAs
IE1FTV9TRFdSTUQxCglsaQl0MSwgMHgwMDAwMDA2MwoJc3cJdDEsIDAodDApCglzeW5jCgoJbGkJ
dDAsIE1FTV9TRFdSTUQyCglsaQl0MSwgMHgwMDAwMDA2MwoJc3cJdDEsIDAodDApCglzeW5jCgoJ
bGkJdDAsIE1FTV9TRFBSRUNNRCAvKiBQcmVjaGFyZ2UgYWxsICovCglzdwl6ZXJvLCAwKHQwKQoJ
c3luYwoKCS8qIElzc3VlIDIgYXV0b3JlZiAqLwoJbGkJdDAsIE1FTV9TREFVVE9SRUYKCXN3CXpl
cm8sIDAodDApCglzeW5jCgoJbGkJdDAsIE1FTV9TREFVVE9SRUYKCXN3CXplcm8sIDAodDApCglz
eW5jCgoJLyogRW5hYmxlIHJlZnJlc2ggKi8KCWxpCXQwLCBNRU1fU0RDT05GSUdBCglsaQl0MSwg
MHg2NDAwMEMyNCAvKiBQcm9ncmFtIHJlZnJlc2ggLSBlbmFibGVkICovCglzdwl0MSwgMCh0MCkK
CXN5bmMKCiNlbHNlIC8qIENPTkZJR19EQkFVMTU1MCAqLwovKiBTRENTIDAsMSBTRFJBTSAqLwoJ
bGkJdDAsIE1FTV9TRE1PREUwCglsaQl0MSwgMHg0YTJkNDNiNgoJc3cJdDEsIDAodDApCgoJbGkJ
dDAsIE1FTV9TRE1PREUxCglsaQl0MSwgMHg0YTJkNDNiNgoJc3cJdDEsIDAodDApCgoJbGkJdDAs
IE1FTV9TRE1PREUyCglsaQl0MSwgMHgwMDAwMDAwMAoJc3cJdDEsIDAodDApCgoJbGkJdDAsIE1F
TV9TREFERFIwCglsaQl0MSwgMHgyMzMwMDNjMAoJc3cJdDEsIDAodDApCgoKCWxpCXQwLCBNRU1f
U0RBRERSMQoJbGkJdDEsIDB4MjMzMDAzYzAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBNRU1fU0RB
RERSMgoJbGkJdDEsIDB4MDAwMDAwMDAKCXN3CXQxLCAwKHQwKQoKCXN5bmMKCglsaQl0MCwgTUVN
X1NEUkVGQ0ZHCglsaQl0MSwgMHg2NDAwMEMyNCAvKiBEaXNhYmxlICovCglzdwl0MSwgMCh0MCkK
CXN5bmMKCglsaQl0MCwgTUVNX1NEUFJFQ01ECglzdwl6ZXJvLCAwKHQwKQoJc3luYwoKCWxpCXQw
LCBNRU1fU0RBVVRPUkVGCglzdwl6ZXJvLCAwKHQwKQoJc3luYwoJc3cJemVybywgMCh0MCkKCXN5
bmMKCglsaQl0MCwgTUVNX1NEUkVGQ0ZHCglsaQl0MSwgMHg2NjAwMEMyNCAvKiBFbmFibGUgKi8K
CXN3CXQxLCAwKHQwKQoJc3luYwoKCWxpCXQwLCBNRU1fU0RXUk1EMAoJbGkJdDEsIDB4MDAwMDAw
MzMKCXN3CXQxLCAwKHQwKQoJc3luYwoKCWxpCXQwLCBNRU1fU0RXUk1EMQoJbGkJdDEsIDB4MDAw
MDAwMzMKCXN3CXQxLCAwKHQwKQoJc3luYwoKI2VuZGlmIC8qIENPTkZJR19EQkFVMTU1MCAqLwoJ
Lyogd2FpdCAxbVMgYWZ0ZXIgc2V0dXAgKi8KCWxpCXQxLCBNRU1fMU1TCjE6CWFkZAl0MSwgLTEK
CWJuZQl0MSwgemVybywgMWIKCW5vcAoKCWxpCXQwLCBTWVNfUElORlVOQwoJbGkJdDEsIDB4MDAw
MDgwODAKCXN3CXQxLCAwKHQwKQoKCWxpCXQwLCBTWVNfVFJJT1VUQ0xSCglsaQl0MSwgMHgwMDAw
MUZGRgoJc3cJdDEsIDAodDApCgoJbGkJdDAsIFNZU19PVVRQVVRDTFIKCWxpCXQxLCAweDAwMDA4
MDAwCglzdwl0MSwgMCh0MCkKCXN5bmMKCglqcglyYQoJbm9wCg==

------_=_NextPart_001_01CAE7A5.A129BFBB--
