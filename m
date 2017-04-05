Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2017 15:14:27 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:57882 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdDENOU4067K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2017 15:14:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 5C4D21831D;
        Wed,  5 Apr 2017 15:14:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Vi75xeQj15O2; Wed,  5 Apr 2017 15:14:14 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 0ADD5180B3;
        Wed,  5 Apr 2017 15:14:14 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D715C1A06F;
        Wed,  5 Apr 2017 15:14:13 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBA561A064;
        Wed,  5 Apr 2017 15:14:13 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed,  5 Apr 2017 15:14:13 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by thoth.se.axis.com (Postfix) with ESMTP id BE9F829FE;
        Wed,  5 Apr 2017 15:14:13 +0200 (CEST)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id B742620353; Wed,  5 Apr 2017 15:14:13 +0200 (CEST)
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, Rabin Vincent <rabinv@axis.com>
Subject: [PATCH] MIPS: perf: fix deadlock
Date:   Wed,  5 Apr 2017 15:14:08 +0200
Message-Id: <1491398048-20083-1-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 2.7.0
X-TM-AS-GCONF: 00
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

From: Rabin Vincent <rabinv@axis.com>

mipsxx_pmu_handle_shared_irq() calls irq_work_run() while holding the
pmuint_rwlock for read.  irq_work_run() can, via perf_pending_event(),
call try_to_wake_up() which can try to take rq->lock.

However, perf can also call perf_pmu_enable() (and thus take the
pmuint_rwlock for write) while holding the rq->lock, from
finish_task_switch() via perf_event_context_sched_in().

This leads to an ABBA deadlock:

 PID: 3855   TASK: 8f7ce288  CPU: 2   COMMAND: "process"
  #0 [89c39ac8] __delay at 803b5be4
  #1 [89c39ac8] do_raw_spin_lock at 8008fdcc
  #2 [89c39af8] try_to_wake_up at 8006e47c
  #3 [89c39b38] pollwake at 8018eab0
  #4 [89c39b68] __wake_up_common at 800879f4
  #5 [89c39b98] __wake_up at 800880e4
  #6 [89c39bc8] perf_event_wakeup at 8012109c
  #7 [89c39be8] perf_pending_event at 80121184
  #8 [89c39c08] irq_work_run_list at 801151f0
  #9 [89c39c38] irq_work_run at 80115274
 #10 [89c39c50] mipsxx_pmu_handle_shared_irq at 8002cc7c

 PID: 1481   TASK: 8eaac6a8  CPU: 3   COMMAND: "process"
  #0 [8de7f900] do_raw_write_lock at 800900e0
  #1 [8de7f918] perf_event_context_sched_in at 80122310
  #2 [8de7f938] __perf_event_task_sched_in at 80122608
  #3 [8de7f958] finish_task_switch at 8006b8a4
  #4 [8de7f998] __schedule at 805e4dc4
  #5 [8de7f9f8] schedule at 805e5558
  #6 [8de7fa10] schedule_hrtimeout_range_clock at 805e9984
  #7 [8de7fa70] poll_schedule_timeout at 8018e8f8
  #8 [8de7fa88] do_select at 8018f338
  #9 [8de7fd88] core_sys_select at 8018f5cc
 #10 [8de7fee0] sys_select at 8018f854
 #11 [8de7ff28] syscall_common at 80028fc8

The lock seems to be there to protect the hardware counters so there is
no need to hold it across irq_work_run().

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 8c35b31..9452b02 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1446,6 +1446,11 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	HANDLE_COUNTER(0)
 	}
 
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+	read_unlock(&pmuint_rwlock);
+#endif
+	resume_local_counters();
+
 	/*
 	 * Do all the work for the pending perf events. We can do this
 	 * in here because the performance counter interrupt is a regular
@@ -1454,10 +1459,6 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	if (handled == IRQ_HANDLED)
 		irq_work_run();
 
-#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
-	read_unlock(&pmuint_rwlock);
-#endif
-	resume_local_counters();
 	return handled;
 }
 
-- 
2.7.0
