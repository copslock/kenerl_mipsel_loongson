Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 13:57:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:58305 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225197AbTEBM5x>; Fri, 2 May 2003 13:57:53 +0100
Received: from localhost (p5238-ip01funabasi.chiba.ocn.ne.jp [219.96.147.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CB7613EC2; Fri,  2 May 2003 21:57:45 +0900 (JST)
Date: Fri, 02 May 2003 22:05:17 +0900 (JST)
Message-Id: <20030502.220517.74756988.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: initrd_header for mips64 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that initrd_header in mips64 cvs kernel is broken.  The
initrd_header should be consist of two 32bit words while 32bit
addinitrd is used for 64bit kernel too.

diff -ur linux-mips-cvs/arch/mips64/kernel/setup.c linux.new/arch/mips64/kernel/setup.c
--- linux-mips-cvs/arch/mips64/kernel/setup.c	Wed Apr  9 22:06:57 2003
+++ linux.new/arch/mips64/kernel/setup.c	Fri May  2 21:47:36 2003
@@ -245,7 +245,7 @@
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long tmp;
-	unsigned long *initrd_header;
+	unsigned int *initrd_header;
 #endif
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn;
@@ -255,7 +255,7 @@
 	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
 	if (tmp < (unsigned long)&_end)
 		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
+	initrd_header = (unsigned int *)tmp;
 	if (initrd_header[0] == 0x494E5244) {
 		initrd_start = (unsigned long)&initrd_header[2];
 		initrd_end = initrd_start + initrd_header[1];
---
Atsushi Nemoto
