Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 23:23:40 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:43482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006152AbcA0WXi4mhbr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 23:23:38 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B6F9F6045B;
        Wed, 27 Jan 2016 22:23:37 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AA81160498; Wed, 27 Jan 2016 22:23:37 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22AED60290;
        Wed, 27 Jan 2016 22:23:36 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Use generic clkdev.h header
Date:   Wed, 27 Jan 2016 14:23:36 -0800
Message-Id: <1453933416-9714-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.3.369.g91ad409
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The generic header file is equivalent to the MIPS one, so use the
generic one instead.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Not compiled, just made from visual inspection.

 arch/mips/include/asm/Kbuild   |  1 +
 arch/mips/include/asm/clkdev.h | 27 ---------------------------
 2 files changed, 1 insertion(+), 27 deletions(-)
 delete mode 100644 arch/mips/include/asm/clkdev.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index c7fe4d01e79c..9740066cc631 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
+generic-y += clkdev.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += dma-contiguous.h
diff --git a/arch/mips/include/asm/clkdev.h b/arch/mips/include/asm/clkdev.h
deleted file mode 100644
index 1b3ad7b09dc1..000000000000
--- a/arch/mips/include/asm/clkdev.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *  based on arch/arm/include/asm/clkdev.h
- *
- *  Copyright (C) 2008 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Helper for the clk API to assist looking up a struct clk.
- */
-#ifndef __ASM_CLKDEV_H
-#define __ASM_CLKDEV_H
-
-#include <linux/slab.h>
-
-#ifndef CONFIG_COMMON_CLK
-#define __clk_get(clk)	({ 1; })
-#define __clk_put(clk)	do { } while (0)
-#endif
-
-static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
-{
-	return kzalloc(size, GFP_KERNEL);
-}
-
-#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
