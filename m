Received:  by oss.sgi.com id <S305167AbQAKS6j>;
	Tue, 11 Jan 2000 10:58:39 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46126 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAKS6S>;
	Tue, 11 Jan 2000 10:58:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA28425; Tue, 11 Jan 2000 10:55:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA99911
	for linux-list;
	Tue, 11 Jan 2000 10:48:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA66419
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 11 Jan 2000 10:48:19 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA04758
	for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jan 2000 10:47:51 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port15.koeln.ivm.de [195.247.239.15])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA06807;
	Tue, 11 Jan 2000 19:47:30 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000111194757.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.3.p0.Linux:000111191551:230=_"
In-Reply-To: <Pine.LNX.4.05.10001111049230.25053-100000@callisto.of.borg>
Date:   Tue, 11 Jan 2000 19:47:57 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: kernel sources?
Cc:     linux@cthulhu.engr.sgi.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This message is in MIME format
--_=XFMail.1.3.p0.Linux:000111191551:230=_
Content-Type: text/plain; charset=us-ascii

Hi Geert,

On 11-Jan-00 Geert Uytterhoeven wrote:
> We are considering porting Linux to a R5000-based board.

Just beeing curious, what board?

> Now I'm wondering which kernel sources you suggest to start a port with. I
> tried the one from :pserver:cvs@linus.linux.sgi.com:/cvs (2.3.21) but
> compilation stopped due to a problem in serial.c (I compiled for
> CONFIG_ACER_PICA_61, just to see whether the tree worked).

This source tree as absolutely correct to start with. The attached patch should
fix the complilation problem.

---
Regards,
Harald

--_=XFMail.1.3.p0.Linux:000111191551:230=_
Content-Disposition: attachment; filename="serial-patch"
Content-Transfer-Encoding: 7bit
Content-Description: serial-patch
Content-Type: text/plain; charset=us-ascii; name=serial-patch; SizeOnDisk=301

--- /nfs/cvs/linux-2.3/linux/include/asm-mips/serial.h	Thu Aug 27 00:40:50 1998
+++ linux-idt/include/asm-mips/serial.h	Wed Jan  5 21:09:20 2000
@@ -38,6 +38,9 @@
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
 #define HUB6_FLAGS 0
+#define RS_TABLE_SIZE	64
+#else
+#define RS_TABLE_SIZE
 #endif
 
 /*

--_=XFMail.1.3.p0.Linux:000111191551:230=_--
End of MIME message
