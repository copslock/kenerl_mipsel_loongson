Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2007 19:55:27 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:6375 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029540AbXKWTzR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2007 19:55:17 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IveZL-0004Ev-02; Fri, 23 Nov 2007 20:52:07 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id B86B0C2E30; Fri, 23 Nov 2007 20:51:52 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:	Fri, 23 Nov 2007 20:41:55 +0100
Subject: [PATCH] IP22: Fix modules for 64bit kernels by using a CKSEG2 MAP_BASE
Message-Id: <20071123195152.B86B0C2E30@solo.franken.de>
To:	undisclosed-recipients:;
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips


Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 include/asm-mips/mach-ip22/spaces.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/mach-ip22/spaces.h b/include/asm-mips/mach-ip22/spaces.h
index 7f9fa6f..8264d0a 100644
--- a/include/asm-mips/mach-ip22/spaces.h
+++ b/include/asm-mips/mach-ip22/spaces.h
@@ -18,7 +18,7 @@
 #define CAC_BASE		0xffffffff80000000
 #define IO_BASE			0xffffffffa0000000
 #define UNCAC_BASE		0xffffffffa0000000
-#define MAP_BASE		0xc000000000000000
+#define MAP_BASE		0xffffffffc0000000
 
 #endif /* CONFIG_64BIT */
 
-- 
1.4.4.4
