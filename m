Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:15:04 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35616 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867269Ab3LRNODZ1tFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A52E628A929;
        Wed, 18 Dec 2013 14:11:45 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9A84A28A921;
        Wed, 18 Dec 2013 14:11:41 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 04/13] MIPS: BMIPS: merge CPU options into one option
Date:   Wed, 18 Dec 2013 14:12:02 +0100
Message-Id: <1387372331-23474-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38736
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
and BMIPS5000.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
V1 -> V2:
 * Let the SYS_HAS_CPU_BMIPS* symbols select SYS_HAS_CPU_BMIPS instead of
   requiring users to select it

 arch/mips/Kconfig | 80 +++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..1145405 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1378,41 +1378,21 @@ config CPU_CAVIUM_OCTEON
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
+	select CPU_BMIPS4380 if SYS_HAS_CPU_BMIPS4380
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
@@ -1495,14 +1475,25 @@ config CPU_LOONGSON1
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
@@ -1576,17 +1567,24 @@ config SYS_HAS_CPU_SB1
 config SYS_HAS_CPU_CAVIUM_OCTEON
 	bool
 
+config SYS_HAS_CPU_BMIPS
+	bool
+
 config SYS_HAS_CPU_BMIPS3300
 	bool
+	select SYS_HAS_CPU_BMIPS
 
 config SYS_HAS_CPU_BMIPS4350
 	bool
+	select SYS_HAS_CPU_BMIPS
 
 config SYS_HAS_CPU_BMIPS4380
 	bool
+	select SYS_HAS_CPU_BMIPS
 
 config SYS_HAS_CPU_BMIPS5000
 	bool
+	select SYS_HAS_CPU_BMIPS
 
 config SYS_HAS_CPU_XLR
 	bool
-- 
1.8.5.1
