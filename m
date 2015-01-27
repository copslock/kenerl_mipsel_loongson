Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 22:48:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41932 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011942AbbA0VqYKCHB1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 22:46:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D6ED258FA8FFF;
        Tue, 27 Jan 2015 21:46:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 27 Jan 2015 21:46:18 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 27 Jan 2015 21:46:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 7/9] MIPS: perf: Allow sharing IRQ with timer
Date:   Tue, 27 Jan 2015 21:45:53 +0000
Message-ID: <1422395155-16511-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422395155-16511-1-git-send-email-james.hogan@imgtec.com>
References: <1422395155-16511-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When requesting the performance counter overflow interrupt, pass flags
which are compatible with the cevt-r4k driver, in particular
IRQF_SHARED so that the two handlers can share the same IRQ. This is
possible since release 2 of the architecture where there are separate
pending interrupt bits for the timer interrupt and the performance
counter interrupt.

This will be necessary since the FDC interrupt can also be arbitrarily
routed to a CPU interrupt, possibly sharing with the timer, the
performance counters, or both, and it isn't scalable to have all the
handlers able to call other handlers that may be on the same IRQ line.

Shared handlers must also have a unique device pointer so they can be
individually removed, so &mipspmu is now passed in for that instead of
NULL.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/perf_event_mipsxx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 76bc3bb18c45..9d90efea8bb0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -558,8 +558,10 @@ static int mipspmu_get_irq(void)
 	if (mipspmu.irq >= 0) {
 		/* Request my own irq handler. */
 		err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
-			IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_THREAD,
-			"mips_perf_pmu", NULL);
+				  IRQF_PERCPU | IRQF_NOBALANCING |
+				  IRQF_NO_THREAD | IRQF_NO_SUSPEND |
+				  IRQF_SHARED,
+				  "mips_perf_pmu", &mipspmu);
 		if (err) {
 			pr_warn("Unable to request IRQ%d for MIPS performance counters!\n",
 				mipspmu.irq);
@@ -582,7 +584,7 @@ static int mipspmu_get_irq(void)
 static void mipspmu_free_irq(void)
 {
 	if (mipspmu.irq >= 0)
-		free_irq(mipspmu.irq, NULL);
+		free_irq(mipspmu.irq, &mipspmu);
 	else if (cp0_perfcount_irq < 0)
 		perf_irq = save_perf_irq;
 }
-- 
2.0.5
