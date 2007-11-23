Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2007 19:52:48 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:62950 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029230AbXKWTwJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2007 19:52:09 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IveZL-0004Ev-01; Fri, 23 Nov 2007 20:52:07 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id E0A31C2E30; Fri, 23 Nov 2007 20:51:41 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:	Fri, 23 Nov 2007 20:40:15 +0100
Subject: [PATCH] IP22: Fix broken eeprom access by using __raw_readl/__raw_writel
Message-Id: <20071123195141.E0A31C2E30@solo.franken.de>
To:	undisclosed-recipients:;
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips


Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip22/ip22-nvram.c |   40 ++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-nvram.c b/arch/mips/sgi-ip22/ip22-nvram.c
index e19d60d..0177566 100644
--- a/arch/mips/sgi-ip22/ip22-nvram.c
+++ b/arch/mips/sgi-ip22/ip22-nvram.c
@@ -32,19 +32,19 @@
 	for (x=0; x<100000; x++) __asm__ __volatile__(""); })
 
 #define eeprom_cs_on(ptr) ({	\
-	*ptr &= ~EEPROM_DATO;	\
-	*ptr &= ~EEPROM_ECLK;	\
-	*ptr &= ~EEPROM_EPROT;	\
-	delay();		\
-	*ptr |= EEPROM_CSEL;	\
-	*ptr |= EEPROM_ECLK; })
+	__raw_writel(__raw_readl(ptr) & ~EEPROM_DATO, ptr);	\
+	__raw_writel(__raw_readl(ptr) & ~EEPROM_ECLK, ptr);	\
+	__raw_writel(__raw_readl(ptr) & ~EEPROM_EPROT, ptr);	\
+	delay();		                                \
+	__raw_writel(__raw_readl(ptr) | EEPROM_CSEL, ptr);	\
+	__raw_writel(__raw_readl(ptr) | EEPROM_ECLK, ptr); })
 
 
 #define eeprom_cs_off(ptr) ({	\
-	*ptr &= ~EEPROM_ECLK;	\
-	*ptr &= ~EEPROM_CSEL;	\
-	*ptr |= EEPROM_EPROT;	\
-	*ptr |= EEPROM_ECLK; })
+	__raw_writel(__raw_readl(ptr) & ~EEPROM_ECLK, ptr);	\
+	__raw_writel(__raw_readl(ptr) & ~EEPROM_CSEL, ptr);	\
+	__raw_writel(__raw_readl(ptr) | EEPROM_EPROT, ptr);	\
+	__raw_writel(__raw_readl(ptr) | EEPROM_ECLK, ptr); })
 
 #define	BITS_IN_COMMAND	11
 /*
@@ -60,15 +60,17 @@ static inline void eeprom_cmd(unsigned int *ctrl, unsigned cmd, unsigned reg)
 	ser_cmd = cmd | (reg << (16 - BITS_IN_COMMAND));
 	for (i = 0; i < BITS_IN_COMMAND; i++) {
 		if (ser_cmd & (1<<15))	/* if high order bit set */
-			writel(readl(ctrl) | EEPROM_DATO, ctrl);
+			__raw_writel(__raw_readl(ctrl) | EEPROM_DATO, ctrl);
 		else
-			writel(readl(ctrl) & ~EEPROM_DATO, ctrl);
-		writel(readl(ctrl) & ~EEPROM_ECLK, ctrl);
-		writel(readl(ctrl) | EEPROM_ECLK, ctrl);
+			__raw_writel(__raw_readl(ctrl) & ~EEPROM_DATO, ctrl);
+		__raw_writel(__raw_readl(ctrl) & ~EEPROM_ECLK, ctrl);
+		delay();
+		__raw_writel(__raw_readl(ctrl) | EEPROM_ECLK, ctrl);
+		delay();
 		ser_cmd <<= 1;
 	}
 	/* see data sheet timing diagram */
-	writel(readl(ctrl) & ~EEPROM_DATO, ctrl);
+	__raw_writel(__raw_readl(ctrl) & ~EEPROM_DATO, ctrl);
 }
 
 unsigned short ip22_eeprom_read(unsigned int *ctrl, int reg)
@@ -76,18 +78,18 @@ unsigned short ip22_eeprom_read(unsigned int *ctrl, int reg)
 	unsigned short res = 0;
 	int i;
 
-	writel(readl(ctrl) & ~EEPROM_EPROT, ctrl);
+	__raw_writel(__raw_readl(ctrl) & ~EEPROM_EPROT, ctrl);
 	eeprom_cs_on(ctrl);
 	eeprom_cmd(ctrl, EEPROM_READ, reg);
 
 	/* clock the data ouf of serial mem */
 	for (i = 0; i < 16; i++) {
-		writel(readl(ctrl) & ~EEPROM_ECLK, ctrl);
+		__raw_writel(__raw_readl(ctrl) & ~EEPROM_ECLK, ctrl);
 		delay();
-		writel(readl(ctrl) | EEPROM_ECLK, ctrl);
+		__raw_writel(__raw_readl(ctrl) | EEPROM_ECLK, ctrl);
 		delay();
 		res <<= 1;
-		if (readl(ctrl) & EEPROM_DATI)
+		if (__raw_readl(ctrl) & EEPROM_DATI)
 			res |= 1;
 	}
 
-- 
1.4.4.4
