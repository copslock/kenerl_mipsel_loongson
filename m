Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFNrR628077
	for linux-mips-outgoing; Sat, 15 Dec 2001 15:53:27 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFNr7o28051;
	Sat, 15 Dec 2001 15:53:08 -0800
Received: from resel.enst-bretagne.fr (user54671@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id fBFMqwI00366;
	Sat, 15 Dec 2001 23:52:58 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id XAA15050;
	Sat, 15 Dec 2001 23:52:59 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16FNfu-00036Y-00; Sat, 15 Dec 2001 23:52:58 +0100
Date: Sat, 15 Dec 2001 23:52:58 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: ralf@oss.sgi.com
cc: linux-mips@oss.sgi.com
Subject: patches for SGI O2
Message-ID: <Pine.LNX.4.21.0112152332470.11851-400000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-437166396-1008456778=:11851"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-437166396-1008456778=:11851
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	I've a few patches for running Linux on the SGI O2:

The first one (O2-asid) concerns the TLB initialization the IP32. The
asid_cache is not initialized, which leads to MMU context = 0 being
considered valid! Thus when switching task, in switch_mm, a new context is
not created. With the patch I can boot a debian experimental system (from
ftp://bolugftp.uni-bonn.de/pub/mips-linux/rootfs/experimental)

The second one adds support for the 16550A UARTs of the O2, so that ARC
console is not needed anymore.

Finaly, with my configuration (SGI O2 R5000 @ 180Mhz) I've to change
PAGE_OFFSET in page.h to the one used for IP22 rather than the one used
for IP32.. here is a third patch (O2-page) to change this, but I'm not
sure about other configurations (R10000?)

regards,
Vivien.


--279724308-437166396-1008456778=:11851
Content-Type: TEXT/plain; name="linux-O2-asid.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0112152352580.11851@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-O2-asid.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9zZ2ktaXAzMi9pcDMyLXNl
dHVwLmMgbGludXgucGF0Y2gvYXJjaC9taXBzNjQvc2dpLWlwMzIvaXAzMi1z
ZXR1cC5jDQotLS0gbGludXgvYXJjaC9taXBzNjQvc2dpLWlwMzIvaXAzMi1z
ZXR1cC5jCVN1biBEZWMgIDkgMTU6NDc6MTUgMjAwMQ0KKysrIGxpbnV4LnBh
dGNoL2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzItc2V0dXAuYwlTYXQgRGVj
IDE1IDIyOjU2OjI5IDIwMDENCkBAIC01OCw2ICs1OCw3IEBADQogI2lmZGVm
IENPTkZJR19TRVJJQUxfQ09OU09MRQ0KIAljaGFyICpjdHlwZTsNCiAjZW5k
aWYNCisJY3VycmVudF9jcHVfZGF0YS5hc2lkX2NhY2hlID0gQVNJRF9GSVJT
VF9WRVJTSU9OOw0KIAlUTEJNSVNTX0hBTkRMRVJfU0VUVVAgKCk7DQogDQog
I2lmZGVmIENPTkZJR19TRVJJQUxfQ09OU09MRQ0K
--279724308-437166396-1008456778=:11851
Content-Type: TEXT/plain; name="linux-O2-serial.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0112152352581.11851@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-O2-serial.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9hcmMvYXJjX2Nvbi5jIGxp
bnV4LnBhdGNoL2FyY2gvbWlwczY0L2FyYy9hcmNfY29uLmMNCi0tLSBsaW51
eC9hcmNoL21pcHM2NC9hcmMvYXJjX2Nvbi5jCVN1biBEZWMgIDkgMTU6NDc6
MTAgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L2FyYy9hcmNf
Y29uLmMJTW9uIERlYyAxMCAyMDozNTo0NCAyMDAxDQpAQCAtMTUsMTQgKzE1
LDcgQEANCiAjaW5jbHVkZSA8YXNtL3NnaWFsaWIuaD4NCiANCiBleHRlcm4g
dm9pZCBwcm9tX3ByaW50ZiAoY2hhciAqLCAuLi4pOw0KLQ0KLXZvaWQgcHJv
bV9wdXRjaGFyKGNoYXIgYykNCi17DQotCVVMT05HIGNudDsNCi0JQ0hBUiBp
dCA9IGM7DQotDQotCUFyY1dyaXRlKDEsICZpdCwgMSwgJmNudCk7DQotfQ0K
K2V4dGVybiB2b2lkIHByb21fcHV0Y2hhcihjaGFyIGMpOw0KIA0KIHN0YXRp
YyB2b2lkIHByb21fY29uc29sZV93cml0ZShzdHJ1Y3QgY29uc29sZSAqY28s
IGNvbnN0IGNoYXIgKnMsDQogCQkJICAgICAgIHVuc2lnbmVkIGNvdW50KQ0K
ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9hcmMvY29uc29sZS5jIGxp
bnV4LnBhdGNoL2FyY2gvbWlwczY0L2FyYy9jb25zb2xlLmMNCi0tLSBsaW51
eC9hcmNoL21pcHM2NC9hcmMvY29uc29sZS5jCVN1biBEZWMgIDkgMTU6NDc6
MTAgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L2FyYy9jb25z
b2xlLmMJTW9uIERlYyAxMCAyMDozNTozNCAyMDAxDQpAQCAtMTEsNiArMTEs
MTQgQEANCiANCiBzdGF0aWMgY2hhciBwcGJ1ZlsxMDI0XTsNCiANCit2b2lk
IHByb21fcHV0Y2hhcihjaGFyIGMpDQorew0KKwlVTE9ORyBjbnQ7DQorCUNI
QVIgaXQgPSBjOw0KKw0KKwlBcmNXcml0ZSgxLCAmaXQsIDEsICZjbnQpOw0K
K30NCisNCiB2b2lkIHByb21fcHJpbnRmKGNoYXIgKmZtdCwgLi4uKQ0KIHsN
CiAJdmFfbGlzdCBhcmdzOw0KZGlmZiAtTmF1ciBsaW51eC9pbmNsdWRlL2Fz
bS1taXBzNjQvc2VyaWFsLmggbGludXgucGF0Y2gvaW5jbHVkZS9hc20tbWlw
czY0L3NlcmlhbC5oDQotLS0gbGludXgvaW5jbHVkZS9hc20tbWlwczY0L3Nl
cmlhbC5oCVN1biBEZWMgIDkgMTU6NTI6MjggMjAwMQ0KKysrIGxpbnV4LnBh
dGNoL2luY2x1ZGUvYXNtLW1pcHM2NC9zZXJpYWwuaAlNb24gRGVjIDEwIDIw
OjM1OjA4IDIwMDENCkBAIC0xOCw2ICsxOCw4IEBADQogICovDQogI2RlZmlu
ZSBCQVNFX0JBVUQgKDE4NDMyMDAgLyAxNikNCiANCisjaWYgZGVmaW5lZChD
T05GSUdfU0dJX0lQMjcpDQorDQogLyoNCiAgKiBOb3RlIGFib3V0IHNlcmlh
bCBwb3J0cyBhbmQgY29uc29sZXM6DQogICogRm9yIGNvbnNvbGUgb3V0cHV0
LCBldmVyeW9uZSB1c2VzIHRoZSBJT0MzIFVBUlRBIChvZmZzZXQgMHgxNzgp
DQpAQCAtNDksNSArNTEsNDAgQEANCiAjZGVmaW5lIFJTX1RBQkxFX1NJWkUJ
NjQNCiANCiAjZGVmaW5lIFNFUklBTF9QT1JUX0RGTlMNCisNCisjZWxpZiBk
ZWZpbmVkKENPTkZJR19TR0lfSVAzMikNCisNCisjaW5jbHVkZSA8YXNtL2lw
MzIvaXAzMl9pbnRzLmg+DQorDQorLyoNCisgKiBUaGUgSVAzMiAoU0dJIE8y
KSBoYXMgc3RhbmRhcmQgc2VyaWFsIHBvcnRzIChVQVJUIDE2NTUwQSkgbWFw
cGVkIGluIG1lbW9yeQ0KKyAqLw0KKw0KKyNkZWZpbmUgUlNfVEFCTEVfU0la
RQ0KKw0KKy8qIFN0YW5kYXJkIENPTSBmbGFncyAoZXhjZXB0IGZvciBDT000
LCBiZWNhdXNlIG9mIHRoZSA4NTE0IHByb2JsZW0pICovDQorI2lmZGVmIENP
TkZJR19TRVJJQUxfREVURUNUX0lSUQ0KKyNkZWZpbmUgU1REX0NPTV9GTEFH
UyAoQVNZTkNfQk9PVF9BVVRPQ09ORiB8IEFTWU5DX1NLSVBfVEVTVCB8IEFT
WU5DX0FVVE9fSVJRKQ0KKyNkZWZpbmUgU1REX0NPTTRfRkxBR1MgKEFTWU5D
X0JPT1RfQVVUT0NPTkYgfCBBU1lOQ19BVVRPX0lSUSkNCisjZWxzZQ0KKyNk
ZWZpbmUgU1REX0NPTV9GTEFHUyAoQVNZTkNfQk9PVF9BVVRPQ09ORi8qIHwg
QVNZTkNfU0tJUF9URVNUKi8pDQorI2RlZmluZSBTVERfQ09NNF9GTEFHUyBB
U1lOQ19CT09UX0FVVE9DT05GDQorI2VuZGlmDQorDQorI2RlZmluZSBTRVJJ
QUxfUE9SVF9ERk5TCQkJCVwNCisgICAgICAgIHsgYmF1ZF9iYXNlOiBCQVNF
X0JBVUQsCQkJCVwNCisJICBpcnE6IE1BQ0VJU0FfU0VSSUFMMV9JUlEsCQkJ
XA0KKyAgICAgICAgICBmbGFnczogU1REX0NPTV9GTEFHUywJCQkJXA0KKyAg
ICAgICAgICBpb21lbV9iYXNlOiAodTgqKU1BQ0VfQkFTRStNQUNFSVNBX1NF
UjFfQkFTRSwJXA0KKyAgICAgICAgICBpb21lbV9yZWdfc2hpZnQ6IDgsCQkJ
CVwNCisgICAgICAgICAgaW9fdHlwZTogU0VSSUFMX0lPX01FTX0sICAgICAg
ICAgICAgICAgICAgICAgIFwNCisgICAgICAgIHsgYmF1ZF9iYXNlOiBCQVNF
X0JBVUQsCQkJCVwNCisJICBpcnE6IE1BQ0VJU0FfU0VSSUFMMl9JUlEsCQkJ
XA0KKyAgICAgICAgICBmbGFnczogU1REX0NPTV9GTEFHUywJCQkJXA0KKyAg
ICAgICAgICBpb21lbV9iYXNlOiAodTgqKU1BQ0VfQkFTRStNQUNFSVNBX1NF
UjJfQkFTRSwJXA0KKyAgICAgICAgICBpb21lbV9yZWdfc2hpZnQ6IDgsCQkJ
CVwNCisgICAgICAgICAgaW9fdHlwZTogU0VSSUFMX0lPX01FTX0sICAgICAg
ICAgICAgICAgICAgICAgIA0KKyNlbmRpZg0KKw0KIA0KICNlbmRpZiAvKiBf
QVNNX1NFUklBTF9IICovDQo=
--279724308-437166396-1008456778=:11851
Content-Type: TEXT/plain; name="linux-O2-page.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0112152352582.11851@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-O2-page.diff"

ZGlmZiAtTmF1ciBsaW51eC9pbmNsdWRlL2FzbS1taXBzNjQvcGFnZS5oIGxp
bnV4LnBhdGNoL2luY2x1ZGUvYXNtLW1pcHM2NC9wYWdlLmgNCi0tLSBsaW51
eC9pbmNsdWRlL2FzbS1taXBzNjQvcGFnZS5oCVNhdCBEZWMgMTUgMjE6MzM6
NDAgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2luY2x1ZGUvYXNtLW1pcHM2NC9w
YWdlLmgJU2F0IERlYyAxNSAyMTozNzozOCAyMDAxDQpAQCAtNjAsMTAgKzYw
LDEwIEBADQogICogYXQgWEtQSFlTIGZvciBrZXJuZWxzIHdpdGggbW9yZSB0
aGFuIHRoYXQuDQogICovDQogI2lmIGRlZmluZWQoQ09ORklHX1NHSV9JUDIy
KSB8fCBkZWZpbmVkKENPTkZJR19NSVBTX0FUTEFTKSB8fCBcDQotICAgIGRl
ZmluZWQoQ09ORklHX01JUFNfTUFMVEEpDQorICAgIGRlZmluZWQoQ09ORklH
X01JUFNfTUFMVEEpIHx8IGRlZmluZWQoQ09ORklHX1NHSV9JUDMyKQ0KICNk
ZWZpbmUgUEFHRV9PRkZTRVQJMHhmZmZmZmZmZjgwMDAwMDAwVUwNCiAjZW5k
aWYNCi0jaWYgZGVmaW5lZChDT05GSUdfU0dJX0lQMjcpIHx8IGRlZmluZWQo
Q09ORklHX1NHSV9JUDMyKQ0KKyNpZiBkZWZpbmVkKENPTkZJR19TR0lfSVAy
NykNCiAjZGVmaW5lIFBBR0VfT0ZGU0VUCTB4YTgwMDAwMDAwMDAwMDAwMFVM
DQogI2VuZGlmDQogDQo=
--279724308-437166396-1008456778=:11851--
