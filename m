Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5GFLWH04888
	for linux-mips-outgoing; Sat, 16 Jun 2001 08:21:32 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5GFLTZ04883
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 08:21:29 -0700
Received: from scotty.mgnet.de (pD902470A.dip.t-dialin.net [217.2.71.10])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id RAA18626
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 17:21:26 +0200 (MET DST)
Received: (qmail 17492 invoked from network); 16 Jun 2001 15:21:21 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 16 Jun 2001 15:21:21 -0000
Date: Sat, 16 Jun 2001 17:21:18 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Linux/MIPS list <linux-mips@oss.sgi.com>
cc: Ralf Baechle <ralf@oss.sgi.com>
Subject: [PATCH] Make serial console more friendly
Message-ID: <Pine.LNX.4.21.0106161714100.16303-200000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811071-2031406748-992704878=:16303"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811071-2031406748-992704878=:16303
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

after a long time of being busy and absent from Linux/MIPS
I got around hacking a bit again.
Attached is what came out of this. The patch will make it possible
to use any (supported!) speed for the serial console.
How to use: Apply against any recent 2.4 cvs kernel, compile. 
In the PROM command monitor type "setenv dbaud 38400" (now you probably
need to change the serial setup of your client, i.e. minicom) and boot the
kernel.
If you're getting strange chars at the login prompt you need
to change your getty config.

Ralf: Can you please check and apply the patch ? Thanks !
(There are also some small code beautifications in the patch)

		Enjoy !, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt

---1463811071-2031406748-992704878=:16303
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sgiserial.c-allspeed.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0106161721180.16303@spock.mgnet.de>
Content-Description: 
Content-Disposition: attachment; filename="sgiserial.c-allspeed.patch"

ZGlmZiAtTnVyIGxpbnV4Lm9yaWcvZHJpdmVycy9zZ2kvY2hhci9zZ2lzZXJp
YWwuYyBsaW51eC9kcml2ZXJzL3NnaS9jaGFyL3NnaXNlcmlhbC5jDQotLS0g
bGludXgub3JpZy9kcml2ZXJzL3NnaS9jaGFyL3NnaXNlcmlhbC5jCVRodSBK
dW4gMTQgMjA6Mjg6NDYgMjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMvc2dpL2No
YXIvc2dpc2VyaWFsLmMJU2F0IEp1biAxNiAxNzowNDowMiAyMDAxDQpAQCAt
MTMsNiArMTMsMTMgQEANCiAgKiB0aG9yb3VnaCBwYXNzIHRvIG1lcmdlIGlu
IHRoZSByZXN0IG9mIHRoZSB1cGRhdGVzLg0KICAqIEJldHRlciBzdGlsbCwg
c29tZW9uZSByZWFsbHkgb3VnaHQgdG8gbWFrZSBpdCBhIGNvbW1vbg0KICAq
IGNvZGUgbW9kdWxlIGZvciBib3RoIHBsYXRmb3Jtcy4gICBrZXZpbmtAbWlw
cy5jb20NCisgKg0KKyAqDQorICoNCisgKiAyMDAxMDYxNiAtIEtsYXVzIE5h
dW1hbm4gPHNwb2NrQG1nbmV0LmRlPiA6IE1ha2Ugc2VyaWFsIGNvbnNvbGUg
d29yayB3aXRoDQorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhbnkgc3BlZWQgLSBub3Qgb25seSA5NjAwDQorICoN
CisgKg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4gLyog
Zm9yIENPTkZJR19SRU1PVEVfREVCVUcgKi8NCkBAIC05Nyw2ICsxMDQsNyBA
QA0KIERFQ0xBUkVfVEFTS19RVUVVRSh0cV9zZXJpYWwpOw0KIA0KIHN0cnVj
dCB0dHlfZHJpdmVyIHNlcmlhbF9kcml2ZXIsIGNhbGxvdXRfZHJpdmVyOw0K
K3N0cnVjdCBjb25zb2xlICpzZ2lzZXJjb247DQogc3RhdGljIGludCBzZXJp
YWxfcmVmY291bnQ7DQogDQogLyogc2VyaWFsIHN1YnR5cGUgZGVmaW5pdGlv
bnMgKi8NCkBAIC02ODQsNyArNjkyLDcgQEANCiAJc2F2ZV9mbGFncyhmbGFn
cyk7IGNsaSgpOw0KIA0KICNpZmRlZiBTRVJJQUxfREVCVUdfT1BFTg0KLQlw
cmludGsoInN0YXJ0aW5nIHVwIHR0eXMlZCAoaXJxICVkKS4uLiIsIGluZm8t
PmxpbmUsIGluZm8tPmlycSk7DQorCXByaW50aygic3RhcnRpbmcgdXAgdHR5
cyVkIChpcnEgJWQpLi4uXG4iLCBpbmZvLT5saW5lLCBpbmZvLT5pcnEpOw0K
ICNlbmRpZg0KIA0KIAkvKg0KQEAgLTE3NzIsMTEgKzE3ODAsMTkgQEANCiAJ
CWNoYW5nZV9zcGVlZChpbmZvKTsNCiAJfQ0KIA0KKwkvKiBJZiB0aGlzIGlz
IHRoZSBzZXJpYWwgY29uc29sZSBjaGFuZ2UgdGhlIHNwZWVkIHRvIA0KKwkg
KiB0aGUgcmlnaHQgdmFsdWUNCisJICovDQorCWlmIChpbmZvLT5pc19jb25z
KSB7DQorCQlpbmZvLT50dHktPnRlcm1pb3MtPmNfY2ZsYWcgPSBzZ2lzZXJj
b24tPmNmbGFnOw0KKwkJY2hhbmdlX3NwZWVkKGluZm8pOwkJDQorCX0NCisN
CiAJaW5mby0+c2Vzc2lvbiA9IGN1cnJlbnQtPnNlc3Npb247DQogCWluZm8t
PnBncnAgPSBjdXJyZW50LT5wZ3JwOw0KIA0KICNpZmRlZiBTRVJJQUxfREVC
VUdfT1BFTg0KLQlwcmludGsoInJzX29wZW4gdHR5cyVkIHN1Y2Nlc3NmdWwu
Li4iLCBpbmZvLT5saW5lKTsNCisJcHJpbnRrKCJyc19vcGVuIHR0eXMlZCBz
dWNjZXNzZnVsLi4uXG4iLCBpbmZvLT5saW5lKTsNCiAjZW5kaWYNCiAJcmV0
dXJuIDA7DQogfQ0KQEAgLTE4MjYsOSArMTg0Miw2IEBADQogCX0NCiAJaWYo
byAmJiBpKQ0KIAkJaW8gPSAxOw0KLQlpZiAoc3MtPnpzX2JhdWQgIT0gOTU2
MikJLyogRG9uJ3QgYXNrLi4uICovDQotCQlwYW5pYygiQmFkIGNvbnNvbGUg
YmF1ZCByYXRlICVkIiwgc3MtPnpzX2JhdWQpOw0KLQ0KIA0KIAkvKiBTZXQg
ZmxhZyB2YXJpYWJsZSBmb3IgdGhpcyBwb3J0IHNvIHRoYXQgaXQgY2Fubm90
IGJlDQogCSAqIG9wZW5lZCBmb3Igb3RoZXIgdXNlcyBieSBhY2NpZGVudC4N
CkBAIC0yMDM5LDcgKzIwNTIsNiBAQA0KIHJzX2NvbnNfaG9vayhpbnQgY2hp
cCwgaW50IG91dCwgaW50IGxpbmUpDQogew0KIAlpbnQgY2hhbm5lbDsNCi0N
CiAJDQogCWlmKGNoaXApDQogCQlwYW5pYygicnNfY29uc19ob29rIGNhbGxl
ZCB3aXRoIGNoaXAgbm90IHplcm8iKTsNCkBAIC0yMTI0LDExICsyMTM2LDEx
IEBADQogc3RhdGljIGludCBfX2luaXQgenNfY29uc29sZV9zZXR1cChzdHJ1
Y3QgY29uc29sZSAqY29uLCBjaGFyICpvcHRpb25zKQ0KIHsNCiAJc3RydWN0
IHNnaV9zZXJpYWwgKmluZm87DQotCWludAliYXVkID0gOTYwMDsNCisJaW50
CWJhdWQ7DQogCWludAliaXRzID0gODsNCiAJaW50CXBhcml0eSA9ICduJzsN
CiAJaW50CWNmbGFnID0gQ1JFQUQgfCBIVVBDTCB8IENMT0NBTDsNCi0JY2hh
cgkqczsNCisJY2hhcgkqcywgKmRiYXVkOw0KIAlpbnQgICAgIGksIGJyZzsN
CiAgICAgDQogCWlmIChvcHRpb25zKSB7DQpAQCAtMjEzOSw2ICsyMTUxLDIx
IEBADQogCQlpZiAoKnMpIHBhcml0eSA9ICpzKys7DQogCQlpZiAoKnMpIGJp
dHMgICA9ICpzIC0gJzAnOw0KIAl9DQorCWVsc2Ugew0KKwkJLyogSWYgdGhl
IHVzZXIgZG9lc24ndCBzZXQgY29uc29sZT0uLi4gdHJ5IHRvIHJlYWQgdGhl
DQorCQkgKiBQUk9NIHZhcmlhYmxlIC0gaWYgdGhpcyBmYWlscyB1c2UgOTYw
MCBiYXVkIGFuZA0KKwkJICogaW5mb3JtIHRoZSB1c2VyIGFib3V0IHRoZSBw
cm9ibGVtDQorCQkgKi8NCisJCWRiYXVkID0gQXJjR2V0RW52aXJvbm1lbnRW
YXJpYWJsZSgiZGJhdWQiKTsNCisJCWlmKGRiYXVkKSBiYXVkID0gc2ltcGxl
X3N0cnRvdWwoZGJhdWQsIE5VTEwsIDEwKTsNCisJCWVsc2Ugew0KKwkJCS8q
IFVzZSBwcm9tX3ByaW50ZigpIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSB1c2Vy
DQorCQkJICogaXMgZ2V0dGluZyBhbnl0aGluZyAuLi4NCisJCQkgKi8NCisJ
CQlwcm9tX3ByaW50ZigiTm8gZGJhdWQgc2V0IGluIFBST00gPyE/IFVzaW5n
IDk2MDAuXG4iKTsNCisJCQliYXVkID0gOTYwMDsNCisJCX0NCisJfQ0KIA0K
IAkvKg0KIAkgKglOb3cgY29uc3RydWN0IGEgY2ZsYWcgc2V0dGluZy4NCkBA
IC0yMTkzLDcgKzIyMjAsOCBAQA0KIAlpbmZvID0genNfc29mdCArIGNvbi0+
aW5kZXg7DQogCWluZm8tPmlzX2NvbnMgPSAxOw0KICAgICANCi0JcHJpbnRr
KCJDb25zb2xlOiB0dHlTJWQgKFppbG9nODUzMClcbiIsIGluZm8tPmxpbmUp
Ow0KKwlwcmludGsoIkNvbnNvbGU6IHR0eVMlZCAoWmlsb2c4NTMwKSwgJWQg
YmF1ZFxuIiwgDQorCQkJCQkJaW5mby0+bGluZSwgYmF1ZCk7DQogDQogCWkg
PSBjb24tPmNmbGFnICYgQ0JBVUQ7DQogCWlmIChjb24tPmNmbGFnICYgQ0JB
VURFWCkgew0KQEAgLTIyMzIsNiArMjI2MCw4IEBADQogCQl6c2NvbnNfcmVn
c1s0XSB8PSBTQjI7DQogCWVsc2UNCiAJCXpzY29uc19yZWdzWzRdIHw9IFNC
MTsNCisJDQorCXNnaXNlcmNvbiA9IGNvbjsNCiANCiAJYnJnID0gQlBTX1RP
X0JSRyhiYXVkLCBaU19DTE9DSyAvIGluZm8tPmNsa19kaXZpc29yKTsNCiAJ
enNjb25zX3JlZ3NbMTJdID0gYnJnICYgMHhmZjsNCg==
---1463811071-2031406748-992704878=:16303--
