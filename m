Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64BTVRw002776
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:29:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64BTVM7002775
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:29:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BTKRw002578;
	Thu, 4 Jul 2002 04:29:20 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g64BXFC10129;
	Thu, 4 Jul 2002 13:33:15 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g64BXFTF027116;
	Thu, 4 Jul 2002 13:33:15 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17Q4rL-0000RJ-00; Thu, 04 Jul 2002 13:33:15 +0200
Date: Thu, 4 Jul 2002 13:33:15 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] Re: [PATCH] r4k icache flushing for mips64 CVS HEAD
In-Reply-To: <20020702004542.B32068@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0207041328550.1601-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-703588063-1025782395=:1601"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.2 required=5.0 tests=IN_REP_TO,MIME_NULL_BLOCK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-703588063-1025782395=:1601
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 2 Jul 2002, Ralf Baechle wrote:

> > 	This fixes icache flushing for the r4xx0 processor in the current
> > (CVS HEAD) 2.5.1 tree. The flush_cache_all function does nothing there,
> > that's why I moved it to flush_cache_l1.
> 
> Not right, I checked in a variation of it ...

Ok, but you forgot some things. The following patch adds the declaration
of _flush_cache_all in loadmmu.c and pgtables.h

I guess 3 patches is enough for today ;) More coming later ;)

regards,
Vivien.

--279724308-703588063-1025782395=:1601
Content-Type: TEXT/plain; name="linux-mips64-r4k_flush_cache_all.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0207041333150.1601@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips64-r4k_flush_cache_all.diff"

ZGlmZiAtTmF1ciBsaW51eC9pbmNsdWRlL2FzbS1taXBzNjQvcGd0YWJsZS5o
IGxpbnV4LnBhdGNoL2luY2x1ZGUvYXNtLW1pcHM2NC9wZ3RhYmxlLmgNCi0t
LSBsaW51eC9pbmNsdWRlL2FzbS1taXBzNjQvcGd0YWJsZS5oCVRodSBKdWwg
IDQgMTA6MTI6NTYgMjAwMg0KKysrIGxpbnV4LnBhdGNoL2luY2x1ZGUvYXNt
LW1pcHM2NC9wZ3RhYmxlLmgJVGh1IEp1bCAgNCAxMToxNzoyMyAyMDAyDQpA
QCAtMjcsNiArMjcsNyBAQA0KICAqICAtIGZsdXNoX2NhY2hlX3JhbmdlKG1t
LCBzdGFydCwgZW5kKSBmbHVzaGVzIGEgcmFuZ2Ugb2YgcGFnZXMNCiAgKiAg
LSBmbHVzaF9wYWdlX3RvX3JhbShwYWdlKSB3cml0ZSBiYWNrIGtlcm5lbCBw
YWdlIHRvIHJhbQ0KICAqLw0KK2V4dGVybiB2b2lkICgqX2ZsdXNoX2NhY2hl
X2FsbCkodm9pZCk7DQogZXh0ZXJuIHZvaWQgKCpfZmx1c2hfY2FjaGVfbW0p
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsNCiBleHRlcm4gdm9pZCAoKl9mbHVz
aF9jYWNoZV9yYW5nZSkoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVk
IGxvbmcgc3RhcnQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyBlbmQpOw0KZGlmZiAtTmF1ciBsaW51eC9hcmNo
L21pcHM2NC9tbS9sb2FkbW11LmMgbGludXgucGF0Y2gvYXJjaC9taXBzNjQv
bW0vbG9hZG1tdS5jDQotLS0gbGludXgvYXJjaC9taXBzNjQvbW0vbG9hZG1t
dS5jCVRodSBKdWwgIDQgMTA6MTI6MjggMjAwMg0KKysrIGxpbnV4LnBhdGNo
L2FyY2gvbWlwczY0L21tL2xvYWRtbXUuYwlUaHUgSnVsICA0IDExOjMyOjQ1
IDIwMDINCkBAIC0yNCw2ICsyNCw3IEBADQogdm9pZCAoKl9jb3B5X3BhZ2Up
KHZvaWQgKiB0bywgdm9pZCAqIGZyb20pOw0KIA0KIC8qIENhY2hlIG9wZXJh
dGlvbnMuICovDQordm9pZCAoKl9mbHVzaF9jYWNoZV9hbGwpKHZvaWQpOw0K
IHZvaWQgKCpfZmx1c2hfY2FjaGVfbW0pKHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
KTsNCiB2b2lkICgqX2ZsdXNoX2NhY2hlX3JhbmdlKShzdHJ1Y3QgbW1fc3Ry
dWN0ICptbSwgdW5zaWduZWQgbG9uZyBzdGFydCwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGVuZCk7DQo=
--279724308-703588063-1025782395=:1601--
