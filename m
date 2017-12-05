Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2017 23:58:57 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:35084 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990484AbdLEW6ozF4HU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2017 23:58:44 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 05 Dec 2017 22:57:51 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 5 Dec 2017 14:56:01 -0800
From:   James Hogan <james.hogan@mips.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>
CC:     James Hogan <jhogan@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [RFC PATCH] cpuidle/coupled: Handle broadcast enter failures
Date:   Tue, 5 Dec 2017 22:55:36 +0000
Message-ID: <20171205225536.21516-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512514664-321459-5115-12372-12
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187654
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

If the hrtimer based broadcast tick device is in use, the enabling of
broadcast ticks by cpuidle may fail when the next broadcast event is
brought forward to match the next event due on the local tick device,
This is because setting the next event may migrate the hrtimer based
broadcast tick to the current CPU, which then makes
broadcast_needs_cpu() fail.

This isn't normally a problem as cpuidle handles it by falling back to
the deepest idle state not needing broadcast ticks, however when coupled
cpuidle is used it can happen after the coupled CPUs have all agreed on
a particular idle state, resulting in only one of the CPUs falling back
to a shallower state, and an attempt to couple two completely different
idle states which may not be safe.

Therefore extend cpuidle_enter_state_coupled() to be able to handle the
enabling of broadcast ticks directly, so that a failure can be detected
at the higher level, and all coupled CPUs can be made to fall back to
the same idle state.

This takes place after the idle state has been initially agreed. Each
CPU will then attempt to enable broadcast ticks (if necessary), and upon
failure it will update the requested_state[] array before a second
coupled parallel barrier so that all coupled CPUs can recognise the
change.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
Is this an acceptable approach in principle?

Better/cleaner ideas to handle this are most welcome.

This doesn't directly address the problem that some of the time it won't
be possible to enter deeper idle states because of the hrtimer based
broadcast tick's affinity. The actual case I'm looking at is on MIPS
with cpuidle-cps, where the first core cannot (currently) go into a deep
idle state requiring broadcast ticks, so it'd be nice if the hrtimer
based broadcast tick device could just stay on core 0.
---
 drivers/cpuidle/coupled.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c | 24 ++++++++++++------------
 include/linux/cpuidle.h   |  4 ++++
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 147f38ea0fcd..bb76bb68dc29 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/tick.h>
 
 #include "cpuidle.h"
 
@@ -107,6 +108,7 @@ struct cpuidle_coupled {
 	int requested_state[NR_CPUS];
 	atomic_t ready_waiting_counts;
 	atomic_t abort_barrier;
+	atomic_t broadcast_barrier;
 	int online_count;
 	int refcnt;
 	int prevent;
@@ -480,6 +482,8 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 {
 	int entered_state = -1;
 	struct cpuidle_coupled *coupled = dev->coupled;
+	struct cpuidle_state *target_state;
+	bool broadcast;
 	int w;
 
 	if (!coupled)
@@ -600,8 +604,51 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 	/* all cpus have acked the coupled state */
 	next_state = cpuidle_coupled_get_state(dev, coupled);
 
+	target_state = &drv->states[next_state];
+	broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
+	/*
+	 * Tell the time framework to switch to a broadcast timer because our
+	 * local timer will be shut down.  If a local timer is used from another
+	 * CPU as a broadcast timer, this call may fail if it is not available.
+	 * In that case all coupled CPUs must fall back to a different idle
+	 * state.
+	 */
+	if (broadcast) {
+		if (tick_broadcast_enter()) {
+			next_state = find_deepest_state(drv, dev,
+							target_state->exit_latency,
+							CPUIDLE_FLAG_TIMER_STOP, false);
+			if (next_state < 0) {
+				default_idle_call();
+				/* FIXME goto reset? */
+				entered_state = -EBUSY;
+				goto skip;
+			}
+			broadcast = false;
+
+			/* update state */
+			coupled->requested_state[dev->cpu] = next_state;
+			/* matches smp_rmb() in cpuidle_coupled_get_state() */
+			smp_wmb();
+		}
+
+		cpuidle_coupled_parallel_barrier(dev,
+						 &coupled->broadcast_barrier);
+	}
+
+	/* all cpus have acked the coupled state */
+	next_state = cpuidle_coupled_get_state(dev, coupled);
+
 	entered_state = cpuidle_enter_state(dev, drv, next_state);
 
+	if (broadcast) {
+		if (WARN_ON_ONCE(!irqs_disabled()))
+			local_irq_disable();
+
+		tick_broadcast_exit();
+	}
+
+skip:
 	cpuidle_coupled_set_done(dev->cpu, coupled);
 
 out:
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 68a16827f45f..85357cee31ed 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -73,11 +73,9 @@ int cpuidle_play_dead(void)
 	return -ENODEV;
 }
 
-static int find_deepest_state(struct cpuidle_driver *drv,
-			      struct cpuidle_device *dev,
-			      unsigned int max_latency,
-			      unsigned int forbidden_flags,
-			      bool s2idle)
+int find_deepest_state(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       unsigned int max_latency, unsigned int forbidden_flags,
+		       bool s2idle)
 {
 	unsigned int latency_req = 0;
 	int i, ret = 0;
@@ -200,7 +198,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	 * local timer will be shut down.  If a local timer is used from another
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
-	if (broadcast && tick_broadcast_enter()) {
+	if (!cpuidle_state_is_coupled(drv, index) &&
+	    broadcast && tick_broadcast_enter()) {
 		index = find_deepest_state(drv, dev, target_state->exit_latency,
 					   CPUIDLE_FLAG_TIMER_STOP, false);
 		if (index < 0) {
@@ -228,15 +227,16 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
 
-	if (broadcast) {
-		if (WARN_ON_ONCE(!irqs_disabled()))
-			local_irq_disable();
+	if (!cpuidle_state_is_coupled(drv, index)) {
+		if (broadcast) {
+			if (WARN_ON_ONCE(!irqs_disabled()))
+				local_irq_disable();
 
-		tick_broadcast_exit();
-	}
+			tick_broadcast_exit();
+		}
 
-	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
+	}
 
 	diff = ktime_us_delta(time_end, time_start);
 	if (diff > INT_MAX)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8f7788d23b57..54856535f03d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -153,6 +153,10 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
+extern int find_deepest_state(struct cpuidle_driver *drv,
+			      struct cpuidle_device *dev,
+			      unsigned int max_latency,
+			      unsigned int forbidden_flags, bool s2idle);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 static inline struct cpuidle_device *cpuidle_get_device(void)
-- 
2.14.1
