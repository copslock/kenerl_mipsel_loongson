Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 05:08:10 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1702 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1DADHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 05:07:50 +0200
X-TM-IMSS-Message-ID: <7512c2b800009b4b@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 7512c2b800009b4b ; Thu, 31 Mar 2011 20:07:43 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 31 Mar 2011 20:08:17 -0700
Date:   Fri, 1 Apr 2011 08:37:50 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 3/6] Cache support, TLB support, asm/module.h entry
Message-ID: <6a298284d465246ef09e1cb166494c16c1baf8ec.1301626288.git.jayachandranc@netlogicmicro.com>
References: <cover.1301626288.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1301626288.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 01 Apr 2011 03:08:17.0983 (UTC) FILETIME=[0C81A4F0:01CBF01A]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

CPU_XLR case added to mm/tlbex.c
CPU_XLR case added to mm/c-r4k.c for PINDEX attribute
Add XLR to asm/module.h

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/module.h |    2 ++
 arch/mips/mm/c-r4k.c           |    1 +
 arch/mips/mm/tlbex.c           |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index d94085a..bc01a02 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -118,6 +118,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "LOONGSON2 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
+#elif defined CONFIG_CPU_XLR
+#define MODULE_PROC_FAMILY "XLR "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 71bddf8..d9bc5d3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1006,6 +1006,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_25KF:
 	case CPU_SB1:
 	case CPU_SB1A:
+	case CPU_XLR:
 		c->dcache.flags |= MIPS_CACHE_PINDEX;
 		break;
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 79e39e0..b3bf60d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -404,6 +404,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_5KC:
 	case CPU_TX49XX:
 	case CPU_PR4450:
+	case CPU_XLR:
 		uasm_i_nop(p);
 		tlbw(p);
 		break;
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
