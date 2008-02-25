Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 10:06:56 +0000 (GMT)
Received: from mx1.minet.net ([157.159.40.25]:60397 "EHLO mx1.minet.net")
	by ftp.linux-mips.org with ESMTP id S20036039AbYBYKGy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Feb 2008 10:06:54 +0000
Received: from localhost (spam.minet.net [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id C4C6D5CD36;
	Mon, 25 Feb 2008 11:06:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id 14C8C5CD29;
	Mon, 25 Feb 2008 11:06:41 +0100 (CET)
Received: from ibook (unknown [77.192.17.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id 1DF9C12FF0;
	Mon, 25 Feb 2008 11:07:05 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Mon, 25 Feb 2008 11:06:23 +0100
Subject: [PATCH] Remove references to BCM947XX
MIME-Version: 1.0
X-UID:	301
X-Length: 1640
To:	linux-mips@linux-mips.org
Cc:	Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802251106.24886.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch removes the remaining reference
to the BCM947xx development board codename.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/include/asm-mips/mach-bcm47xx/war.h b/include/asm-mips/mach-bcm47xx/war.h
index 4a2b798..87cd465 100644
--- a/include/asm-mips/mach-bcm47xx/war.h
+++ b/include/asm-mips/mach-bcm47xx/war.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
  */
-#ifndef __ASM_MIPS_MACH_BCM947XX_WAR_H
-#define __ASM_MIPS_MACH_BCM947XX_WAR_H
+#ifndef __ASM_MIPS_MACH_BCM47XX_WAR_H
+#define __ASM_MIPS_MACH_BCM47XX_WAR_H
 
 #define R4600_V1_INDEX_ICACHEOP_WAR	0
 #define R4600_V1_HIT_CACHEOP_WAR	0
@@ -22,4 +22,4 @@
 #define R10000_LLSC_WAR			0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
-#endif /* __ASM_MIPS_MACH_BCM947XX_WAR_H */
+#endif /* __ASM_MIPS_MACH_BCM47XX_WAR_H */
