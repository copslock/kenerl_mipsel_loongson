Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 00:25:49 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38441 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994821AbdIIWY40NnVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 00:24:56 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoBI-00014M-Go; Sat, 09 Sep 2017 23:24:52 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoBG-0006zb-NF; Sat, 09 Sep 2017 23:24:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@imgtec.com>
Date:   Sat, 09 Sep 2017 22:47:15 +0100
Message-ID: <lsq.1504993635.81567599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 224/233] MIPS: pm-cps: Drop manual cache-line
 alignment of ready_count
In-Reply-To: <lsq.1504993633.197134470@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.48-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/pm-cps.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -55,7 +55,6 @@ DECLARE_BITMAP(state_support, CPS_PM_STA
  * state. Actually per-core rather than per-CPU.
  */
 static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
-static DEFINE_PER_CPU_ALIGNED(void*, ready_count_alloc);
 
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
@@ -616,7 +615,6 @@ static int __init cps_gen_core_entries(u
 {
 	enum cps_pm_state state;
 	unsigned core = cpu_data[cpu].core;
-	unsigned dlinesz = cpu_data[cpu].dcache.linesz;
 	void *entry_fn, *core_rc;
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
@@ -636,16 +634,11 @@ static int __init cps_gen_core_entries(u
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
 
