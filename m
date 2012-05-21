Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 17:33:51 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55417 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903567Ab2EUPdo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 17:33:44 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SWUc6-0003QD-BH; Mon, 21 May 2012 10:33:38 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>
Subject: [PATCH] MIPS: Add support for the MIPS32 4Kc family I/D caches.
Date:   Mon, 21 May 2012 10:33:32 -0500
Message-Id: <1337614412-29035-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/c-r4k.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 18546fa..bca1447 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1000,7 +1000,7 @@ static void __cpuinit probe_pcache(void)
 			c->icache.linesz = 2 << lsize;
 		else
 			c->icache.linesz = lsize;
-		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
 		c->icache.ways = 1 + ((config1 >> 16) & 7);
 
 		icache_size = c->icache.sets *
@@ -1020,7 +1020,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.linesz = 2 << lsize;
 		else
 			c->dcache.linesz= lsize;
-		c->dcache.sets = 64 << ((config1 >> 13) & 7);
+		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
 		c->dcache.ways = 1 + ((config1 >> 7) & 7);
 
 		dcache_size = c->dcache.sets *
-- 
1.7.10
