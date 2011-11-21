Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 17:08:53 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40687 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903786Ab1KUQH6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 17:07:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 916883B2E48;
        Mon, 21 Nov 2011 17:07:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zVDOSYPb8l3y; Mon, 21 Nov 2011 17:07:58 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 314233AA54A;
        Mon, 21 Nov 2011 17:07:58 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/8 v2] MIPS: BCM63XX: define BCM6358 SPI base address
Date:   Mon, 21 Nov 2011 17:07:17 +0100
Message-Id: <1321891643-4119-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321891643-4119-1-git-send-email-florian@openwrt.org>
References: <1321891643-4119-1-git-send-email-florian@openwrt.org>
X-archive-position: 31884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17458

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 9975727..016dc9e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -289,7 +289,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_UART0_BASE		(0xfffe0100)
 #define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
-#define BCM_6358_SPI_BASE		(0xdeadbeef)
+#define BCM_6358_SPI_BASE		(0xfffe0800)
 #define BCM_6358_SPI2_BASE		(0xfffe0800)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
-- 
1.7.5.4
