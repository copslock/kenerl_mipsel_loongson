Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 13:22:09 +0100 (WEST)
Received: from arrakis.dune.hu ([195.56.146.235]:57210 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022014AbZFBMWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 13:22:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 3997323C0108
	for <linux-mips@linux-mips.org>; Tue,  2 Jun 2009 14:22:00 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fEvplN1rr5kx for <linux-mips@linux-mips.org>;
	Tue,  2 Jun 2009 14:22:00 +0200 (CEST)
Received: by arrakis.dune.hu (Postfix, from userid 1000)
	id 25FC923C013F; Tue,  2 Jun 2009 14:22:00 +0200 (CEST)
From:	Imre Kaloz <kaloz@openwrt.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Remove SiByte simulator option
Date:	Tue,  2 Jun 2009 14:22:00 +0200
Message-Id: <1243945320-4964-1-git-send-email-kaloz@openwrt.org>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <kaloz@arrakis.dune.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes the SiByte simulation Kconfig option, which only
modified a printk.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/sibyte/Kconfig       |    7 -------
 arch/mips/sibyte/swarm/setup.c |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index 366b19d..989d1a9 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -128,13 +128,6 @@ config SIBYTE_ENABLE_LDT_IF_PCI
 	bool
 	select SIBYTE_HAS_LDT if PCI
 
-config SIMULATION
-	bool "Running under simulation"
-	depends on SIBYTE_SB1xxx_SOC
-	help
-	  Build a kernel suitable for running under the GDB simulator.
-	  Primarily adjusts the kernel's notion of time.
-
 config SB1_CEX_ALWAYS_FATAL
 	bool "All cache exceptions considered fatal (no recovery attempted)"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 080c966..cffa30a 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -137,11 +137,7 @@ void __init plat_mem_setup(void)
 		swarm_rtc_type = RTC_M4LT81;
 
 	printk("This kernel optimized for "
-#ifdef CONFIG_SIMULATION
-	       "simulation"
-#else
 	       "board"
-#endif
 	       " runs "
 #ifdef CONFIG_SIBYTE_CFE
 	       "with"
-- 
1.6.0.4
