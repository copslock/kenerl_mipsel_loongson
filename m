Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03Mc0729790
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:38:00 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03Mbqg29786;
	Thu, 3 Jan 2002 14:37:52 -0800
Received: from resel.enst-bretagne.fr (user66540@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03Lbgb11520;
	Thu, 3 Jan 2002 22:37:42 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA20227;
	Thu, 3 Jan 2002 22:37:43 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFYU-0002Kg-00; Thu, 03 Jan 2002 22:37:42 +0100
Date: Thu, 3 Jan 2002 22:37:42 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: missing callbacks on setup (timer)
Message-ID: <Pine.LNX.4.21.0201032236170.8906-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-280324098-1010093862=:8906"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-280324098-1010093862=:8906
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

	This fixes missing callbacks for setting up the timer with linux 
2.5.1 on the ip27 and ip32.

Vivien Chappelier.

--279724308-280324098-1010093862=:8906
Content-Type: TEXT/plain; name="linux-mips-timer.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201032237420.8906@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips-timer.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9rZXJuZWwvdGltZS5jIGxp
bnV4LnBhdGNoL2FyY2gvbWlwczY0L2tlcm5lbC90aW1lLmMNCi0tLSBsaW51
eC9hcmNoL21pcHM2NC9rZXJuZWwvdGltZS5jCVdlZCBEZWMgMTkgMDE6MDM6
MDMgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L2tlcm5lbC90
aW1lLmMJVGh1IERlYyAyMCAyMTozNzowMiAyMDAxDQpAQCAtNDU3LDcgKzQ1
Nyw4IEBADQogCSAqIHRvIGJlIE5VTEwgZnVuY3Rpb24gc28gdGhhdCB3ZSBh
cmUgc3VyZSB0aGUgaGlnaC1sZXZlbCBjb2RlDQogCSAqIGlzIG5vdCBpbnZv
a2VkIGFjY2lkZW50YWxseS4NCiAJICovDQotCWJvYXJkX3RpbWVyX3NldHVw
KCZ0aW1lcl9pcnFhY3Rpb24pOw0KKwlpZihib2FyZF90aW1lcl9zZXR1cCkN
CisJICBib2FyZF90aW1lcl9zZXR1cCgmdGltZXJfaXJxYWN0aW9uKTsNCiB9
DQogDQogI2RlZmluZSBGRUJSVUFSWQkJMg0KZGlmZiAtTmF1ciBsaW51eC9h
cmNoL21pcHM2NC9zZ2ktaXAyNy9pcDI3LXNldHVwLmMgbGludXgucGF0Y2gv
YXJjaC9taXBzNjQvc2dpLWlwMjcvaXAyNy1zZXR1cC5jDQotLS0gbGludXgv
YXJjaC9taXBzNjQvc2dpLWlwMjcvaXAyNy1zZXR1cC5jCVRodSBEZWMgMjAg
MTg6MzA6MjAgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L3Nn
aS1pcDI3L2lwMjctc2V0dXAuYwlUaHUgRGVjIDIwIDIxOjM3OjQ5IDIwMDEN
CkBAIC0zMTEsNCArMzExLDUgQEANCiANCiAJbWlwc19pb19wb3J0X2Jhc2Ug
PSBJT19CQVNFOw0KIAlib2FyZF90aW1lX2luaXQgPSBpcDI3X3RpbWVfaW5p
dDsNCisJYm9hcmRfdGltZXJfc2V0dXAgPSBOVUxMOw0KIH0NCmRpZmYgLU5h
dXIgbGludXgvYXJjaC9taXBzNjQvc2dpLWlwMzIvaXAzMi1zZXR1cC5jIGxp
bnV4LnBhdGNoL2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzItc2V0dXAuYw0K
LS0tIGxpbnV4L2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzItc2V0dXAuYwlU
aHUgRGVjIDIwIDE4OjMwOjIwIDIwMDENCisrKyBsaW51eC5wYXRjaC9hcmNo
L21pcHM2NC9zZ2ktaXAzMi9pcDMyLXNldHVwLmMJVGh1IERlYyAyMCAyMToz
Nzo1OSAyMDAxDQpAQCAtOTEsNiArOTEsNyBAQA0KIA0KIAlydGNfb3BzID0g
JmlwMzJfcnRjX29wczsNCiAJYm9hcmRfdGltZV9pbml0ID0gaXAzMl90aW1l
X2luaXQ7DQorCWJvYXJkX3RpbWVyX3NldHVwID0gTlVMTDsNCiANCiAJY3Jp
bWVfaW5pdCAoKTsNCiB9DQo=
--279724308-280324098-1010093862=:8906--
