Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 22:48:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26940 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011962AbbA0VqZdo2RY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 22:46:25 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4187D1AFE6591;
        Tue, 27 Jan 2015 21:46:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 27 Jan 2015 21:46:19 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 27 Jan 2015 21:46:18 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 9/9] MIPS: Allow shared IRQ for timer & perf counter
Date:   Tue, 27 Jan 2015 21:45:55 +0000
Message-ID: <1422395155-16511-10-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 45505
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

Before release 2 of the architecture there weren't separate interrupt
pending bits for the local CPU interrupts (timer & perf counter
overflow), so when they were connected to the same interrupt line the
timer handler had to call the performance counter handler before knowing
whether a timer interrupt was actually pending.

Now another CPU local interrupt, for the Fast Debug Channel (FDC), can
also be routed to an arbitrary interrupt line. It isn't scalable to keep
adding cross-calls between handlers for these cases of shared interrupt
lines, especially since the FDC could in theory share its interrupt line
with the performance counter, timer, or both.

Fortunately since release 2 of the architecture separate interrupt
pending bits do exist in the Cause register. This allows local
interrupts which share an interrupt line to have separate handlers using
IRQF_SHARED. Unfortunately they can't easily have their own irqchip as
there is no generic way to individually mask them.

Enable this sharing to happen by removing the special case for when the
perf count shares an IRQ with the timer. cp0_perfcount_irq and
cp0_compare_irq can then be set to the same value with shared interrupt
handlers registered for both of them.

Pre-R2 code should be unaffected. cp0_perfcount_irq will always be -1
and the timer handler will contnue to call into the perf counter
handler.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ad3d2031c327..9c109fd8ba99 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2006,8 +2006,6 @@ void per_cpu_trap_init(bool is_boot_cpu)
 		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
 		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
 		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
-		if (cp0_perfcount_irq == cp0_compare_irq)
-			cp0_perfcount_irq = -1;
 	} else {
 		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_compare_irq_shift = CP0_LEGACY_PERFCNT_IRQ;
-- 
2.0.5
