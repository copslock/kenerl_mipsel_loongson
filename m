Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 14:02:38 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:32207 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224934AbULUOCb>; Tue, 21 Dec 2004 14:02:31 +0000
Received: from localhost (p7164-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.164])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4D42283CE; Tue, 21 Dec 2004 23:02:14 +0900 (JST)
Date: Tue, 21 Dec 2004 23:07:40 +0900 (JST)
Message-Id: <20041221.230740.74756890.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: initrd_header for mips64 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030502.220517.74756988.anemo@mba.ocn.ne.jp>
References: <20030502.220517.74756988.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 02 May 2003 22:05:17 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> I found that initrd_header in mips64 cvs kernel is broken.  The
anemo> initrd_header should be consist of two 32bit words while 32bit
anemo> addinitrd is used for 64bit kernel too.

This is not still fixed.  Here is a revised patch for 2.6 tree.
Could you apply?

diff -u linux-mips/arch/mips/kernel/setup.c linux/arch/mips/kernel/
--- linux-mips/arch/mips/kernel/setup.c	Sat Dec 18 22:11:28 2004
+++ linux/arch/mips/kernel/setup.c	Sat Dec 18 21:20:59 2004
@@ -281,12 +281,12 @@
 		initrd_reserve_bootmem = 1;
 	} else {
 		unsigned long tmp;
-		unsigned long *initrd_header;
+		u32 *initrd_header;
 
-		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
 		if (tmp < reserved_end)
 			tmp += PAGE_SIZE;
-		initrd_header = (unsigned long *)tmp;
+		initrd_header = (u32 *)tmp;
 		if (initrd_header[0] == 0x494E5244) {
 			initrd_start = (unsigned long)&initrd_header[2];
 			initrd_end = initrd_start + initrd_header[1];

---
Atsushi Nemoto
