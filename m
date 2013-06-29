Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:20:13 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44545 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825716Ab3F2USXyiepq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:23 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 9FF69402E2;
        Sat, 29 Jun 2013 20:18:13 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 06/10] MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
Date:   Sat, 29 Jun 2013 22:17:48 +0200
Message-Id: <1372537073-27370-7-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37228
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

fix bmips selection
---
 arch/mips/Kconfig         |    1 -
 arch/mips/bcm63xx/Kconfig |    8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e5d3a63..2d3788b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -129,7 +129,6 @@ config BCM63XX
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_BMIPS
-	select SYS_HAS_CPU_BMIPS4350 if !BCM63XX_CPU_6338 && !BCM63XX_CPU_6345 && !BCM63XX_CPU_6348
 	select NR_CPUS_DEFAULT_2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index b78306c..6cc0fac 100644
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
+	select SYS_HAS_CPU_BMIPS3300
 	select HW_HAS_PCI
 
 config BCM63XX_CPU_6345
 	bool "support 6345 CPU"
+	select SYS_HAS_CPU_BMIPS3300
 
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
+	select SYS_HAS_CPU_BMIPS3300
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
1.7.10.4
