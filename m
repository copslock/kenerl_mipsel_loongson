Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA91929 for <linux-archive@neteng.engr.sgi.com>; Thu, 3 Jun 1999 12:51:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA07123
	for linux-list;
	Thu, 3 Jun 1999 12:48:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA14499
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 3 Jun 1999 12:47:59 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08167
	for <linux@cthulhu.engr.sgi.com>; Thu, 3 Jun 1999 12:47:54 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.0E6BC820@vera.dpo.uab.edu>; Thu, 3 Jun 1999 14:47:51 -0500
Date: Thu, 3 Jun 1999 14:57:30 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Indigo2 patch
Message-ID: <Pine.LNX.3.96.990603145441.7770B-200000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="445303055-1686834567-928439850=:7770"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--445303055-1686834567-928439850=:7770
Content-Type: TEXT/PLAIN; charset=US-ASCII


Here is the latest patch for the Indigo2, it looks good so far...
Things still left to do:
	allow 8254 timer acks (it actually works on the Indigo2)
	clean up IRQ data structure
	enable 2nd SCSI controller

I am going to work on these once I get back from USENIX.	

-Andrew

--445303055-1686834567-928439850=:7770
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="indigo2.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.990603145730.7770C@mdk187.tucc.uab.edu>
Content-Description: 

LS0tIGluZHlfaW50LmMub3JpZwlUdWUgSnVuICAxIDA3OjI3OjU4IDE5OTkN
CisrKyBpbmR5X2ludC5jCVdlZCBKdW4gIDIgMTA6NTY6NDYgMTk5OQ0KQEAg
LTUsNyArNSw5IEBADQogICoNCiAgKiBDb3B5cmlnaHQgKEMpIDE5OTYgRGF2
aWQgUy4gTWlsbGVyIChkbUBlbmdyLnNnaS5jb20pDQogICogQ29weXJpZ2h0
IChDKSAxOTk3LCAxOTk4IFJhbGYgQmFlY2hsZSAocmFsZkBnbnUub3JnKQ0K
LSAqIENvcHlyaWdodCAoQykgMTk5OSBBbmRyZXcgUi4gQmFrZXIgKGFuZHJl
d2JAdWFiLmVkdSkgLSBJbmRpZ28yIGNoYW5nZXMNCisgKiBDb3B5cmlnaHQg
KEMpIDE5OTkgQW5kcmV3IFIuIEJha2VyIChhbmRyZXdiQHVhYi5lZHUpIA0K
KyAqICAgICAgICAgICAgICAgICAgICAtIEluZGlnbzIgY2hhbmdlcw0KKyAq
ICAgICAgICAgICAgICAgICAgICAtIEludGVycnVwdCBoYW5kbGluZyBmaXhl
cw0KICAqLw0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4NCiAjaW5jbHVk
ZSA8bGludXgvaW5pdC5oPg0KQEAgLTQ0OSwxMCArNDUxLDIzIEBADQogCQlh
Y3Rpb24gPSBsb2NhbF9pcnFfYWN0aW9uW2lycV07DQogCX0NCiANCisJLyog
aWYgaXJxID09IDAsIHRoZW4gdGhlIGludGVycnVwdCBoYXMgYWxyZWFkeSBi
ZWVuIGNsZWFyZWQgKi8NCisJaWYgKCBpcnEgPT0gMCApIHsgZ290byBlbmQ7
IH0NCisJLyogaWYgYWN0aW9uID09IE5VTEwsIHRoZW4gd2UgZG8gaGF2ZSBh
IGhhbmRsZXIgZm9yIHRoZSBpcnEgKi8NCisJaWYgKCBhY3Rpb24gPT0gTlVM
TCApIHsgZ290byBub19oYW5kbGVyOyB9DQorCQ0KIAloYXJkaXJxX2VudGVy
KGNwdSk7DQogCWtzdGF0LmlycXNbMF1baXJxICsgMTZdKys7DQogCWFjdGlv
bi0+aGFuZGxlcihpcnEsIGFjdGlvbi0+ZGV2X2lkLCByZWdzKTsNCiAJaGFy
ZGlycV9leGl0KGNwdSk7DQorCWdvdG8gZW5kOw0KKw0KK25vX2hhbmRsZXI6
DQorCXByaW50aygiTm8gaGFuZGxlciBmb3IgbG9jYWwwIGlycTogJWlcbiIs
IGlycSk7DQorDQorZW5kOgkNCisJcmV0dXJuOwkNCisJDQogfQ0KIA0KIHZv
aWQgaW5keV9sb2NhbDFfaXJxZGlzcGF0Y2goc3RydWN0IHB0X3JlZ3MgKnJl
Z3MpDQpAQCAtNDczLDEwICs0ODgsMjMgQEANCiAJCWlycSA9IGxjMW1za190
b19pcnFuclttYXNrXTsNCiAJCWFjdGlvbiA9IGxvY2FsX2lycV9hY3Rpb25b
aXJxXTsNCiAJfQ0KKwkvKiBpZiBpcnEgPT0gMCwgdGhlbiB0aGUgaW50ZXJy
dXB0IGhhcyBhbHJlYWR5IGJlZW4gY2xlYXJlZCAqLw0KKwkvKiBub3Qgc3Vy
ZSBpZiBpdCBpcyBuZWVkZWQgaGVyZSwgYnV0IGl0IGlzIG5lZWRlZCBmb3Ig
bG9jYWwwICovDQorCWlmICggaXJxID09IDAgKSB7IGdvdG8gZW5kOyB9DQor
CS8qIGlmIGFjdGlvbiA9PSBOVUxMLCB0aGVuIHdlIGRvIGhhdmUgYSBoYW5k
bGVyIGZvciB0aGUgaXJxICovDQorCWlmICggYWN0aW9uID09IE5VTEwgKSB7
IGdvdG8gbm9faGFuZGxlcjsgfQ0KKwkNCiAJaGFyZGlycV9lbnRlcihjcHUp
Ow0KIAlrc3RhdC5pcnFzWzBdW2lycSArIDI0XSsrOw0KIAlhY3Rpb24tPmhh
bmRsZXIoaXJxLCBhY3Rpb24tPmRldl9pZCwgcmVncyk7DQogCWhhcmRpcnFf
ZXhpdChjcHUpOw0KKwlnb3RvIGVuZDsNCisJDQorbm9faGFuZGxlcjoNCisJ
cHJpbnRrKCJObyBoYW5kbGVyIGZvciBsb2NhbDEgaXJxOiAlaVxuIiwgaXJx
KTsNCisNCitlbmQ6CQ0KKwlyZXR1cm47CQ0KIH0NCiANCiB2b2lkIGluZHlf
YnVzZXJyb3JfaXJxKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0K
--445303055-1686834567-928439850=:7770--
