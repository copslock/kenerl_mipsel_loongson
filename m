Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:29:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17897 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994841AbdIGX1yawhkk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:27:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3DDAEEFCE7677;
        Fri,  8 Sep 2017 00:27:42 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:27:47
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 6/9] MIPS: perf: percpu_devid interrupt support
Date:   Thu, 7 Sep 2017 16:25:39 -0700
Message-ID: <20170907232542.20589-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170907232542.20589-1-paul.burton@imgtec.com>
References: <1682867.tATABVWsV9@np-p-burton>
 <20170907232542.20589-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59960
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

The MIPS CPU performance counter overflow interrupt is really a percpu
interrupt, but up until now we have not used the percpu interrupt APIs
to configure & control it. In preparation for doing so, introduce
support for percpu_devid interrupts in the MIPS perf implementation.

We switch from using request_irq() to using either setup_irq() or
setup_percpu_irq() with an explicit struct irqaction such that we can
set the flags, handler & name for that struct irqaction once rather than
needing to duplicate them in calls to request_irq() and
request_percpu_irq().

The IRQF_NOAUTOEN flag is passed because percpu interrupts
automatically get IRQ_NOAUTOEN set by irq_set_percpu_devid_flags(). We
opt into accepting this behaviour & explicitly enable the interrupt in
mipspmu_enable() right after configuring the local performance counters.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/perf_event_mipsxx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index cae36ca400e9..af7bae79dc51 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -514,6 +514,11 @@ static void mipspmu_enable(struct pmu *pmu)
 	write_unlock(&pmuint_rwlock);
 #endif
 	resume_local_counters();
+
+	if (irq_is_percpu_devid(mipspmu.irq))
+		enable_percpu_irq(mipspmu.irq, IRQ_TYPE_NONE);
+	else
+		enable_irq(mipspmu.irq);
 }
 
 /*
@@ -538,24 +543,27 @@ static void mipspmu_disable(struct pmu *pmu)
 static atomic_t active_events = ATOMIC_INIT(0);
 static DEFINE_MUTEX(pmu_reserve_mutex);
 
+static struct irqaction c0_perf_irqaction = {
+	.handler = mipsxx_pmu_handle_irq,
+	.flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED | IRQF_NOAUTOEN,
+	.name = "mips_perf_pmu",
+	.percpu_dev_id = &mipspmu,
+};
+
 static int mipspmu_get_irq(void)
 {
-	int err;
+	if (irq_is_percpu_devid(mipspmu.irq))
+		return setup_percpu_irq(mipspmu.irq, &c0_perf_irqaction);
 
-	err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
-			  IRQF_PERCPU | IRQF_NOBALANCING |
-			  IRQF_NO_THREAD | IRQF_NO_SUSPEND |
-			  IRQF_SHARED,
-			  "mips_perf_pmu", &mipspmu);
-	if (err)
-		pr_warn("Unable to request IRQ%d for MIPS performance counters!\n",
-			mipspmu.irq);
-	return err;
+	return setup_irq(mipspmu.irq, &c0_perf_irqaction);
 }
 
 static void mipspmu_free_irq(void)
 {
-	free_irq(mipspmu.irq, &mipspmu);
+	if (irq_is_percpu_devid(mipspmu.irq))
+		remove_percpu_irq(mipspmu.irq, &c0_perf_irqaction);
+	else
+		remove_irq(mipspmu.irq, &c0_perf_irqaction);
 }
 
 /*
-- 
2.14.1
