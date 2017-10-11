Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 16:03:40 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:43665 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdJKODcmx2vr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 16:03:32 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 11 Oct 2017 14:03:21 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 11 Oct 2017 07:01:47 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts from multithreading
Date:   Wed, 11 Oct 2017 15:01:12 +0100
Message-ID: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1507730595-298553-1516-37637-14
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185890
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

When the MIPS GIC clockevent code was written, it appears to have
inherited the 0x300 cycle min delta from the MIPS CPU timer driver. This
is suboptimal for two reasons.

Firstly, the CPU timer counts once every other cycle (i.e. half the
clock rate). The GIC counts once per clock. Assuming that the GIC and
CPU share the same clock this means the GIC is counting twice as fast,
and so the min delta should be (at least) doubled. Fix this by doubling
the min delta to 0x600.

Secondly, the fixed min delta ignores the fact that with MIPS
multithreading active, execution resource within a core is shared
between the hardware threads within that core. An inconvenienly timed
switch of executing thread within gic_next_event, between the read and
write of updated count, can result in the CPU writing an event in the
past, and subsequently not receiving a tick interrupt until the counter
wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
this and print rcu_sched timeout messages in  the kernel log. It can
lead to other issues as well if the CPU is holding locks or other
resources at the point at which it stalls. Fix this by scaling the min
delta for the timer based on the number of threads in the core
(smp_num_siblings). This accounts for the greater average runtime of
CPUs within a multithreading core.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: b695d8e6ad6f ("clocksource: mips-gic: Use clockevents_config_and_register")
Cc: <stable@vger.kernel.org> # v3.19 +

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 drivers/clocksource/mips-gic-timer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index ae3167c28b12..6c94a74682a2 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -72,6 +72,9 @@ struct irqaction gic_compare_irqaction = {
 static void gic_clockevent_cpu_init(unsigned int cpu,
 				    struct clock_event_device *cd)
 {
+	unsigned long max_d = 0x7fffffff;
+	unsigned long min_d = 0x600;
+
 	cd->name		= "MIPS GIC";
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_C3STOP;
@@ -81,7 +84,15 @@ static void gic_clockevent_cpu_init(unsigned int cpu,
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
 
-	clockevents_config_and_register(cd, gic_frequency, 0x300, 0x7fffffff);
+	/*
+	 * The min_delta is sensitive to the number of hardware threads in
+	 * the core. With more threads each thread will, on average, get
+	 * less instructions executed per clock. To account for this, we
+	 * scale the min delta based on the number of threads per core.
+	 */
+	min_d *= smp_num_siblings;
+
+	clockevents_config_and_register(cd, gic_frequency, min_d, max_d);
 
 	enable_percpu_irq(gic_timer_irq, IRQ_TYPE_NONE);
 }
-- 
2.7.4
