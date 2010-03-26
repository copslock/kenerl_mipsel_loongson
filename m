Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2010 23:03:14 +0100 (CET)
Received: from mgw2.diku.dk ([130.225.96.92]:32868 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492429Ab0CZWDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Mar 2010 23:03:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id 0E3AE19BC06;
        Fri, 26 Mar 2010 23:03:09 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15926-18; Fri, 26 Mar 2010 23:03:07 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id A3DA919BBFA;
        Fri, 26 Mar 2010 23:03:07 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id 950176DFD0B; Fri, 26 Mar 2010 22:57:01 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id 891FC200B0; Fri, 26 Mar 2010 23:03:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id 82902200AF;
        Fri, 26 Mar 2010 23:03:07 +0100 (CET)
Date:   Fri, 26 Mar 2010 23:03:07 +0100 (CET)
From:   Julia Lawall <julia@diku.dk>
To:     peterz@infradead.org, mingo@elte.hu, tglx@linutronix.de,
        oleg@redhat.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 4/7] arch/mips/kernel: Use set_cpus_allowed_ptr
Message-ID: <Pine.LNX.4.64.1003262302480.6480@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Use set_cpus_allowed_ptr rather than set_cpus_allowed.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E1,E2;
@@

- set_cpus_allowed(E1, cpumask_of_cpu(E2))
+ set_cpus_allowed_ptr(E1, cpumask_of(E2))

@@
expression E;
identifier I;
@@

- set_cpus_allowed(E, I)
+ set_cpus_allowed_ptr(E, &I)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c |    4 ++--
 arch/mips/kernel/mips-mt-fpaff.c             |    4 ++--
 arch/mips/kernel/traps.c                     |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -u -p a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -65,7 +65,7 @@ static int loongson2_cpufreq_target(stru
 		return -ENODEV;
 
 	cpus_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
 	if (cpufreq_frequency_table_target
 	    (policy, &loongson2_clockmod_table[0], target_freq, relation,
@@ -91,7 +91,7 @@ static int loongson2_cpufreq_target(stru
 	/* notifiers */
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-	set_cpus_allowed(current, cpus_allowed);
+	set_cpus_allowed_ptr(current, &cpus_allowed);
 
 	/* setting the cpu frequency */
 	clk_set_rate(cpuclk, freq);
diff -u -p a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -100,10 +100,10 @@ asmlinkage long mipsmt_sys_sched_setaffi
 	if (test_ti_thread_flag(ti, TIF_FPUBOUND) &&
 	    cpus_intersects(new_mask, mt_fpu_cpumask)) {
 		cpus_and(effective_mask, new_mask, mt_fpu_cpumask);
-		retval = set_cpus_allowed(p, effective_mask);
+		retval = set_cpus_allowed_ptr(p, &effective_mask);
 	} else {
 		clear_ti_thread_flag(ti, TIF_FPUBOUND);
-		retval = set_cpus_allowed(p, new_mask);
+		retval = set_cpus_allowed_ptr(p, &new_mask);
 	}
 
 out_unlock:
diff -u -p a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -862,7 +862,7 @@ static void mt_ase_fp_affinity(void)
 				= current->cpus_allowed;
 			cpus_and(tmask, current->cpus_allowed,
 				mt_fpu_cpumask);
-			set_cpus_allowed(current, tmask);
+			set_cpus_allowed_ptr(current, &tmask);
 			set_thread_flag(TIF_FPUBOUND);
 		}
 	}
