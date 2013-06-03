Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 17:41:21 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:40417 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827511Ab3FCPkikhuxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Jun 2013 17:40:38 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 439E428165C;
        Mon,  3 Jun 2013 17:39:19 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM63XX: select BMIPS4350 and default to 2 CPUs for supported SoCs
Date:   Mon,  3 Jun 2013 17:39:35 +0200
Message-Id: <1370273975-12373-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
References: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36663
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

All BCM63XX SoCs starting with BCM6358 have a BMIPS4350 instead of a
BMIPS3300, so select it unless support for any of the older SoCs is
selected.
All BMIPS4350 have only two CPUs, so select the appropriate default.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ade9973..dc535be 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -128,6 +128,8 @@ config BCM63XX
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_BMIPS4350 if !BCM63XX_CPU_6338 && !BCM63XX_CPU_6345 && !BCM63XX_CPU_6348
+	select NR_CPUS_DEFAULT_2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
-- 
1.7.10.4
