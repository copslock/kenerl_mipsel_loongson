Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:47:25 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:18356 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818997Ab3JIPrUQRsnk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 17:47:20 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: GIC: Send IPIs using the GIC
Date:   Wed, 9 Oct 2013 16:47:23 +0100
Message-ID: <1381333643-17205-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_09_16_47_14
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

If GIC is present, then use it to send IPIs between the cores.
Using GIC for IPIs is simpler and is usable for multicore
systems compared to the existing way of doing IPIs where all VPEs
had to be disabled for another VPE to access the Cause register
in one of the TCs and enable all the VPEs back.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/smp-mt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 35f8d22..0fb8cef 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -113,12 +113,39 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
 	write_tc_c0_tchalt(TCHALT_H);
 }
 
+#ifdef CONFIG_IRQ_GIC
+static void mp_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	switch (action) {
+	case SMP_CALL_FUNCTION:
+		gic_send_ipi(plat_ipi_call_int_xlate(cpu));
+		break;
+
+	case SMP_RESCHEDULE_YOURSELF:
+		gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
+		break;
+	}
+
+	local_irq_restore(flags);
+}
+#endif
+
 static void vsmp_send_ipi_single(int cpu, unsigned int action)
 {
 	int i;
 	unsigned long flags;
 	int vpflags;
 
+#ifdef CONFIG_IRQ_GIC
+	if (gic_present) {
+		mp_send_ipi_single(cpu, action);
+		return;
+	}
+#endif
 	local_irq_save(flags);
 
 	vpflags = dvpe();	/* can't access the other CPU's registers whilst MVPE enabled */
-- 
1.8.3.2
