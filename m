Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 14:22:52 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:8494
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225215AbTGENWu>; Sat, 5 Jul 2003 14:22:50 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19Ymze-0000xZ-00; Sat, 05 Jul 2003 15:22:22 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] ndelay typo?
Cc: linux-mips@linux-mips.org
Message-Id: <E19Ymze-0000xZ-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sat, 05 Jul 2003 15:22:22 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	I presume you meant this?

/Brian

Index: include/asm/delay.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/delay.h,v
retrieving revision 1.10.2.4
diff -u -r1.10.2.4 delay.h
--- include/asm/delay.h	5 Jul 2003 03:23:46 -0000	1.10.2.4
+++ include/asm/delay.h	5 Jul 2003 13:18:24 -0000
@@ -73,6 +73,6 @@
 #endif
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
-#define ndelay(usecs) __udelay((usecs),__udelay_val)
+#define ndelay(usecs) __ndelay((usecs),__udelay_val)
 
 #endif /* _ASM_DELAY_H */
