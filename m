Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:10:44 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:38604 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903844Ab1KPTKi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 20:10:38 +0100
Received: by wyh21 with SMTP id 21so1101328wyh.36
        for <multiple recipients>; Wed, 16 Nov 2011 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=WV9hU6qHdMEzlbK+w61BFjhCHLr/uX3oIcegm8LYpL0=;
        b=XAyjL8MRXuUwBnGlA8kRPRU2zwegj3UKTyHMFRcSZz7Q1y143YkrRrbZY7Ws/tJLJV
         TIJPUZp5/FP2lSx+tR223/JNglGij0Vl6ctvEYCNtaMRC3GEhC9dIE3giKT8VFIXm+o4
         Gth9U5TL+wC3HDuyTBaNNSLy54URWfVTMW7v0=
Received: by 10.227.206.82 with SMTP id ft18mr8192197wbb.21.1321470633129;
        Wed, 16 Nov 2011 11:10:33 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id c2sm12158871wbo.3.2011.11.16.11.10.31
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 11:10:32 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/3 v2] MIPS: BCM63xx: fix SDRAM size computation for BCM6345
Date:   Wed, 16 Nov 2011 20:10:36 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201111162010.37039.florian@openwrt.org>
X-archive-position: 31681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13731

Instead of hardcoding the amount of available RAM, read the number of
effective multiples of 8MB from SDRAM_MBASE_REG.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebased against mips-for-linux-next
- folded patch 1 and 2 together

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 8094168..8f0d6c7 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -170,8 +170,10 @@ static unsigned int detect_memory_size(void)
 	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
 	u32 val;
 
-	if (BCMCPU_IS_6345())
-		return (8 * 1024 * 1024);
+	if (BCMCPU_IS_6345()) {
+		val = bcm_sdram_readl(SDRAM_MBASE_REG);
+		return (val * 8 * 1024 * 1024);
+	}
 
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348()) {
 		val = bcm_sdram_readl(SDRAM_CFG_REG);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 5005750..6c9940f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -895,6 +895,8 @@
 #define SDRAM_CFG_BANK_SHIFT		13
 #define SDRAM_CFG_BANK_MASK		(1 << SDRAM_CFG_BANK_SHIFT)
 
+#define SDRAM_MBASE_REG			0xc
+
 #define SDRAM_PRIO_REG			0x2C
 #define SDRAM_PRIO_MIPS_SHIFT		29
 #define SDRAM_PRIO_MIPS_MASK		(1 << SDRAM_PRIO_MIPS_SHIFT)
-- 
1.7.5.4
