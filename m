Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:17:30 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35655 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867282Ab3LRNOIyGyfI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5DF8028026E;
        Wed, 18 Dec 2013 14:11:51 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id C9A552846CB;
        Wed, 18 Dec 2013 14:11:43 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 07/13] MIPS: BMIPS: extend BMIPS3300 to include BMIPS32
Date:   Wed, 18 Dec 2013 14:12:05 +0100
Message-Id: <1387372331-23474-8-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38743
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

Codewise there is no difference between these two, so it does not make
sense to treat them differently. Also chip families having one of these
tend to have the other.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9bdf11b..fa08339 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1382,7 +1382,7 @@ config CPU_BMIPS
 	bool "Broadcom BMIPS"
 	depends on SYS_HAS_CPU_BMIPS
 	select CPU_MIPS32
-	select CPU_BMIPS3300 if SYS_HAS_CPU_BMIPS3300
+	select CPU_BMIPS32_3300 if SYS_HAS_CPU_BMIPS32_3300
 	select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4350
 	select CPU_BMIPS4380 if SYS_HAS_CPU_BMIPS4380
 	select CPU_BMIPS5000 if SYS_HAS_CPU_BMIPS5000
@@ -1394,7 +1394,7 @@ config CPU_BMIPS
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_HAS_PREFETCH
 	help
-	  Support for BMIPS3300/4350/4380 and BMIPS5000 processors.
+	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
 config CPU_XLR
 	bool "Netlogic XLR SoC"
@@ -1477,7 +1477,7 @@ config CPU_LOONGSON1
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
-config CPU_BMIPS3300
+config CPU_BMIPS32_3300
 	bool
 
 config CPU_BMIPS4350
@@ -1571,7 +1571,7 @@ config SYS_HAS_CPU_CAVIUM_OCTEON
 config SYS_HAS_CPU_BMIPS
 	bool
 
-config SYS_HAS_CPU_BMIPS3300
+config SYS_HAS_CPU_BMIPS32_3300
 	bool
 	select SYS_HAS_CPU_BMIPS
 
-- 
1.8.5.1
