Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g69KckRw031827
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Jul 2002 13:38:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g69KckqD031826
	for linux-mips-outgoing; Tue, 9 Jul 2002 13:38:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g69KcYRw031807;
	Tue, 9 Jul 2002 13:38:35 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g69KgpC06213;
	Tue, 9 Jul 2002 22:42:51 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g69KgqTF009221;
	Tue, 9 Jul 2002 22:42:52 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17S1ox-00064f-00; Tue, 09 Jul 2002 22:42:51 +0200
Date: Tue, 9 Jul 2002 22:42:51 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] O2 berr file fix
Message-ID: <Pine.LNX.4.21.0207092240200.23345-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-458953353-1026247371=:23345"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.8 required=5.0 tests=MIME_NULL_BLOCK,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-458953353-1026247371=:23345
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	This fixes a basic error: copy/pasting stuff from ip27 to ip32 :)

Please apply,
Vivien.

--- linux/arch/mips64/sgi-ip32/ip32-berr.c      Wed Jun 26 15:01:23 2002
+++ linux.patch/arch/mips64/sgi-ip32/ip32-berr.c        Thu Jul  4
12:27:21 2002
@@ -32,5 +32,5 @@
 void __init
 bus_error_init(void)
 {
-       be_board_handler = be_ip27_handler;
+       be_board_handler = be_ip32_handler;
 }


--279724308-458953353-1026247371=:23345
Content-Type: TEXT/plain; name="linux-O2-berr.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0207092242510.23345@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-O2-berr.diff"

LS0tIGxpbnV4L2FyY2gvbWlwczY0L3NnaS1pcDMyL2lwMzItYmVyci5jCVdl
ZCBKdW4gMjYgMTU6MDE6MjMgMjAwMg0KKysrIGxpbnV4LnBhdGNoL2FyY2gv
bWlwczY0L3NnaS1pcDMyL2lwMzItYmVyci5jCVRodSBKdWwgIDQgMTI6Mjc6
MjEgMjAwMg0KQEAgLTMyLDUgKzMyLDUgQEANCiB2b2lkIF9faW5pdA0KIGJ1
c19lcnJvcl9pbml0KHZvaWQpDQogew0KLQliZV9ib2FyZF9oYW5kbGVyID0g
YmVfaXAyN19oYW5kbGVyOw0KKwliZV9ib2FyZF9oYW5kbGVyID0gYmVfaXAz
Ml9oYW5kbGVyOw0KIH0NCg==
--279724308-458953353-1026247371=:23345--
