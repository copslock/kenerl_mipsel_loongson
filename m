Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:01:36 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63496 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009907AbaLYR53LOV-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:29 +0100
Received: by mail-pd0-f175.google.com with SMTP id g10so11869380pdj.34;
        Thu, 25 Dec 2014 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=noec5llOx3fiiqDSbsFb5LlUr4KonARuLA/rOX136T0=;
        b=jxNwOh5gVom8YQIF/Z1edLg3Hfj7h8aRLJOzg5p/IXMIWGRS5p6yTV4afJIxdRBjlp
         KtdeF4TMtsXVXHkoT64NUGfammZzQfTZhJJkCDnuhZ54aBPuXTFtw/dspYYMrnlNB2C/
         7tDOQ2xzdoJ02FTstJj1wqmT9Bp0fQQP8MEzegGCvNAh8xdCOpGsC5xRFM/c1Kv3E1Dq
         AfktfzPktHoJa1ab+9CnQBJ7gPl5jahdGAJRXh6HEIfBBElk4UwGzFcvywYT5o+6iiV1
         lx75RjWp7SBig/Y5pk3cu6A6kc5OjAZIdTzo9ljGw2Kcj01xVp5BWbkx30qu0HiFscuz
         OrKQ==
X-Received: by 10.68.217.197 with SMTP id pa5mr62710395pbc.32.1419530243560;
        Thu, 25 Dec 2014 09:57:23 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.22
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:22 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 15/25] MIPS: BMIPS: Flush the readahead cache after DMA
Date:   Thu, 25 Dec 2014 09:49:10 -0800
Message-Id: <1419529760-9520-16-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
may cause parts of the DMA buffer to be prefetched into the RAC.  To
avoid possible coherency problems, flush the RAC upon DMA completion.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/mm/dma-default.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index af5f046..38ee47a 100644
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
2.1.1
