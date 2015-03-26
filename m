Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 05:56:46 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36313 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006505AbbCZE4F6ZGby (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 05:56:05 +0100
Received: by padcy3 with SMTP id cy3so51575790pad.3;
        Wed, 25 Mar 2015 21:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OL+FQubstR8zG3AMC7iTdNTHUUihk0yeSYXr/7SEraY=;
        b=IJpmxl2BY1j5qzwNlKen/8KnvBC/R0BkOtJyPyjGpHnv1x8r+Rhtb4XxV8dLihN51v
         L8xdG9sGX52HIMELkwrUFAcHAjCfDfKbIAeMHl3QrZp4N6BUB4HYG4czAW99RYl8i4XF
         1+o4NthU8HHsaq1qJbVS1UN2yPm581GlCnhgKV9mVkRQvHmSNIEznovbjsNhq2qRQoYh
         FhoGyKKPsmJNpPMIoj9pnNtVzbfbCNQn9MmLHJp0jN4A0Xa2mVzBSYTBn00U+EYyWP8F
         0acAI/0zW1x++AUQIcOhrJ/fcmuCfqZU/3KlCgmrRslx0MI1huX8Ogq/zlvwqGbwRSJl
         1qTw==
X-Received: by 10.70.62.7 with SMTP id u7mr23664028pdr.108.1427345761246;
        Wed, 25 Mar 2015 21:56:01 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id hz13sm4110902pab.6.2015.03.25.21.55.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 21:56:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: Flush the readahead cache after DMA
Date:   Wed, 25 Mar 2015 21:55:14 -0700
Message-Id: <1427345715-16516-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
References: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Kevin Cernekee <cernekee@gmail.com>

BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
may cause parts of the DMA buffer to be prefetched into the RAC.  To
avoid possible coherency problems, flush the RAC upon DMA completion.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/bmips.h |  2 +-
 arch/mips/mm/dma-default.c    | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 30939b02e3ff..866cdbecebbf 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -40,7 +40,7 @@
 #define BMIPS_NMI_RESET_VEC		0x80000000
 #define BMIPS_WARM_RESTART_VEC		0x80000380
 
-#define ZSCM_REG_BASE			0x97000000
+#define ZSCM_REG_BASE			0x97000000UL
 
 #if !defined(__ASSEMBLY__)
 
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index af5f046e627e..38ee47acf06b 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/dma-contiguous.h>
 
+#include <asm/bmips.h>
 #include <asm/cache.h>
 #include <asm/cpu-type.h>
 #include <asm/io.h>
@@ -69,6 +70,20 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  */
 static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
+	if (boot_cpu_type() == CPU_BMIPS3300 ||
+	    boot_cpu_type() == CPU_BMIPS4350 ||
+	    boot_cpu_type() == CPU_BMIPS4380) {
+		void __iomem *cbr = BMIPS_GET_CBR();
+		u32 cfg;
+
+		/* Flush stale data out of the readahead cache */
+		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
+		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+
+		return 0;
+	}
+
 	return !plat_device_is_coherent(dev) &&
 	       (boot_cpu_type() == CPU_R10000 ||
 		boot_cpu_type() == CPU_R12000 ||
-- 
2.1.0
