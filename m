Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:50:32 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994882AbdGCNtivYoOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:49:38 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFDA592B;
        Mon,  3 Jul 2017 13:49:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Bryan ODonoghue <bryan.odonoghue@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.11 38/84] MIPS: pm-cps: Drop manual cache-line alignment of ready_count
Date:   Mon,  3 Jul 2017 15:35:18 +0200
Message-Id: <20170703133405.391179407@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133402.874816941@linuxfoundation.org>
References: <20170703133402.874816941@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 161c51ccb7a6faf45ffe09aa5cf1ad85ccdad503 upstream.

We allocate memory for a ready_count variable per-CPU, which is accessed
via a cached non-coherent TLB mapping to perform synchronisation between
threads within the core using LL/SC instructions. In order to ensure
that the variable is contained within its own data cache line we
allocate 2 lines worth of memory & align the resulting pointer to a line
boundary. This is however unnecessary, since kmalloc is guaranteed to
return memory which is at least cache-line aligned (see
ARCH_DMA_MINALIGN). Stop the redundant manual alignment.

Besides cleaning up the code & avoiding needless work, this has the side
effect of avoiding an arithmetic error found by Bryan on 64 bit systems
due to the 32 bit size of the former dlinesz. This led the ready_count
variable to have its upper 32b cleared erroneously for MIPS64 kernels,
causing problems when ready_count was later used on MIPS64 via cpuidle.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 3179d37ee1ed ("MIPS: pm-cps: add PM state entry code for CPS systems")
Reported-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15383/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/pm-cps.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,7 +56,6 @@ DECLARE_BITMAP(state_support, CPS_PM_STA
  * state. Actually per-core rather than per-CPU.
  */
 static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
-static DEFINE_PER_CPU_ALIGNED(void*, ready_count_alloc);
 
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
@@ -642,7 +641,6 @@ static int cps_pm_online_cpu(unsigned in
 {
 	enum cps_pm_state state;
 	unsigned core = cpu_data[cpu].core;
-	unsigned dlinesz = cpu_data[cpu].dcache.linesz;
 	void *entry_fn, *core_rc;
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
@@ -662,16 +660,11 @@ static int cps_pm_online_cpu(unsigned in
 	}
 
 	if (!per_cpu(ready_count, core)) {
-		core_rc = kmalloc(dlinesz * 2, GFP_KERNEL);
+		core_rc = kmalloc(sizeof(u32), GFP_KERNEL);
 		if (!core_rc) {
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
 
