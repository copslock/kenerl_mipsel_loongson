Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:19:54 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44542 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824104Ab3F2USXI38en (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:23 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id BE53545FC0;
        Sat, 29 Jun 2013 20:18:12 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 05/10] MIPS: bmips: merge CPU options into one option
Date:   Sat, 29 Jun 2013 22:17:47 +0200
Message-Id: <1372537073-27370-6-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37227
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

Instead of treating each flavour as an exclusive CPU to select, make
BMIPS the only option and let SYS_HAS_CPU_BMIPS* decide for which
flavours to include support.

Run tested on BMIPS3300 and BMIPS4350, only build tested for BMIPS4380
and BMISP5000.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig |   77 +++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d45fd99..e5d3a63 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -128,6 +128,7 @@ config BCM63XX
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_BMIPS
 	select SYS_HAS_CPU_BMIPS4350 if !BCM63XX_CPU_6338 && !BCM63XX_CPU_6345 && !BCM63XX_CPU_6348
 	select NR_CPUS_DEFAULT_2
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -1397,41 +1398,21 @@ config CPU_CAVIUM_OCTEON
 	  can have up to 16 Mips64v2 cores and 8 integrated gigabit ethernets.
 	  Full details can be found at http://www.caviumnetworks.com.
 
-config CPU_BMIPS3300
-	bool "BMIPS3300"
-	depends on SYS_HAS_CPU_BMIPS3300
-	select CPU_BMIPS
-	help
-	  Broadcom BMIPS3300 processors.
-
-config CPU_BMIPS4350
-	bool "BMIPS4350"
-	depends on SYS_HAS_CPU_BMIPS4350
-	select CPU_BMIPS
-	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_HOTPLUG_CPU
-	help
-	  Broadcom BMIPS4350 ("VIPER") processors.
-
-config CPU_BMIPS4380
-	bool "BMIPS4380"
-	depends on SYS_HAS_CPU_BMIPS4380
-	select CPU_BMIPS
-	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_HOTPLUG_CPU
-	help
-	  Broadcom BMIPS4380 processors.
-
-config CPU_BMIPS5000
-	bool "BMIPS5000"
-	depends on SYS_HAS_CPU_BMIPS5000
-	select CPU_BMIPS
-	select CPU_SUPPORTS_HIGHMEM
-	select MIPS_CPU_SCACHE
-	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_HOTPLUG_CPU
+config CPU_BMIPS
+	bool "Broadcom BMIPS"
+	depends on SYS_HAS_CPU_BMIPS
+	select CPU_MIPS32
+	select CPU_BMIPS3300 if SYS_HAS_CPU_BMIPS3300
+	select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4350
+	select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4380
+	select CPU_BMIPS5000 if SYS_HAS_CPU_BMIPS5000
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select WEAK_ORDERING
 	help
-	  Broadcom BMIPS5000 processors.
+	  Support for BMIPS3300/4350/4380 and BMIPS5000 processors.
 
 config CPU_XLR
 	bool "Netlogic XLR SoC"
@@ -1512,14 +1493,25 @@ config CPU_LOONGSON1
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
-config CPU_BMIPS
+config CPU_BMIPS3300
 	bool
-	select CPU_MIPS32
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select SWAP_IO_SPACE
-	select WEAK_ORDERING
+
+config CPU_BMIPS4350
+	bool
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
+
+config CPU_BMIPS4380
+	bool
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
+
+config CPU_BMIPS5000
+	bool
+	select CPU_SUPPORTS_HIGHMEM
+	select MIPS_CPU_SCACHE
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_HOTPLUG_CPU
 
 config SYS_HAS_CPU_LOONGSON2E
 	bool
@@ -1593,6 +1585,9 @@ config SYS_HAS_CPU_SB1
 config SYS_HAS_CPU_CAVIUM_OCTEON
 	bool
 
+config SYS_HAS_CPU_BMIPS
+	bool
+
 config SYS_HAS_CPU_BMIPS3300
 	bool
 
-- 
1.7.10.4
