Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 17:38:20 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:57131 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492050Ab0EQPiQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 May 2010 17:38:16 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 366FF1B4241;
        Tue, 18 May 2010 00:38:10 +0900 (JST)
Received: from localhost.localdomain (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Tue, 18 May 2010 00:38:10 +0900 (JST)
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] tx49xx: define ARCH_KMALLOC_MINALIGN
Date:   Tue, 18 May 2010 00:38:05 +0900
Message-Id: <1274110685-13196-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

With SLAB, it works without ARCH_KMALLOC_MINALIGN, but with SLOB/SLUB,
ARCH_KMALLOC_MINALIGN is required to ensure alignment of kmalloced
buffer.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/mach-tx49xx/kmalloc.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-tx49xx/kmalloc.h b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
index 913ff19..b74caf6 100644
--- a/arch/mips/include/asm/mach-tx49xx/kmalloc.h
+++ b/arch/mips/include/asm/mach-tx49xx/kmalloc.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_MACH_TX49XX_KMALLOC_H
 #define __ASM_MACH_TX49XX_KMALLOC_H
 
-/*
- * All happy, no need to define ARCH_KMALLOC_MINALIGN
- */
+#define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
 
 #endif /* __ASM_MACH_TX49XX_KMALLOC_H */
-- 
1.5.6.5
