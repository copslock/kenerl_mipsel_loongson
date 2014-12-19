Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 11:41:15 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55742 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008668AbaLSKlN7Hc-D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 11:41:13 +0100
Received: by mail-pa0-f43.google.com with SMTP id kx10so966352pab.30;
        Fri, 19 Dec 2014 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tWWeUKpiYsDAN5PRKauJmnps+u0R4jDkMfA4fWibtFI=;
        b=n2KTDsTKEpG46KPtNT8CSwSgOQqpe02/8k2/jHrPpLe+7FFqP3tswMZrnkXgf7tqpX
         vAIxhvfP/qT45bnPjoHHbq7UgMdrD+zyPZatHxbW9KHeMtlmVlqgl6qfOpOl8G2HTo/i
         dG1XERxWVbOvBN1X1xfg+jPI3j+xZg7IYnzSJ8PxYFSBoi8gIM9UKE+G1ytapzzMm4m1
         LzHi7J97yuiAPkiJaApaXTubO6d8WQ4wS4p87tkYpjbc4dZEhx2l3kyA5wzKHkbI90k5
         XY/QEb0Y0VyMa1umpOG3km7ecsyqBHVwsp1KZ0B0EaXTCoxshe86qpNuqePXPuFO9hDq
         lfNw==
X-Received: by 10.70.33.228 with SMTP id u4mr11525142pdi.146.1418985667527;
        Fri, 19 Dec 2014 02:41:07 -0800 (PST)
Received: from localhost.localdomain ([59.12.167.210])
        by mx.google.com with ESMTPSA id c17sm9290502pdl.6.2014.12.19.02.41.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Dec 2014 02:41:06 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: fix overwriting without setting the bit
Date:   Fri, 19 Dec 2014 19:40:21 +0900
Message-Id: <1418985621-4210-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 1.9.3 (Apple Git-50)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

To flush to readahead cache, set 8th bit in the RAC_CONFIG.

The previous commit "MIPS: BMIPS: Flush the readahead cache after DMA"
has a problem overwriting to the original other configuration values.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/mm/dma-default.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index ee6d12c..38ee47a 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -74,9 +74,11 @@ static inline int cpu_needs_post_dma_flush(struct device *dev)
 	    boot_cpu_type() == CPU_BMIPS4350 ||
 	    boot_cpu_type() == CPU_BMIPS4380) {
 		void __iomem *cbr = BMIPS_GET_CBR();
+		u32 cfg;
 
 		/* Flush stale data out of the readahead cache */
-		__raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
+		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
 		__raw_readl(cbr + BMIPS_RAC_CONFIG);
 
 		return 0;
-- 
1.9.3
