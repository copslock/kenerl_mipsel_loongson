Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PDv6nC002104
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 06:57:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PDv6kW002103
	for linux-mips-outgoing; Sat, 25 May 2002 06:57:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PDuvnC002099
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 06:56:59 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17Bc3U-0004dF-00
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 08:58:00 -0500
Message-ID: <3CEF9850.3020300@realitydiluted.com>
Date: Sat, 25 May 2002 08:57:36 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Removal of unneeded cache routines for NEC 5432...
Content-Type: multipart/mixed;
 boundary="------------020609040304070502060603"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------020609040304070502060603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes to unused cache routines. Please apply.

-Steve

--------------020609040304070502060603
Content-Type: text/plain;
 name="mips-5432remove.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-5432remove.diff"

diff -urN -X cvs-exc.txt mipslinux-2.4.18-xfs/arch/mips/mm/c-r5432.c settop/arch/mips/mm/c-r5432.c
--- mipslinux-2.4.18-xfs/arch/mips/mm/c-r5432.c	Fri Nov 30 07:28:06 2001
+++ settop/arch/mips/mm/c-r5432.c	Wed Jan 30 11:09:47 2002
@@ -42,34 +42,6 @@
 /* -------------------------------------------------------------------- */
 /* #include <asm/r4kcache.h> */
 
-static inline void flush_icache_line_indexed(unsigned long addr)
-{
-	__asm__ __volatile__(
-		".set noreorder\n\t"
-		".set mips3\n\t"
-		"cache %1, (%0)\n\t"
-		"cache %1, 1(%0)\n\t"
-		".set mips0\n\t"
-		".set reorder"
-		:
-		: "r" (addr),
-		  "i" (Index_Invalidate_I));
-}
-
-static inline void flush_dcache_line_indexed(unsigned long addr)
-{
-	__asm__ __volatile__(
-		".set noreorder\n\t"
-		".set mips3\n\t"
-		"cache %1, (%0)\n\t"
-		"cache %1, 1(%0)\n\t"
-		".set mips0\n\t"
-		".set reorder"
-		:
-		: "r" (addr),
-		  "i" (Index_Writeback_Inv_D));
-}
-
 static inline void flush_icache_line(unsigned long addr)
 {
 	__asm__ __volatile__(

--------------020609040304070502060603--
