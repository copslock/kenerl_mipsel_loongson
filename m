Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:21:47 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:10171 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S29559313AbYIXTVj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:21:39 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZve-0003nr-0U; Wed, 24 Sep 2008 21:21:38 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZvc-00059u-Ou; Wed, 24 Sep 2008 21:21:36 +0200
Date:	Wed, 24 Sep 2008 21:21:36 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Florian Fainelli <florian.fainelli@telecomint.eu>
Subject: [PATCH 3/6] [MIPS] Remove references to BCM947XX
Message-ID: <20080924192136.GD18700@volta.aurel32.net>
References: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080924191840.GA18700@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch removes the remaining reference
to the BCM947xx development board codename.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 include/asm-mips/mach-bcm47xx/war.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
-- 
1.5.6.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
