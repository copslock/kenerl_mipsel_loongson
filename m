Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 22:46:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42367 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011567AbbA0VqUTkfrb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 22:46:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DF865DE05D0AE;
        Tue, 27 Jan 2015 21:46:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 27 Jan 2015 21:46:14 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 27 Jan 2015 21:46:12 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/9] MIPS: cevt-r4k: Move handle_perf_irq() out of header
Date:   Tue, 27 Jan 2015 21:45:47 +0000
Message-ID: <1422395155-16511-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 45497
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

Long ago, commit 8531a35e5e27 ("[MIPS] SMTC: Fix SMTC dyntick support.")
moved handle_perf_irq() out of cevt-r4k.c into a header so it could be
shared with cevt-smtc.c.

Slightly less long ago, commit b633648c5ad3 ("MIPS: MT: Remove SMTC
support") removed all traces of SMTC support, including cevt-smtc.c,
leaving cevt-r4k.c once again the sole user of handle_perf_irq(),
therefore move it back into cevt-r4k.c from the header.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cevt-r4k.h | 19 -------------------
 arch/mips/kernel/cevt-r4k.c      | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/cevt-r4k.h b/arch/mips/include/asm/cevt-r4k.h
index 65f9bdd02f1f..f0edf6fcd002 100644
--- a/arch/mips/include/asm/cevt-r4k.h
+++ b/arch/mips/include/asm/cevt-r4k.h
@@ -27,23 +27,4 @@ irqreturn_t c0_compare_interrupt(int, void *);
 extern struct irqaction c0_compare_irqaction;
 extern int cp0_timer_irq_installed;
 
-/*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
- */
-
-static inline int handle_perf_irq(int r2)
-{
-	/*
-	 * The performance counter overflow interrupt may be shared with the
-	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
-	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
-	 * and we can't reliably determine if a counter interrupt has also
-	 * happened (!r2) then don't check for a timer interrupt.
-	 */
-	return (cp0_perfcount_irq < 0) &&
-		perf_irq() == IRQ_HANDLED &&
-		!r2;
-}
-
 #endif /* __ASM_CEVT_R4K_H */
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 6acaad0480af..02dd77955a6f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -38,6 +38,24 @@ void mips_set_clock_mode(enum clock_event_mode mode,
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
+/*
+ * Possibly handle a performance counter interrupt.
+ * Return true if the timer interrupt should not be checked
+ */
+static inline int handle_perf_irq(int r2)
+{
+	/*
+	 * The performance counter overflow interrupt may be shared with the
+	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
+	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
+	 * and we can't reliably determine if a counter interrupt has also
+	 * happened (!r2) then don't check for a timer interrupt.
+	 */
+	return (cp0_perfcount_irq < 0) &&
+		perf_irq() == IRQ_HANDLED &&
+		!r2;
+}
+
 irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
 	const int r2 = cpu_has_mips_r2;
-- 
2.0.5
