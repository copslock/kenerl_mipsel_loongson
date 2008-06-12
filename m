Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 00:25:41 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:25585 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28581272AbYFLXZi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2008 00:25:38 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m5CNPbDs025412;
	Fri, 13 Jun 2008 01:25:37 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m5CNPbMb025408;
	Fri, 13 Jun 2008 00:25:37 +0100
Date:	Fri, 13 Jun 2008 00:25:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] decstation: Document more MB ASIC register bits
Message-ID: <Pine.LNX.4.55.0806130015490.23634@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Document a few more register bits provided by the MB ASIC used on R4000SC
(KN04) and R4400SC (KN05) CPU daughtercards with the DECstation.  

 Reverse-engineered and not documented anywhere else to the best of my
knowledge.  Bit names appended to the last underscore the same as reported
by the firmware in register dumps.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
patch-mips-2.6.23-rc5-20070904-dec-kn4k-mb-int-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/dec/kn05.h linux-mips-2.6.23-rc5-20070904/include/asm-mips/dec/kn05.h
--- linux-mips-2.6.23-rc5-20070904.macro/include/asm-mips/dec/kn05.h	2005-07-20 05:00:28.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/include/asm-mips/dec/kn05.h	2007-10-11 00:11:52.000000000 +0000
@@ -6,7 +6,7 @@
  *	KN04-CA) and DECsystem 5900/260 (KN05) R4k CPU card MB ASIC
  *	definitions.
  *
- *	Copyright (C) 2002, 2003, 2005  Maciej W. Rozycki
+ *	Copyright (C) 2002, 2003, 2005, 2008  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -54,11 +54,11 @@
  */
 #define KN4K_MB_INT_TC		(1<<0)		/* TURBOchannel? */
 #define KN4K_MB_INT_RTC		(1<<1)		/* RTC? */
-#define KN4K_MB_INT_MT		(1<<3)		/* ??? */
+#define KN4K_MB_INT_MT		(1<<3)		/* I/O ASIC cascade */
 
 /*
  * Bits for the MB control & status register.
- * Set to 0x00bf8001 on my system by the ROM.
+ * Set to 0x00bf8001 for KN05 and to 0x003f8000 for KN04 by the firmware.
  */
 #define KN4K_MB_CSR_PF		(1<<0)		/* PreFetching enable? */
 #define KN4K_MB_CSR_F		(1<<1)		/* ??? */
@@ -69,7 +69,8 @@
 #define KN4K_MB_CSR_IM		(1<<13)		/* ??? */
 #define KN4K_MB_CSR_NC		(1<<14)		/* ??? */
 #define KN4K_MB_CSR_EE		(1<<15)		/* (bus) Exception Enable? */
-#define KN4K_MB_CSR_MSK		(0x1f<<16)	/* ??? */
+#define KN4K_MB_CSR_MSK		(0x1f<<16)	/* CPU Int[4:0] mask */
 #define KN4K_MB_CSR_FW		(1<<21)		/* ??? */
+#define KN4K_MB_CSR_W		(1<<31)		/* ??? */
 
 #endif /* __ASM_MIPS_DEC_KN05_H */
