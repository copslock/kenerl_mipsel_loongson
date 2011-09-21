Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:41:54 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50288 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491873Ab1IUNke (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9015632D68C;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3vEeSIprhaw8; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 5C36632D617;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <ffainelli@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/5] MIPS: bcm63xx: define MPI_BASE for BCM6345
Date:   Wed, 21 Sep 2011 15:39:47 +0200
Message-Id: <1316612390-6367-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11653

From: Florian Fainelli <ffainelli@freebox.fr>

We are going to use this register to remove some BCM6345 specific hacks.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 96a2391..9fe3b7c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -163,7 +163,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_ENET0_BASE		(0xfffe1800)
 #define BCM_6345_ENETDMA_BASE		(0xfffe2800)
 #define BCM_6345_PCMCIA_BASE		(0xfffe2028)
-#define BCM_6345_MPI_BASE		(0xdeadbeef)
+#define BCM_6345_MPI_BASE		(0xfffe2000)
 #define BCM_6345_OHCI0_BASE		(0xfffe2100)
 #define BCM_6345_OHCI_PRIV_BASE		(0xfffe2200)
 #define BCM_6345_USBH_PRIV_BASE		(0xdeadbeef)
-- 
1.7.4.1
