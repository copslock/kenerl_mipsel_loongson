Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MdPn29868
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:39:25 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03MdHg29863;
	Thu, 3 Jan 2002 14:39:18 -0800
Received: from resel.enst-bretagne.fr (user18358@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03Ld8b11590;
	Thu, 3 Jan 2002 22:39:08 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA20266;
	Thu, 3 Jan 2002 22:39:09 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFZt-0002L6-00; Thu, 03 Jan 2002 22:39:09 +0100
Date: Thu, 3 Jan 2002 22:39:09 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject:  missing callbacks on setup (reboot)
Message-ID: <Pine.LNX.4.21.0201032237460.8906-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-1733247112-1010093949=:8906"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-1733247112-1010093949=:8906
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	This fixes missing callbacks for reboot with linux 2.5.1 on the
ip27 and ip32.

Vivien Chappelier.

--279724308-1733247112-1010093949=:8906
Content-Type: TEXT/plain; name="linux-mips-reboot.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201032239090.8906@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips-reboot.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9zZ2ktaXAyNy9pcDI3LXNl
dHVwLmMgbGludXgucGF0Y2gvYXJjaC9taXBzNjQvc2dpLWlwMjcvaXAyNy1z
ZXR1cC5jDQotLS0gbGludXgvYXJjaC9taXBzNjQvc2dpLWlwMjcvaXAyNy1z
ZXR1cC5jCVdlZCBKYW4gIDIgMjI6NTY6NDEgMjAwMg0KKysrIGxpbnV4LnBh
dGNoL2FyY2gvbWlwczY0L3NnaS1pcDI3L2lwMjctc2V0dXAuYwlXZWQgSmFu
ICAyIDIzOjE0OjE5IDIwMDINCkBAIC0yNzYsNiArMjc2LDcgQEANCiANCiBl
eHRlcm4gdm9pZCBpcDI3X3NldHVwX2NvbnNvbGUodm9pZCk7DQogZXh0ZXJu
IHZvaWQgaXAyN190aW1lX2luaXQodm9pZCk7DQorZXh0ZXJuIHZvaWQgaXAy
N19yZWJvb3Rfc2V0dXAodm9pZCk7DQogDQogdm9pZCBfX2luaXQgaXAyN19z
ZXR1cCh2b2lkKQ0KIHsNCkBAIC0yODMsNiArMjg0LDcgQEANCiAJaHVicmVn
X3QgcCwgZTsNCiANCiAJaXAyN19zZXR1cF9jb25zb2xlKCk7DQorCWlwMjdf
cmVib290X3NldHVwKCk7DQogDQogCW51bV9icmlkZ2VzID0gMDsNCiAJLyoN
CmRpZmYgLU5hdXIgbGludXgvYXJjaC9taXBzNjQvc2dpLWlwMzIvaXAzMi1z
ZXR1cC5jIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzIt
c2V0dXAuYw0KLS0tIGxpbnV4L2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzIt
c2V0dXAuYwlXZWQgSmFuICAyIDIyOjU2OjQxIDIwMDINCisrKyBsaW51eC5w
YXRjaC9hcmNoL21pcHM2NC9zZ2ktaXAzMi9pcDMyLXNldHVwLmMJV2VkIEph
biAgMiAyMzoxNDoyMSAyMDAyDQpAQCAtNTgsNiArNTgsNyBAQA0KICNlbmRp
Zg0KIA0KIGV4dGVybiB2b2lkIGlwMzJfdGltZV9pbml0KHZvaWQpOw0KK2V4
dGVybiB2b2lkIGlwMzJfcmVib290X3NldHVwKHZvaWQpOw0KIA0KIHZvaWQg
X19pbml0IGJ1c19lcnJvcl9pbml0KHZvaWQpDQogew0KQEAgLTkyLDYgKzkz
LDcgQEANCiAjaWZkZWYgQ09ORklHX1ZUDQogCWNvbnN3aXRjaHAgPSAmZHVt
bXlfY29uOw0KICNlbmRpZg0KKwlpcDMyX3JlYm9vdF9zZXR1cCgpOw0KIA0K
IAlydGNfb3BzID0gJmlwMzJfcnRjX29wczsNCiAJYm9hcmRfdGltZV9pbml0
ID0gaXAzMl90aW1lX2luaXQ7DQo=
--279724308-1733247112-1010093949=:8906--
