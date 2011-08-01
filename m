Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 23:09:38 +0200 (CEST)
Received: from swampdragon.chaosbits.net ([90.184.90.115]:14427 "EHLO
        swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab1HAVJe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2011 23:09:34 +0200
Received: by swampdragon.chaosbits.net (Postfix, from userid 1000)
        id E98D49405D; Mon,  1 Aug 2011 23:09:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by swampdragon.chaosbits.net (Postfix) with ESMTP id E7B2E9405C;
        Mon,  1 Aug 2011 23:09:33 +0200 (CEST)
Date:   Mon, 1 Aug 2011 23:09:33 +0200 (CEST)
From:   Jesper Juhl <jj@chaosbits.net>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     trivial@kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH][Resend] Remove unneeded version.h includes from arch/mips/
Message-ID: <alpine.LNX.2.00.1108012308110.31999@swampdragon.chaosbits.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 30788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jj@chaosbits.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 761

It was pointed out by 'make versioncheck' that some includes of
linux/version.h are not needed in arch/mips/.
This patch removes them.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/mips/include/asm/mach-powertv/dma-coherence.h |    1 -
 arch/mips/lantiq/xway/ebu.c                        |    1 -
 arch/mips/lantiq/xway/pmu.c                        |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index 62c0940..3537164 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -13,7 +13,6 @@
 #define __ASM_MACH_POWERTV_DMA_COHERENCE_H
 
 #include <linux/sched.h>
-#include <linux/version.h>
 #include <linux/device.h>
 #include <asm/mach-powertv/asic.h>
 
diff --git a/arch/mips/lantiq/xway/ebu.c b/arch/mips/lantiq/xway/ebu.c
index 66eb52f..033b318 100644
--- a/arch/mips/lantiq/xway/ebu.c
+++ b/arch/mips/lantiq/xway/ebu.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/ioport.h>
 
 #include <lantiq_soc.h>
diff --git a/arch/mips/lantiq/xway/pmu.c b/arch/mips/lantiq/xway/pmu.c
index 9d69f01e..39f0d26 100644
--- a/arch/mips/lantiq/xway/pmu.c
+++ b/arch/mips/lantiq/xway/pmu.c
@@ -8,7 +8,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/ioport.h>
 
 #include <lantiq_soc.h>
-- 
1.7.6


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
