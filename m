Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64BOgRw000869
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:24:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64BOgCJ000868
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:24:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BOSRw000845;
	Thu, 4 Jul 2002 04:24:28 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g64BSNC09518;
	Thu, 4 Jul 2002 13:28:23 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g64BSJTF026918;
	Thu, 4 Jul 2002 13:28:19 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17Q4mZ-0000Qt-00; Thu, 04 Jul 2002 13:28:19 +0200
Date: Thu, 4 Jul 2002 13:28:19 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] CVS HEAD mips64 assembler options
Message-ID: <Pine.LNX.4.21.0207041322570.1601-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-2020090313-1025782099=:1601"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=0.2 required=5.0 tests=MIME_NULL_BLOCK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-2020090313-1025782099=:1601
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	There's been some rework on the Makefile for the mips64 target,
however the line for the assembler options was forgotten, causing
assembly source code to be wronly compiled, and crashing the linker
afterwards. This patch fixes it, and also removes a few warnings about
structures declared in parameter list.

regards,
Vivien Chappelier.

--279724308-2020090313-1025782099=:1601
Content-Type: TEXT/plain; name="linux-mips64-build.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0207041328190.1601@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips64-build.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9NYWtlZmlsZSBsaW51eC5w
YXRjaC9hcmNoL21pcHM2NC9NYWtlZmlsZQ0KLS0tIGxpbnV4L2FyY2gvbWlw
czY0L01ha2VmaWxlCVRodSBKdWwgIDQgMTA6MTI6MjcgMjAwMg0KKysrIGxp
bnV4LnBhdGNoL2FyY2gvbWlwczY0L01ha2VmaWxlCVRodSBKdWwgIDQgMTE6
MTc6NTQgMjAwMg0KQEAgLTcxLDEwICs3MSw2IEBADQogZW5kaWYNCiBlbmRp
Zg0KIA0KLUFGTEFHUwkJKz0gJChHQ0NGTEFHUykNCi1DRkxBR1MJCSs9ICQo
R0NDRkxBR1MpDQotDQotDQogIw0KICMgV2UgdW5jb25kaXRpb25hbGx5IGJ1
aWxkIHRoZSBtYXRoIGVtdWxhdG9yDQogIw0KQEAgLTE2Myw3ICsxNTksNyBA
QA0KICMgY29udmVydCB0byBFQ09GRiB1c2luZyBlbGYyZWNvZmYuDQogIw0K
IGlmZGVmIENPTkZJR19CT09UX0VMRjMyDQotQ0ZMQUdTICs9IC1XYSwtMzIN
CitHQ0NGTEFHUyArPSAtV2EsLTMyDQogTElOS0ZMQUdTICs9IC1UIGFyY2gv
bWlwczY0L2xkLnNjcmlwdC5lbGYzMg0KIGVuZGlmDQogIw0KQEAgLTE3MSw3
ICsxNjcsNyBAQA0KICMgRUxGIGZpbGVzIGZyb20gMzItYml0IGZpbGVzIGJ5
IGNvbnZlcnNpb24uDQogIw0KIGlmZGVmIENPTkZJR19CT09UX0VMRjY0DQot
Q0ZMQUdTICs9IC1XYSwtMzINCitHQ0NGTEFHUyArPSAtV2EsLTMyDQogTElO
S0ZMQUdTICs9IC1UIGFyY2gvbWlwczY0L2xkLnNjcmlwdC5lbGYzMg0KICNB
UyArPSAtNjQNCiAjTEQgKz0gLW0gZWxmNjRibWlwDQpAQCAtMTkzLDYgKzE4
OSw5IEBADQogZWxzZQ0KIDY0Yml0LWJmZCA9IGVsZjY0LWJpZ21pcHMNCiBl
bmRpZg0KKw0KK0FGTEFHUwkJKz0gJChHQ0NGTEFHUykNCitDRkxBR1MJCSs9
ICQoR0NDRkxBR1MpDQogDQogdm1saW51eDogYXJjaC9taXBzNjQvbGQuc2Ny
aXB0LmVsZjMyDQogYXJjaC9taXBzNjQvbGQuc2NyaXB0LmVsZjMyOiBhcmNo
L21pcHM2NC9sZC5zY3JpcHQuZWxmMzIuUw0KZGlmZiAtTmF1ciBsaW51eC9p
bmNsdWRlL2FzbS1taXBzNjQvcHJvY2Vzc29yLmggbGludXgucGF0Y2gvaW5j
bHVkZS9hc20tbWlwczY0L3Byb2Nlc3Nvci5oDQotLS0gbGludXgvaW5jbHVk
ZS9hc20tbWlwczY0L3Byb2Nlc3Nvci5oCU1vbiBKdWwgIDEgMjA6MjY6NDEg
MjAwMg0KKysrIGxpbnV4LnBhdGNoL2luY2x1ZGUvYXNtLW1pcHM2NC9wcm9j
ZXNzb3IuaAlUaHUgSnVsICA0IDExOjE3OjI4IDIwMDINCkBAIC0xMyw2ICsx
MywxMCBAQA0KIA0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4NCiANCisj
aWZuZGVmIF9MQU5HVUFHRV9BU1NFTUJMWQ0KK3N0cnVjdCB0YXNrX3N0cnVj
dDsNCisjZW5kaWYNCisNCiAvKg0KICAqIFJldHVybiBjdXJyZW50ICogaW5z
dHJ1Y3Rpb24gcG9pbnRlciAoInByb2dyYW0gY291bnRlciIpLg0KICAqLw0K
ZGlmZiAtTmF1ciAvc2hhcmUvbGludXgtMi41LmN2cy9pbmNsdWRlL2FzbS1t
aXBzNjQvc3lzdGVtLmggbGludXgucGF0Y2gvaW5jbHVkZS9hc20tbWlwczY0
L3N5c3RlbS5oDQotLS0gbGludXgvaW5jbHVkZS9hc20tbWlwczY0L3N5c3Rl
bS5oCVRodSBKdWwgIDQgMTA6MTI6NTYgMjAwMg0KKysrIGxpbnV4LnBhdGNo
L2luY2x1ZGUvYXNtLW1pcHM2NC9zeXN0ZW0uaAlUaHUgSnVsICA0IDExOjE3
OjM4IDIwMDINCkBAIC0xNSw2ICsxNSw4IEBADQogI2luY2x1ZGUgPGFzbS9w
dHJhY2UuaD4NCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogDQorc3Ry
dWN0IHRhc2tfc3RydWN0Ow0KKw0KIF9fYXNtX18gKA0KIAkiLm1hY3JvXHRf
X3N0aVxuXHQiDQogCSIuc2V0XHRwdXNoXG5cdCINCi0tLSBsaW51eC9pbmNs
dWRlL2FzbS1taXBzNjQvdHJhcHMuaAlXZWQgSnVuIDI2IDE1OjAxOjIzIDIw
MDINCisrKyBsaW51eC5wYXRjaC9pbmNsdWRlL2FzbS1taXBzNjQvdHJhcHMu
aAlUaHUgSnVsICA0IDEyOjI2OjU4IDIwMDINCkBAIC0xMyw2ICsxMyw4IEBA
DQogI2lmbmRlZiBfX0FTTV9NSVBTNjRfVFJBUFNfSA0KICNkZWZpbmUgX19B
U01fTUlQUzY0X1RSQVBTX0gNCiANCitzdHJ1Y3QgcHRfcmVnczsNCisNCiAv
Kg0KICAqIFBvc3NpYmxlIHN0YXR1cyByZXNwb25zZXMgZm9yIGEgYmVfYm9h
cmRfaGFuZGxlciBiYWNrZW5kLg0KICAqLw0K
--279724308-2020090313-1025782099=:1601--
