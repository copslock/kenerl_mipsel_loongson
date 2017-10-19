Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 16:22:42 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.232]:60638 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSOWfjKanJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 16:22:35 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 19 Oct 2017 14:21:40 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 19 Oct 2017 07:17:41 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     James Hogan <james.hogan@mips.com>, <linux-mips@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] clockevents: Retry programming min delta up to 10 times
Date:   Thu, 19 Oct 2017 15:17:23 +0100
Message-ID: <1508422643-6075-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <alpine.DEB.2.20.1710191527570.1971@nanos>
References: <alpine.DEB.2.20.1710191527570.1971@nanos>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508422887-452060-2487-607281-7
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186117
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
X-archive-position: 60475
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

From: James Hogan <jhogan@kernel.org>

When CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=n, the call path
hrtimer_reprogram -> clockevents_program_event ->
clockevents_program_min_delta will not retry if the clock event driver
returns -ETIME.

If the driver could not satisfy the program_min_delta for any reason,
the lack of a retry means the CPU may not receive a tick interrupt,
potentially until the counter does a full period. This leads to
rcu_sched timeout messages as the stalled CPU is detected by other CPUs,
and other issues if the CPU is holding locks or other resources at the
point at which it stalls.

There have been a couple of observed mechanisms through which a clock
event driver could not satisfy the requested min_delta and return
-ETIME.

With the MIPS GIC driver, the shared execution resource within MT cores
means inconventient latency due to execution of instructions from other
hardware threads in the core, within gic_next_event, can result in an
event being set in the past.

Additionally under virtualisation it is possible to get unexpected
latency during a clockevent device's set_next_event() callback which can
make it return -ETIME even for a delta based on min_delta_ns.

It isn't appropriate to use MIN_ADJUST in the virtualisation case as
occasional hypervisor induced high latency will cause min_delta_ns to
quickly increase to the maximum.

Instead, borrow the retry pattern from the MIN_ADJUST case, but without
making adjustments. We retry up to 10 times, each time increasing the
attempted delta by min_delta, before giving up.

Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

Changes in v2:
Restructure for loop and retry with increasing multiples of min_delta.

 kernel/time/clockevents.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 4237e0744e26..84c2e3b57428 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -281,16 +281,22 @@ static int clockevents_program_min_delta(struct clock_event_device *dev)
 {
 	unsigned long long clc;
 	int64_t delta;
+	int i;
 
-	delta = dev->min_delta_ns;
-	dev->next_event = ktime_add_ns(ktime_get(), delta);
+	delta = 0;
+	for (i = 0; i < 10; i++) {
+		delta += dev->min_delta_ns;
+		dev->next_event = ktime_add_ns(ktime_get(), delta);
 
-	if (clockevent_state_shutdown(dev))
-		return 0;
+		if (clockevent_state_shutdown(dev))
+			return 0;
 
-	dev->retries++;
-	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-	return dev->set_next_event((unsigned long) clc, dev);
+		dev->retries++;
+		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
+		if (dev->set_next_event((unsigned long) clc, dev) == 0)
+			return 0;
+	}
+	return -ETIME;
 }
 
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST */
-- 
2.7.4
