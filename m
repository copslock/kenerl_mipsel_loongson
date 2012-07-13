Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:31:40 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:57814 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2GMIbg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 10:31:36 +0200
Received: by bkcji2 with SMTP id ji2so2818019bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=T+E/ZyUwcH5fCod53kOijkGcdS51XYTrG5TnRKoTBJg=;
        b=WrnpEKNcaRfFoSpGvsM4Az/fp/C2EfXuUgzqzPX08rgnVPPrUU7KdKAcSrj9eJKGMw
         gzUnDdlNphSHSpWcyIq6t11LRTXPtVAmd5ShSP21jEhwOXU4ZCzrZp0bNMlyCJmqQFfJ
         CK0fYFQqRWTXRSV4K7gxR6TikJR5jnvn97WXesAQgkWwCEhEsbG5lOQhlm1ya6WjSco9
         VyB5hFNP4a73USSxgbBxCOEseUwqsddDl/LaEA9GZwA50s3NQwY2di61pHmiunpnDImT
         aORjkprotMjF5R6MlZF/vt1keSbvFj2NlWNVFQQd+vFzXCNwE/yrckXkenMb6eRGx/BX
         mXeg==
Received: by 10.204.155.69 with SMTP id r5mr150002bkw.49.1342168290653;
        Fri, 13 Jul 2012 01:31:30 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id gq2sm4211293bkc.13.2012.07.13.01.31.28
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 01:31:29 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: remove bogus ENETSW_TXDMA interrupts from BCM6328
Date:   Fri, 13 Jul 2012 10:30:46 +0200
Message-Id: <1342168246-18012-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

These were erroneously copied from BCM6368. BCM6328 does not expose the
ENETSW_TXDMA interrupts, and BCM_6328_HIGH_IRQ_BASE + 7 is actually used
for the second UART.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

Ralf, since there are no users for these (non) interrupts yet, I'll 
leave it at your discretion if you want to keep it as a separate patch
or merge it into 02a0111daed3103368123596b9960d10986c0f7a
("MIPS: BCM63XX: Add basic BCM6328 support").

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index e104ddb..9cc1b9f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -615,10 +615,10 @@ enum bcm63xx_irq {
 #define BCM_6328_ENETSW_RXDMA1_IRQ	(BCM_6328_HIGH_IRQ_BASE + 1)
 #define BCM_6328_ENETSW_RXDMA2_IRQ	(BCM_6328_HIGH_IRQ_BASE + 2)
 #define BCM_6328_ENETSW_RXDMA3_IRQ	(BCM_6328_HIGH_IRQ_BASE + 3)
-#define BCM_6328_ENETSW_TXDMA0_IRQ	(BCM_6328_HIGH_IRQ_BASE + 4)
-#define BCM_6328_ENETSW_TXDMA1_IRQ	(BCM_6328_HIGH_IRQ_BASE + 5)
-#define BCM_6328_ENETSW_TXDMA2_IRQ	(BCM_6328_HIGH_IRQ_BASE + 6)
-#define BCM_6328_ENETSW_TXDMA3_IRQ	(BCM_6328_HIGH_IRQ_BASE + 7)
+#define BCM_6328_ENETSW_TXDMA0_IRQ	0
+#define BCM_6328_ENETSW_TXDMA1_IRQ	0
+#define BCM_6328_ENETSW_TXDMA2_IRQ	0
+#define BCM_6328_ENETSW_TXDMA3_IRQ	0
 #define BCM_6328_XTM_IRQ		(BCM_6328_HIGH_IRQ_BASE + 31)
 #define BCM_6328_XTM_DMA0_IRQ		(BCM_6328_HIGH_IRQ_BASE + 11)
 
-- 
1.7.2.5
