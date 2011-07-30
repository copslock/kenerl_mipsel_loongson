Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2011 13:03:43 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4818 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491089Ab1G3LDg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jul 2011 13:03:36 +0200
X-TM-IMSS-Message-ID: <e0bff83500026b1a@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e0bff83500026b1a ; Sat, 30 Jul 2011 04:01:59 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Sat, 30 Jul 2011 04:04:26 -0700
Date:   Sat, 30 Jul 2011 16:34:56 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] MIPS: Netlogic: Minor fixes for XLR processors
Message-ID: <20110730110449.GA30043@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 30 Jul 2011 11:04:26.0482 (UTC) FILETIME=[723AA520:01CC4EA8]
X-archive-position: 30769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22277

* Avoid unneeded cache flushes, XLR dcache is fully coherent across
  CPUs.
* add r4k_wait as the cpu_wait
* Move load address - the current value wastes space.
---
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    5 ++---
 arch/mips/kernel/cpu-probe.c                       |    1 +
 arch/mips/netlogic/Platform                        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
index 3b72827..3780743 100644
--- a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -25,13 +25,12 @@
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
 #define cpu_has_dc_aliases	0
-#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_ic_fills_f_dc	1
 #define cpu_has_dsp		0
 #define cpu_has_mipsmt		0
 #define cpu_has_userlocal	0
-#define cpu_icache_snoops_remote_store	0
+#define cpu_icache_snoops_remote_store	1
 
-#define cpu_has_nofpuex		0
 #define cpu_has_64bits		1
 
 #define cpu_has_mips32r1	1
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ebc0cd2..664bc13 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -190,6 +190,7 @@ void __init check_wait(void)
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
 	case CPU_JZRISC:
+	case CPU_XLR:
 		cpu_wait = r4k_wait;
 		break;
 
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index b648b48..502d912 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -13,4 +13,4 @@ cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
 # NETLOGIC XLR/XLS SoC, Simulator and boards
 #
 core-$(CONFIG_NLM_XLR)	      += arch/mips/netlogic/xlr/
-load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff84000000
+load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff80100000
-- 
1.7.4.1
