Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 22:35:23 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33048 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014278AbbDGUfGy6HJj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 22:35:06 +0200
Received: by paboj16 with SMTP id oj16so90376110pab.0;
        Tue, 07 Apr 2015 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3BE86hV8Jnnigw2sHMEVBwCZsO0cQ1BggHUklzsq+3A=;
        b=CU0oX3xF5bitQItZvgfkIGx5wdBn+kL2NGV18Z25NA82EhEHyMvMDLnoS67mJZ4Oxc
         rvCK8IJQKu6D7kNogIWdS+s4b9y1aLR7eeuFr+tBKPDOCjhOhmnn77ldmMpBNeFjJeK7
         b73njQcvdbHXz/+S1Tgh2Ny8bzmNxbtsPFBKefF0z1cPvkwbvy5R9v3iqSmqM87/kygo
         kF/hQCoYC6oU+4cOvLUkC4DWNfg1/MveU3YiTwNpFI0w+rCf/lQA1k81F+YD2pm50suZ
         0eokyaf0jnSYOiiAkxqF6rXX374/LhcztgM5CQESrIXqbUU2Z7H+VovabAvv7OGIlyEj
         /1jA==
X-Received: by 10.68.194.137 with SMTP id hw9mr40223582pbc.162.1428438902062;
        Tue, 07 Apr 2015 13:35:02 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ve3sm8856029pbc.22.2015.04.07.13.35.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 13:35:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/3] MIPS: BMIPS: Move post DMA flush implementation to common header
Date:   Tue,  7 Apr 2015 13:34:00 -0700
Message-Id: <1428438842-5728-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
References: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46818
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

arch/mips/include/asm/mach-bmips/dma-coherence.h contains the
plat_post_dma_flush implementation which is not specific to mach-bmips,
but required for all BMIPS-based systems.

Move plat_post_dma_flush to arch/mips/include/asm/bmips.h, rename it to
bmips_post_dma_flush such that other platforms like bcm63xx can utilize
it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/bmips.h                    | 16 ++++++++++++++++
 arch/mips/include/asm/mach-bmips/dma-coherence.h | 16 +---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 30939b02e3ff..6d25ad33ec78 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -122,6 +122,22 @@ static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 	barrier();
 }
 
+static inline void bmips_post_dma_flush(struct device *dev)
+{
+	void __iomem *cbr = BMIPS_GET_CBR();
+	u32 cfg;
+
+	if (boot_cpu_type() != CPU_BMIPS3300 &&
+	    boot_cpu_type() != CPU_BMIPS4350 &&
+	    boot_cpu_type() != CPU_BMIPS4380)
+		return;
+
+	/* Flush stale data out of the readahead cache */
+	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
+	__raw_readl(cbr + BMIPS_RAC_CONFIG);
+}
+
 #endif /* !defined(__ASSEMBLY__) */
 
 #endif /* _ASM_BMIPS_H */
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
index ee3c713d642e..d29781f02285 100644
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ b/arch/mips/include/asm/mach-bmips/dma-coherence.h
@@ -49,20 +49,6 @@ static inline int plat_device_is_coherent(struct device *dev)
 	return 0;
 }
 
-static inline void plat_post_dma_flush(struct device *dev)
-{
-	void __iomem *cbr = BMIPS_GET_CBR();
-	u32 cfg;
-
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
-	/* Flush stale data out of the readahead cache */
-	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-	__raw_readl(cbr + BMIPS_RAC_CONFIG);
-}
+#define plat_post_dma_flush	bmips_post_dma_flush
 
 #endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
-- 
2.1.0
