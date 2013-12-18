Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:18:32 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35673 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867285Ab3LRNOMVri6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A82E9284516;
        Wed, 18 Dec 2013 14:11:54 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9B8DD28A928;
        Wed, 18 Dec 2013 14:11:45 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 10/13] MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
Date:   Wed, 18 Dec 2013 14:12:08 +0100
Message-Id: <1387372331-23474-11-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38746
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

Let each supported chip select the appropirate SYS_HAS_CPU_BMIPS*
option for its embedded processor, so support will be conditionally
included.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig         | 1 -
 arch/mips/bcm63xx/Kconfig | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0e53a3c..50aebd1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -132,7 +132,6 @@ config BCM63XX
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_BMIPS4350 if !BCM63XX_CPU_6338 && !BCM63XX_CPU_6345 && !BCM63XX_CPU_6348
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index b78306c..a057fdf1 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -3,33 +3,41 @@ menu "CPU support"
 
 config BCM63XX_CPU_3368
 	bool "support 3368 CPU"
+	select SYS_HAS_CPU_BMIPS4350
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6328
 	bool "support 6328 CPU"
+	select SYS_HAS_CPU_BMIPS4350
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
+	select SYS_HAS_CPU_BMIPS32_3300
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6345
 	bool "support 6345 CPU"
+	select SYS_HAS_CPU_BMIPS32_3300
 
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
+	select SYS_HAS_CPU_BMIPS32_3300
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
+	select SYS_HAS_CPU_BMIPS4350
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6362
 	bool "support 6362 CPU"
+	select SYS_HAS_CPU_BMIPS4350
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6368
 	bool "support 6368 CPU"
+	select SYS_HAS_CPU_BMIPS4350
 	select HW_HAS_PCI
 endmenu
 
-- 
1.8.5.1
