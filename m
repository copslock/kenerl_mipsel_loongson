Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2003 13:37:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:31462 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225192AbTEQMho>; Sat, 17 May 2003 13:37:44 +0100
Received: from localhost (p0446-ip01funabasi.chiba.ocn.ne.jp [211.130.235.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 16C18429A; Sat, 17 May 2003 21:37:37 +0900 (JST)
Date: Sat, 17 May 2003 21:45:55 +0900 (JST)
Message-Id: <20030517.214555.74756802.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: fix FIXADDR_TOP for TX39/TX49
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
X-archive-position: 2410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On TX39/TX49, high 16MB in virtual address space
(0xff000000-0xffffffff) are reserved and can not be used as
normal mapped/cached segment.

This patch fixes FIXADDR_TOP for TX39/TX49.  FIXADDR_TOP is used not
only if CONFIG_HIGHMEM is enabled.  It is also used for high limit
address for vmalloc.  

This patch can be applied to both 2.4 and 2.5.  I'm not sure whether
subtracting 0x2000 is necessary or not but doing it is a safe bet.
Please apply.

diff -u linux-mips-cvs/include/asm-mips/fixmap.h linux.new/include/asm-mips/
--- linux-mips-cvs/include/asm-mips/fixmap.h	Fri Jan 18 12:16:24 2002
+++ linux.new/include/asm-mips/fixmap.h	Sat May 17 21:25:18 2003
@@ -71,7 +71,11 @@
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
+#if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
+#define FIXADDR_TOP	(0xff000000UL - 0x2000)
+#else
 #define FIXADDR_TOP	(0xffffe000UL)
+#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
---
Atsushi Nemoto
