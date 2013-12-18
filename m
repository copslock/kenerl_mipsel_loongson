Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:16:49 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35640 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867280Ab3LRNOFhxT55 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:05 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D8C27284713;
        Wed, 18 Dec 2013 14:11:47 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 079C228A92B;
        Wed, 18 Dec 2013 14:11:46 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 12/13] MIPS: cpu-type: guard BMIPS variants with SYS_HAS_CPU_BMIPS*
Date:   Wed, 18 Dec 2013 14:12:10 +0100
Message-Id: <1387372331-23474-13-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38741
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

BMIPS32 and  BMIPS3300 also need to be available for MIPS32R1, as
bcm47xx might not select BMIPS.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/cpu-type.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 4a402cc..71d36ff 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -27,10 +27,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 #ifdef CONFIG_SYS_HAS_CPU_MIPS32_R1
 	case CPU_4KC:
 	case CPU_ALCHEMY:
-	case CPU_BMIPS3300:
-	case CPU_BMIPS4350:
 	case CPU_PR4450:
-	case CPU_BMIPS32:
 	case CPU_JZRISC:
 #endif
 
@@ -163,6 +160,16 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_CAVIUM_OCTEON2:
 #endif
 
+#if defined(CONFIG_SYS_HAS_CPU_BMIPS32_3300) || \
+	defined (CONFIG_SYS_HAS_CPU_MIPS32_R1)
+	case CPU_BMIPS32:
+	case CPU_BMIPS3300:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4350
+	case CPU_BMIPS4350:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_BMIPS4380
 	case CPU_BMIPS4380:
 #endif
-- 
1.8.5.1
