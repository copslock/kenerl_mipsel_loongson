Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 06:07:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:37846 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225202AbTECFHu>; Sat, 3 May 2003 06:07:50 +0100
Received: from localhost (p3166-ip01funabasi.chiba.ocn.ne.jp [61.112.99.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 17CDD4769; Sat,  3 May 2003 14:07:44 +0900 (JST)
Date: Sat, 03 May 2003 14:15:18 +0900 (JST)
Message-Id: <20030503.141518.74756767.anemo@mba.ocn.ne.jp>
To: geert@linux-m68k.org
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: initrd_header for mips64 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.4.21.0305021617560.5468-100000@vervain.sonytel.be>
References: <20030502.220517.74756988.anemo@mba.ocn.ne.jp>
	<Pine.GSO.4.21.0305021617560.5468-100000@vervain.sonytel.be>
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
X-archive-position: 2262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 2 May 2003 16:18:42 +0200 (MEST), Geert Uytterhoeven <geert@linux-m68k.org> said:
geert> I think you better use u32 if it must be a 32-bit value.

Certainly.  Also it is better to use u32 in 32bit kernel too.

diff -ur linux-mips-cvs/arch/mips/kernel/setup.c linux.new/arch/mips/kernel/setup.c
--- linux-mips-cvs/arch/mips/kernel/setup.c	Thu Apr 17 23:54:17 2003
+++ linux.new/arch/mips/kernel/setup.c	Sat May  3 14:09:27 2003
@@ -246,17 +246,17 @@
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long tmp;
-	unsigned long *initrd_header;
+	u32 *initrd_header;
 #endif
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
 	int i;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
 	if (tmp < (unsigned long)&_end)
 		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
+	initrd_header = (u32 *)tmp;
 	if (initrd_header[0] == 0x494E5244) {
 		initrd_start = (unsigned long)&initrd_header[2];
 		initrd_end = initrd_start + initrd_header[1];
diff -ur linux-mips-cvs/arch/mips64/kernel/setup.c linux.new/arch/mips64/kernel/setup.c
--- linux-mips-cvs/arch/mips64/kernel/setup.c	Wed Apr  9 22:06:57 2003
+++ linux.new/arch/mips64/kernel/setup.c	Sat May  3 14:09:35 2003
@@ -245,17 +245,17 @@
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long tmp;
-	unsigned long *initrd_header;
+	u32 *initrd_header;
 #endif
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn;
 	int i;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
 	if (tmp < (unsigned long)&_end)
 		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
+	initrd_header = (u32 *)tmp;
 	if (initrd_header[0] == 0x494E5244) {
 		initrd_start = (unsigned long)&initrd_header[2];
 		initrd_end = initrd_start + initrd_header[1];
---
Atsushi Nemoto
