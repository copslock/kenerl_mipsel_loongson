Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:42:20 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50309 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491875Ab1IUNkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id B0C7132D5B9;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VFOLERY89UA8; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 53B0732A4D0;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <ffainelli@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/5] MIPS: bcm63xx: fix SDRAM size computation for BCM6345
Date:   Wed, 21 Sep 2011 15:39:45 +0200
Message-Id: <1316612390-6367-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11651

From: Florian Fainelli <ffainelli@freebox.fr>

Instead of hardcoding the amount of available RAM, read the number of
effective multiples of 8MB from SDRAM_MBASE_REG.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/cpu.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 7c7e4d4..7ad1b39 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -260,8 +260,10 @@ static unsigned int detect_memory_size(void)
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
-- 
1.7.4.1
