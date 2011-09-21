Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:41:28 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50295 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491871Ab1IUNke (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 89FF732D686;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uUMvI7SX2Z0S; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 40BBA1252C2;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <ffainelli@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5] MIPS: bcm63xx: define SDRAM_MBASE_REG
Date:   Wed, 21 Sep 2011 15:39:43 +0200
Message-Id: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 31117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11649

From: Florian Fainelli <ffainelli@freebox.fr>

This register offset in the SDRAM controller is going to be used by BCM6345.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 0ed5230..6e803ac 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -734,6 +734,8 @@
 #define SDRAM_CFG_BANK_SHIFT		13
 #define SDRAM_CFG_BANK_MASK		(1 << SDRAM_CFG_BANK_SHIFT)
 
+#define SDRAM_MBASE_REG			0xc
+
 #define SDRAM_PRIO_REG			0x2C
 #define SDRAM_PRIO_MIPS_SHIFT		29
 #define SDRAM_PRIO_MIPS_MASK		(1 << SDRAM_PRIO_MIPS_SHIFT)
-- 
1.7.4.1
