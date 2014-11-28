Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:36:52 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65470 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007483AbaK1EdbByBXy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:31 +0100
Received: by mail-pa0-f45.google.com with SMTP id lj1so6077451pab.4
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4oPNQ/HPpAgaa4SBmoQQnnHweiA010n4+zSj8P0ZPs=;
        b=fJYC5By1J1eVYlXHFMa806vID27/7uJ1TOs96UwM1CSo1esEblCLslDPlIw+666xw3
         WQBeSblwldSQoGYSAMp4YGyr/iHWS/gq3Lzc0twoX0/G9XOC5EAcJd09wOS+1JAYonZo
         SmZFLw4q8F9NX6vyuLXM/x5akNBitMV/JjxhiU0tgTIAHrJfBYyRLOW3AwXGBDcIvJlL
         3yHMgkrUs9iWYPhIm+3yIwwbDN5Pu55mPPn7NHlz1jQeVCAEgWgUUTSjbQwlyc/FPLdn
         vvdAyAW3OEFBYgLB/5RybabKO4d97TBEo3tRX96dv4nuLuXzB0k7mdLQcJheIynbU0gX
         m8vw==
X-Received: by 10.68.213.138 with SMTP id ns10mr68341351pbc.50.1417149205382;
        Thu, 27 Nov 2014 20:33:25 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:24 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 13/16] MIPS: BMIPS: Flush the readahead cache after DMA
Date:   Thu, 27 Nov 2014 20:32:19 -0800
Message-Id: <1417149142-3756-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44504
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
---
 arch/mips/mm/dma-default.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index af5f046e627e..ee6d12cb7588 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/dma-contiguous.h>
 
+#include <asm/bmips.h>
 #include <asm/cache.h>
 #include <asm/cpu-type.h>
 #include <asm/io.h>
@@ -69,6 +70,18 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  */
 static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
+	if (boot_cpu_type() == CPU_BMIPS3300 ||
+	    boot_cpu_type() == CPU_BMIPS4350 ||
+	    boot_cpu_type() == CPU_BMIPS4380) {
+		void __iomem *cbr = BMIPS_GET_CBR();
+
+		/* Flush stale data out of the readahead cache */
+		__raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
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
