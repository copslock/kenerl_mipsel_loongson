Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jun 2004 15:26:52 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:53001 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225274AbUFUO0n>; Mon, 21 Jun 2004 15:26:43 +0100
Received: from Snailmail (62.158.202.138)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Mon, 21 Jun 2004 16:25:16 +0200
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id i5LEKw0S000958;
	Mon, 21 Jun 2004 16:20:59 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id QAA17154;
	Mon, 21 Jun 2004 16:20:48 +0200
Date: Mon, 21 Jun 2004 16:20:48 +0200 (CEST)
From: Peter Fuerst <pf@net.alphadv.de>
To: Kumba <kumba@gentoo.org>
cc: linux-mips@linux-mips.org
Subject: ip22zilog resurrection
In-Reply-To: <40D2118C.5020506@gentoo.org>
Message-ID: <Pine.LNX.4.21.0406211607490.17140-200000@Opal.Peter>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1947110491-1087827648=:17140"
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1947110491-1087827648=:17140
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello !

Switch back the channels according to PROM/documentation/case numbering,
do some other small changes (patch attached), and you should have serial
console available again.

However, i couldn't test this fully. On my IP28, when entering userland
in 2.6 (no matter whether /sbin/init or /bin/sh), the output in the
console-window becomes slower and slower, asymptotically reaching a
standstill, before the login prompt appears (while the machine still can
be ping'ed over ethernet without degradation)  :-(

Good luck

peter



On Thu, 17 Jun 2004, Kumba wrote:

> Date: Thu, 17 Jun 2004 17:47:56 -0400
> From: Kumba <kumba@gentoo.org>
> To: linux-mips@linux-mips.org
> Subject: Re: Swap and 2.6
> 
> ..., and ip22zilog is shot dead in 
> 2.6.x, ...
> 
> --Kumba


---1463811839-1947110491-1087827648=:17140
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ip22zilog.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0406211620480.17140@Opal.Peter>
Content-Description: 
Content-Disposition: attachment; filename="ip22zilog.diff"

ZGlmZiAtTmF1ciBsaW51eC0yLjYueC1jdnN3ZWIvYXJjaC9taXBzL3NnaS1p
cDIyL2lwMjItc2V0dXAuYyBsaW51eC0yLjYueC1sb2NhbC9hcmNoL21pcHMv
c2dpLWlwMjIvaXAyMi1zZXR1cC5jDQotLS0gbGludXgtMi42LngtY3Zzd2Vi
L2FyY2gvbWlwcy9zZ2ktaXAyMi9pcDIyLXNldHVwLmMJVGh1IEFwciAyOSAx
NDozNzoxMCAyMDA0DQorKysgbGludXgtMi42LngtbG9jYWwvYXJjaC9taXBz
L3NnaS1pcDIyL2lwMjItc2V0dXAuYwlXZWQgSnVuIDE2IDIzOjIzOjA3IDIw
MDQNCkBAIC05OSw2ICs5OSw5IEBADQogCQkJc3RyY3B5KG9wdGlvbnMsIGJh
dWQpOw0KIAkJYWRkX3ByZWZlcnJlZF9jb25zb2xlKCJ0dHlTIiwgKihjdHlw
ZSArIDEpID09ICcyJyA/IDEgOiAwLA0KIAkJCQkgICAgICBiYXVkID8gb3B0
aW9ucyA6IE5VTEwpOw0KKyNpZmRlZiBDT05GSUdfU0VSSUFMX0lQMjJfWklM
T0dfQ09OU09MRQ0KKwkJc2VyaWFsX2NvbnNvbGUgPSAqKGN0eXBlICsgMSkg
PT0gJzInID8gMiA6IDE7DQorI2VuZGlmDQogCX0gZWxzZSBpZiAoIWN0eXBl
IHx8ICpjdHlwZSAhPSAnZycpIHsNCiAJCS8qIFVzZSBBUkMgaWYgd2UgZG9u
J3Qgd2FudCBzZXJpYWwgKCdkJykgb3IgTmV3cG9ydCAoJ2cnKS4gKi8NCiAJ
CXByb21fZmxhZ3MgfD0gUFJPTV9GTEFHX1VTRV9BU19DT05TT0xFOw0KQEAg
LTE1MCwzICsxNTMsNyBAQA0KIH0NCiANCiBlYXJseV9pbml0Y2FsbChpcDIy
X3NldHVwKTsNCisvKg0KKyAqIFJldmlzaW9uIDEuMzgsIFRodSBBcHIgMjkg
MTQ6Mzc6MTAgMjAwNCBVVEMNCisgKiBXZWQgSnVuIDE2IDIzOjIzOjA3IDIw
MDQNCisgKi8NCmRpZmYgLU5hdXIgbGludXgtMi42LngtY3Zzd2ViL2RyaXZl
cnMvc2VyaWFsL2lwMjJ6aWxvZy5jIGxpbnV4LTIuNi54LWxvY2FsL2RyaXZl
cnMvc2VyaWFsL2lwMjJ6aWxvZy5jDQotLS0gbGludXgtMi42LngtY3Zzd2Vi
L2RyaXZlcnMvc2VyaWFsL2lwMjJ6aWxvZy5jCVR1ZSBEZWMgMjMgMTY6MDI6
MTMgMjAwMw0KKysrIGxpbnV4LTIuNi54LWxvY2FsL2RyaXZlcnMvc2VyaWFs
L2lwMjJ6aWxvZy5jCVdlZCBKdW4gMTYgMjM6MjI6MzcgMjAwNA0KQEAgLTYy
LDcgKzYyLDcgQEANCiAjZGVmaW5lIE5VTV9JUDIyWklMT0cJMQ0KICNkZWZp
bmUgTlVNX0NIQU5ORUxTCShOVU1fSVAyMlpJTE9HICogMikNCiANCi0jZGVm
aW5lIFpTX0NMT0NLCQk0OTE1MjAwIC8qIFppbG9nIGlucHV0IGNsb2NrIHJh
dGUuICovDQorI2RlZmluZSBaU19DTE9DSwkJMzY3MjAwMAkvKiBaaWxvZyBp
bnB1dCBjbG9jayByYXRlICovDQogI2RlZmluZSBaU19DTE9DS19ESVZJU09S
CTE2ICAgICAgLyogRGl2aXNvciB0aGlzIGRyaXZlciB1c2VzLiAqLw0KIA0K
IC8qDQpAQCAtOTU1LDYgKzk1NSw3IEBADQogCS5kcml2ZXJfbmFtZQk9CSJ0
dHlTIiwNCiAJLmRldmZzX25hbWUJPQkidHR5LyIsDQogCS5tYWpvcgkJPQlU
VFlfTUFKT1IsDQorCS5kZXZfbmFtZQk9CSJ0dHlTIiwNCiB9Ow0KIA0KIHN0
YXRpYyB2b2lkICogX19pbml0IGFsbG9jX29uZV90YWJsZSh1bnNpZ25lZCBs
b25nIHNpemUpDQpAQCAtMTE2OSw4ICsxMTcwLDExIEBADQogCQlpZiAoIWlw
MjJ6aWxvZ19jaGlwX3JlZ3NbY2hpcF0pIHsNCiAJCQlpcDIyemlsb2dfY2hp
cF9yZWdzW2NoaXBdID0gcnAgPSBnZXRfenMoY2hpcCk7DQogDQotCQkJdXBb
KGNoaXAgKiAyKSArIDBdLnBvcnQubWVtYmFzZSA9IChjaGFyICopICZycC0+
Y2hhbm5lbEE7DQotCQkJdXBbKGNoaXAgKiAyKSArIDFdLnBvcnQubWVtYmFz
ZSA9IChjaGFyICopICZycC0+Y2hhbm5lbEI7DQorCQkJdXBbKGNoaXAgKiAy
KSArIDBdLnBvcnQubWVtYmFzZSA9IChjaGFyICopICZycC0+Y2hhbm5lbEI7
DQorCQkJdXBbKGNoaXAgKiAyKSArIDFdLnBvcnQubWVtYmFzZSA9IChjaGFy
ICopICZycC0+Y2hhbm5lbEE7DQorDQorCQkJdXBbKGNoaXAgKiAyKSArIDBd
LnBvcnQubWFwYmFzZSA9IENQSFlTQUREUigmcnAtPmNoYW5uZWxCKTsNCisJ
CQl1cFsoY2hpcCAqIDIpICsgMV0ucG9ydC5tYXBiYXNlID0gQ1BIWVNBRERS
KCZycC0+Y2hhbm5lbEEpOw0KIAkJfQ0KIA0KIAkJLyogQ2hhbm5lbCBBICov
DQpAQCAtMTMwNSwzICsxMzA5LDcgQEANCiBNT0RVTEVfQVVUSE9SKCJSYWxm
IEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+Iik7DQogTU9EVUxFX0RF
U0NSSVBUSU9OKCJTR0kgWmlsb2cgc2VyaWFsIHBvcnQgZHJpdmVyIik7DQog
TU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KKy8qDQorICogUmV2aXNpb24gMS4x
MSwgVHVlIERlYyAyMyAxNjowMjoxMyAyMDAzIFVUQw0KKyAqIFdlZCBKdW4g
MTYgMjM6MjI6MzcgMjAwNCAoMTA4NzQyMDk1NykNCisgKi8NCg==
---1463811839-1947110491-1087827648=:17140--
