Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 10:10:41 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4871 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491815Ab1HWIJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2011 10:09:20 +0200
X-TM-IMSS-Message-ID: <5bb8b0a90000ab75@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5bb8b0a90000ab75 ; Tue, 23 Aug 2011 01:07:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Aug 2011 01:02:32 -0700
Date:   Tue, 23 Aug 2011 13:35:51 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 3/4] MIPS: Netlogic: Avoid unnecessary cache flushes
Message-ID: <fcf3b8eaab1c97f9314bf676024b8c954a4290cf.1314086142.git.jayachandranc@netlogicmicro.com>
References: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Aug 2011 08:02:32.0700 (UTC) FILETIME=[0305ABC0:01CC616B]
X-archive-position: 30952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16622

XLR dcache is fully coherent across CPUs, so avoid unnecessary
dcache flushes.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

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
-- 
1.7.4.1
