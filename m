Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 19:33:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48668 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993876AbdCBSdAxTOpx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 19:33:00 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 36ECA3CC7D34D;
        Thu,  2 Mar 2017 18:32:51 +0000 (GMT)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 2 Mar 2017 18:32:53
 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Bryan O'Donoghue <bryan.odonoghue@imgtec.com>,
        <ralf@linux-mips.org>, "stable # v3 . 16+" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: pm-cps: Drop manual cache-line alignment of ready_count
Date:   Thu, 2 Mar 2017 10:31:28 -0800
Message-ID: <20170302183128.22883-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We allocate memory for a ready_count variable per-CPU, which is accessed
via a cached non-coherent TLB mapping to perform synchronisation between
threads within the core using LL/SC instructions. In order to ensure
that the variable is contained within its own data cache line we
allocate 2 lines worth of memory & align the resulting pointer to a line
boundary. This is however unnecessary, since kmalloc is guaranteed to
return memory which is at least cache-line aligned (see
ARCH_DMA_MINALIGN). Stop the redundant manual alignment.

Besides cleaning up the code & avoiding needless work, this has the side
effect of avoiding an arithmetic error found by Brian on 64 bit systems
due to the 32 bit size of the former dlinesz. This led the ready_count
variable to have its upper 32b cleared erroneously for MIPS64 kernels,
causing problems when ready_count was later used on MIPS64 via cpuidle.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 3179d37ee1ed ("MIPS: pm-cps: add PM state entry code for CPS systems")
Reported-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v3.16+
---
 arch/mips/kernel/pm-cps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 5f928c34c148..d540b9e68e3d 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,7 +56,6 @@ DECLARE_BITMAP(state_support, CPS_PM_STATE_COUNT);
  * state. Actually per-core rather than per-CPU.
  */
 static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
-static DEFINE_PER_CPU_ALIGNED(void*, ready_count_alloc);
 
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
@@ -642,7 +641,6 @@ static int cps_pm_online_cpu(unsigned int cpu)
 {
 	enum cps_pm_state state;
 	unsigned core = cpu_data[cpu].core;
-	unsigned dlinesz = cpu_data[cpu].dcache.linesz;
 	void *entry_fn, *core_rc;
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
@@ -667,11 +665,6 @@ static int cps_pm_online_cpu(unsigned int cpu)
 			pr_err("Failed allocate core %u ready_count\n", core);
 			return -ENOMEM;
 		}
-		per_cpu(ready_count_alloc, core) = core_rc;
-
-		/* Ensure ready_count is aligned to a cacheline boundary */
-		core_rc += dlinesz - 1;
-		core_rc = (void *)((unsigned long)core_rc & ~(dlinesz - 1));
 		per_cpu(ready_count, core) = core_rc;
 	}
 
-- 
2.12.0
