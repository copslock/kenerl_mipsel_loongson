Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2003 22:40:44 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:2092
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225213AbTFTVkm>; Fri, 20 Jun 2003 22:40:42 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19TTca-0007WN-00; Fri, 20 Jun 2003 23:40:36 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] ide.h fix(es)
Cc: linux-mips@linux-mips.org
Message-Id: <E19TTca-0007WN-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Fri, 20 Jun 2003 23:40:36 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
this fixes some problems with undefined symbols in IDE and also
seems to work (as far as my limited testing can go at the moment).
Sorry if I was out of order in removing the big endian stuff, 
I just couldn't see the point.

/Brian

Index: include/asm-mips/ide.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/ide.h,v
retrieving revision 1.21
diff -u -r1.21 ide.h
--- include/asm-mips/ide.h	3 Nov 2002 22:02:29 -0000	1.21
+++ include/asm-mips/ide.h	20 Jun 2003 21:36:59 -0000
@@ -64,28 +64,10 @@
 #endif
 }
 
-#ifdef __BIG_ENDIAN
-
-/* get rid of defs from io.h - ide has its private and conflicting versions */
-#ifdef insw
-#undef insw
-#endif
-#ifdef outsw
-#undef outsw
-#endif
-#ifdef insl
-#undef insl
-#endif
-#ifdef outsl
-#undef outsl
-#endif
-
-#define insw(port, addr, count) ide_insw(port, addr, count)
-#define insl(port, addr, count) ide_insl(port, addr, count)
-#define outsw(port, addr, count) ide_outsw(port, addr, count)
-#define outsl(port, addr, count) ide_outsl(port, addr, count)
-
-#endif /* __BIG_ENDIAN */
+#define __ide_mm_insw   ide_insw
+#define __ide_mm_insl   ide_insl
+#define __ide_mm_outsw  ide_outsw
+#define __ide_mm_outsl  ide_outsl
 
 #endif /* __KERNEL__ */
 
