Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61KhLnC019648
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 13:43:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61KhL6p019647
	for linux-mips-outgoing; Mon, 1 Jul 2002 13:43:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61Kh4nC019591;
	Mon, 1 Jul 2002 13:43:05 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g61KkmC30247;
	Mon, 1 Jul 2002 22:46:48 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g61KknTF012277;
	Mon, 1 Jul 2002 22:46:49 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17P84P-0007Jz-00; Mon, 01 Jul 2002 22:46:49 +0200
Date: Mon, 1 Jul 2002 22:46:49 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] r4k icache flushing for mips64 CVS HEAD
Message-ID: <Pine.LNX.4.21.0207012244400.28140-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-1408155667-1025556409=:28140"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=0.2 required=5.0 tests=MIME_NULL_BLOCK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-1408155667-1025556409=:28140
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	This fixes icache flushing for the r4xx0 processor in the current
(CVS HEAD) 2.5.1 tree. The flush_cache_all function does nothing there,
that's why I moved it to flush_cache_l1.

Vivien.

--279724308-1408155667-1025556409=:28140
Content-Type: TEXT/plain; name="linux-mips64-r4k_icache.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0207012246490.28140@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips64-r4k_icache.diff"

ZGlmZiAtTmF1ciAvc2hhcmUvbGludXguY3ZzL2FyY2gvbWlwczY0L21tL2xv
YWRtbXUuYyBsaW51eC5wYXRjaGVkL2FyY2gvbWlwczY0L21tL2xvYWRtbXUu
Yw0KLS0tIC9zaGFyZS9saW51eC5jdnMvYXJjaC9taXBzNjQvbW0vbG9hZG1t
dS5jCVN1biBNYXIgIDMgMTk6NTA6MzkgMjAwMg0KKysrIGxpbnV4LnBhdGNo
ZWQvYXJjaC9taXBzNjQvbW0vbG9hZG1tdS5jCVRodSBNYXkgMTYgMjM6MTI6
MjEgMjAwMg0KQEAgLTMwLDExICszMCwxNCBAQA0KIHZvaWQgKCpfZmx1c2hf
Y2FjaGVfcGFnZSkoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2ln
bmVkIGxvbmcgcGFnZSk7DQogdm9pZCAoKl9mbHVzaF9wYWdlX3RvX3JhbSko
c3RydWN0IHBhZ2UgKiBwYWdlKTsNCiANCit2b2lkICgqX2ZsdXNoX2ljYWNo
ZV9yYW5nZSkodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBl
bmQpOw0KK3ZvaWQgKCpfZmx1c2hfaWNhY2hlX3BhZ2UpKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3QgcGFnZSAqcGFnZSk7DQordm9pZCAo
Kl9mbHVzaF9pY2FjaGVfYWxsKSh2b2lkKTsNCisNCiAvKiBNSVBTIHNwZWNp
ZmljIGNhY2hlIG9wZXJhdGlvbnMgKi8NCiB2b2lkICgqX2ZsdXNoX2NhY2hl
X3NpZ3RyYW1wKSh1bnNpZ25lZCBsb25nIGFkZHIpOw0KIHZvaWQgKCpfZmx1
c2hfY2FjaGVfbDIpKHZvaWQpOw0KIHZvaWQgKCpfZmx1c2hfY2FjaGVfbDEp
KHZvaWQpOw0KLQ0KIA0KIC8qIERNQSBjYWNoZSBvcGVyYXRpb25zLiAqLw0K
IHZvaWQgKCpfZG1hX2NhY2hlX3diYWNrX2ludikodW5zaWduZWQgbG9uZyBz
dGFydCwgdW5zaWduZWQgbG9uZyBzaXplKTsNCmRpZmYgLU5hdXIgL3NoYXJl
L2xpbnV4LmN2cy9pbmNsdWRlL2FzbS1taXBzNjQvcGd0YWJsZS5oIGxpbnV4
LnBhdGNoZWQvaW5jbHVkZS9hc20tbWlwczY0L3BndGFibGUuaA0KLS0tIC9z
aGFyZS9saW51eC5jdnMvaW5jbHVkZS9hc20tbWlwczY0L3BndGFibGUuaAlT
dW4gTWF5ICA1IDE1OjAzOjM5IDIwMDINCisrKyBsaW51eC5wYXRjaGVkL2lu
Y2x1ZGUvYXNtLW1pcHM2NC9wZ3RhYmxlLmgJVGh1IE1heSAxNiAyMzowMTo0
NiAyMDAyDQpAQCAtNjAsMTIgKzYwLDIyIEBADQogDQogI2Vsc2UNCiANCitl
eHRlcm4gdm9pZCAoKl9mbHVzaF9pY2FjaGVfYWxsKSh2b2lkKTsNCitleHRl
cm4gdm9pZCAoKl9mbHVzaF9pY2FjaGVfcmFuZ2UpKHVuc2lnbmVkIGxvbmcg
c3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kKTsNCitleHRlcm4gdm9pZCAoKl9m
bHVzaF9pY2FjaGVfcGFnZSkoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
IHN0cnVjdCBwYWdlICpwYWdlKTsNCisNCiAjZGVmaW5lIGZsdXNoX2NhY2hl
X21tKG1tKQkJX2ZsdXNoX2NhY2hlX21tKG1tKQ0KICNkZWZpbmUgZmx1c2hf
Y2FjaGVfcmFuZ2UobW0sc3RhcnQsZW5kKQlfZmx1c2hfY2FjaGVfcmFuZ2Uo
bW0sc3RhcnQsZW5kKQ0KICNkZWZpbmUgZmx1c2hfY2FjaGVfcGFnZSh2bWEs
cGFnZSkJX2ZsdXNoX2NhY2hlX3BhZ2Uodm1hLCBwYWdlKQ0KICNkZWZpbmUg
Zmx1c2hfcGFnZV90b19yYW0ocGFnZSkJCV9mbHVzaF9wYWdlX3RvX3JhbShw
YWdlKQ0KICNkZWZpbmUgZmx1c2hfaWNhY2hlX3JhbmdlKHN0YXJ0LCBlbmQp
CV9mbHVzaF9pY2FjaGVfcmFuZ2Uoc3RhcnQsIGVuZCkNCiAjZGVmaW5lIGZs
dXNoX2ljYWNoZV9wYWdlKHZtYSwgcGFnZSkJX2ZsdXNoX2ljYWNoZV9wYWdl
KHZtYSwgcGFnZSkNCisjaWZkZWYgQ09ORklHX1ZUQUdfSUNBQ0hFDQorI2Rl
ZmluZSBmbHVzaF9pY2FjaGVfYWxsKCkJCV9mbHVzaF9pY2FjaGVfYWxsKCkN
CisjZWxzZQ0KKyNkZWZpbmUgZmx1c2hfaWNhY2hlX2FsbCgpCQlkbyB7IH0g
d2hpbGUoMCkNCisjZW5kaWYNCisNCiANCiAjZW5kaWYgLyogIUNPTkZJR19D
UFVfUjEwMDAwICovDQogDQpkaWZmIC1OYXVyIGxpbnV4L2FyY2gvbWlwczY0
L21tL3I0eHgwLmMgbGludXgucGF0Y2gvYXJjaC9taXBzNjQvbW0vcjR4eDAu
Yw0KLS0tIGxpbnV4L2FyY2gvbWlwczY0L21tL3I0eHgwLmMJTW9uIEp1bCAg
MSAyMTozNjozNyAyMDAyDQorKysgbGludXgucGF0Y2gvYXJjaC9taXBzNjQv
bW0vcjR4eDAuYwlNb24gSnVsICAxIDIyOjIyOjE1IDIwMDINCkBAIC0xNjI1
LDcgKzE2MjUsNyBAQA0KIHN0YXRpYyB2b2lkDQogcjRrX2ZsdXNoX2ljYWNo
ZV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVu
ZCkNCiB7DQotCWZsdXNoX2NhY2hlX2FsbCgpOw0KKwlmbHVzaF9jYWNoZV9s
MSgpOw0KIH0NCiANCiBzdGF0aWMgdm9pZA0K
--279724308-1408155667-1025556409=:28140--
