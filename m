Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2003 00:26:43 +0000 (GMT)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:8973 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225213AbTCYA0n>; Tue, 25 Mar 2003 00:26:43 +0000
Received: from 10.3.12.12 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Mon, 24 Mar 2003 16:26:35 -0800
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2F265.311CE0B0"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: arch/mips/kernel/setup.c patch - wrong start_pfn with CONFIG_EMBEDDED_RAMDISK
Date: Mon, 24 Mar 2003 16:26:34 -0800
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB0796825E@ex-eng-corp.efi.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: arch/mips/kernel/setup.c patch - wrong start_pfn with CONFIG_EMBEDDED_RAMDISK
Thread-Index: AcLyZTEn9QmHLPghQR2hDCENa/7/ag==
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: <linux-mips@linux-mips.org>
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2F265.311CE0B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I would like to submit the following change to arch/mips/kernel/setup.c. =
The start_pfn is not correct in case CONFIG_EMBEDDED_RAMDISK is slected. =
The ramdisk pages are added twice.

The diff -Naur output is attached to the mail.

Thanks

Ranjan

 <<diff.output.txt>>=20

------_=_NextPart_001_01C2F265.311CE0B0
Content-Type: text/plain;
	name="diff.output.txt"
Content-Transfer-Encoding: base64
Content-Description: diff.output.txt
Content-Disposition: attachment;
	filename="diff.output.txt"

ZGlmZiAtTmF1ciBsaW51eC1kZXYvYXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jIGxpbnV4LWRldi1w
YXRjaC9hcmNoL21pcHMva2VybmVsL3NldHVwLmMKLS0tIGxpbnV4LWRldi9hcmNoL21pcHMva2Vy
bmVsL3NldHVwLmMJV2VkIERlYyAxOCAxNTo0MDoxNCAyMDAyCisrKyBsaW51eC1kZXYtcGF0Y2gv
YXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jCU1vbiBNYXIgMjQgMTY6MTM6MDcgMjAwMwpAQCAtMjU1
LDYgKzI1NSwxNiBAQAogCWludCBpOwogCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfSU5JVFJECisj
aWZkZWYgQ09ORklHX0VNQkVEREVEX1JBTURJU0sKKwkvKgorCSAqIEVtYmVkZGVkIHJhbWRpc2sg
LT4gX2VuZCBhZnRlciB0aGUgcmFtZGlzayBzbyBubyBuZWVkIHRvIGFkZCB0aGVzZQorCSAqIHBh
Z2VzIGFnYWluCisJICoKKwkgKiBQYXJ0aWFsbHkgdXNlZCBwYWdlcyBhcmUgbm90IHVzYWJsZSAt
IHRodXMKKwkgKiB3ZSBhcmUgcm91bmRpbmcgdXB3YXJkcy4KKwkgKi8KKwlzdGFydF9wZm4gPSBQ
Rk5fVVAoX19wYSgmX2VuZCkpOworI2Vsc2UKIAl0bXAgPSAoKCh1bnNpZ25lZCBsb25nKSZfZW5k
ICsgUEFHRV9TSVpFLTEpICYgUEFHRV9NQVNLKSAtIDg7CiAJaWYgKHRtcCA8ICh1bnNpZ25lZCBs
b25nKSZfZW5kKQogCQl0bXAgKz0gUEFHRV9TSVpFOwpAQCAtMjY0LDYgKzI3NCw3IEBACiAJCWlu
aXRyZF9lbmQgPSBpbml0cmRfc3RhcnQgKyBpbml0cmRfaGVhZGVyWzFdOwogCX0KIAlzdGFydF9w
Zm4gPSBQRk5fVVAoX19wYSgoJl9lbmQpKyhpbml0cmRfZW5kIC0gaW5pdHJkX3N0YXJ0KSArIFBB
R0VfU0laRSkpOworI2VuZGlmCiAjZWxzZQogCS8qCiAJICogUGFydGlhbGx5IHVzZWQgcGFnZXMg
YXJlIG5vdCB1c2FibGUgLSB0aHVzCg==

------_=_NextPart_001_01C2F265.311CE0B0--
