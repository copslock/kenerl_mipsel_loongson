Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 22:40:55 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:49126 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573737AbXKZWkQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 22:40:16 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmch-0006QN-03; Mon, 26 Nov 2007 23:40:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 16FBEC2B26; Mon, 26 Nov 2007 23:39:44 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Date:	Sun, 25 Nov 2007 11:27:06 +0100
Subject: [PATCH] IP22/IP28: fix extracting board/chip rev
Message-Id: <20071126223944.16FBEC2B26@solo.franken.de>
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Taken from Peter Fuersts IP28 patches

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 include/asm-mips/sgi/ioc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/sgi/ioc.h b/include/asm-mips/sgi/ioc.h
index f3e3dc9..343ed15 100644
--- a/include/asm-mips/sgi/ioc.h
+++ b/include/asm-mips/sgi/ioc.h
@@ -138,8 +138,8 @@ struct sgioc_regs {
 	u8 _sysid[3];
 	volatile u8 sysid;
 #define SGIOC_SYSID_FULLHOUSE	0x01
-#define SGIOC_SYSID_BOARDREV(x)	((x & 0xe0) > 5)
-#define SGIOC_SYSID_CHIPREV(x)	((x & 0x1e) > 1)
+#define SGIOC_SYSID_BOARDREV(x)	(((x) & 0x1e) >> 1)
+#define SGIOC_SYSID_CHIPREV(x)	(((x) & 0xe0) >> 5)
 	u32 _unused2;
 	u8 _read[3];
 	volatile u8 read;
-- 
1.4.4.4
