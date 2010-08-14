Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Aug 2010 09:02:47 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:55201 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491097Ab0HNHCm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Aug 2010 09:02:42 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o7E72bxp002949;
        Sat, 14 Aug 2010 16:02:38 +0900
Date:   Sat, 14 Aug 2010 16:02:37 +0900
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        anemo@mba.ocn.ne.jp
Subject: [PATCH] MIPS: TX49xx: rename ARCH_KMALLOC_MINALIGN to
 ARCH_DMA_MINALIGN
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100814160128H.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Sat, 14 Aug 2010 16:02:38 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
Return-Path: <fujita.tomonori@lab.ntt.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips

Architectures need to set ARCH_DMA_MINALIGN to the minimum DMA
alignment (the commit
a6eb9fe105d5de0053b261148cee56c94b4720ca). Defining
ARCH_KMALLOC_MINALIGN doesn't work anymore.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/mips/include/asm/mach-tx49xx/kmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-tx49xx/kmalloc.h b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
index b74caf6..ff9a8b8 100644
--- a/arch/mips/include/asm/mach-tx49xx/kmalloc.h
+++ b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_MACH_TX49XX_KMALLOC_H
 #define __ASM_MACH_TX49XX_KMALLOC_H
 
-#define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
+#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
 
 #endif /* __ASM_MACH_TX49XX_KMALLOC_H */
-- 
1.6.5
