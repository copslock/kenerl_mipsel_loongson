Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:05:57 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37276 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834926Ab3CUPDzxHvW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:55 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8L1HHwcfa97N; Thu, 21 Mar 2013 16:03:22 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3F9DA2815AD;
        Thu, 21 Mar 2013 16:03:22 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 7/7] MIPS: BCM63XX: add flash detection for BCM6362
Date:   Thu, 21 Mar 2013 16:03:20 +0100
Message-Id: <1363878200-4523-7-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

BCM6362 support booting from SPI flash and NAND.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/dev-flash.c                     |    6 ++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/bcm63xx/dev-flash.c b/arch/mips/bcm63xx/dev-flash.c
index 58371c7..588d1ec 100644
--- a/arch/mips/bcm63xx/dev-flash.c
+++ b/arch/mips/bcm63xx/dev-flash.c
@@ -77,6 +77,12 @@ static int __init bcm63xx_detect_flash_type(void)
 			return BCM63XX_FLASH_TYPE_PARALLEL;
 		else
 			return BCM63XX_FLASH_TYPE_SERIAL;
+	case BCM6362_CPU_ID:
+		val = bcm_misc_readl(MISC_STRAPBUS_6362_REG);
+		if (val & STRAPBUS_6362_BOOT_SEL_SERIAL)
+			return BCM63XX_FLASH_TYPE_SERIAL;
+		else
+			return BCM63XX_FLASH_TYPE_NAND;
 	case BCM6368_CPU_ID:
 		val = bcm_gpio_readl(GPIO_STRAPBUS_REG);
 		switch (val & STRAPBUS_6368_BOOT_SEL_MASK) {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 243bab9..3203fe4 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1372,6 +1372,7 @@
 
 #define MISC_STRAPBUS_6362_REG		0x14
 #define STRAPBUS_6362_FCVO_SHIFT	1
+#define STRAPBUS_6362_HSSPI_CLK_FAST	(1 << 13)
 #define STRAPBUS_6362_FCVO_MASK		(0x1f << STRAPBUS_6362_FCVO_SHIFT)
 #define STRAPBUS_6362_BOOT_SEL_SERIAL	(1 << 15)
 #define STRAPBUS_6362_BOOT_SEL_NAND	(0 << 15)
-- 
1.7.10.4
