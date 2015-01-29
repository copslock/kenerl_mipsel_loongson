Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 12:15:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62687 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012165AbbA2LOhlcAw6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 12:14:37 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E142899142B7;
        Thu, 29 Jan 2015 11:14:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 11:14:31 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 29 Jan 2015 11:14:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/9] MIPS: Read CPU IRQ line that FDC to routed to
Date:   Thu, 29 Jan 2015 11:14:07 +0000
Message-ID: <1422530054-7976-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45525
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

Read the CPU IRQ line reportedly used for the Fast Debug Channel (FDC)
interrupt from the IntCtl register and store it in cp0_fdc_irq where
platform implementations of the new weak platform function
get_c0_fdc_int() can refer to it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/irq.h |  3 +++
 arch/mips/kernel/traps.c    | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 5a4e1bb8fb1b..f0db99f8defe 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -47,6 +47,9 @@ extern void free_irqno(unsigned int irq);
 extern int cp0_compare_irq;
 extern int cp0_compare_irq_shift;
 extern int cp0_perfcount_irq;
+extern int cp0_fdc_irq;
+
+extern int __weak get_c0_fdc_int(void);
 
 void arch_trigger_all_cpu_backtrace(bool);
 #define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9c109fd8ba99..290da81c0532 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1920,6 +1920,12 @@ int cp0_compare_irq_shift;
 int cp0_perfcount_irq;
 EXPORT_SYMBOL_GPL(cp0_perfcount_irq);
 
+/*
+ * Fast debug channel IRQ or -1 if not present
+ */
+int cp0_fdc_irq;
+EXPORT_SYMBOL_GPL(cp0_fdc_irq);
+
 static int noulri;
 
 static int __init ulri_disable(char *s)
@@ -2001,15 +2007,20 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	 *
 	 *  o read IntCtl.IPTI to determine the timer interrupt
 	 *  o read IntCtl.IPPCI to determine the performance counter interrupt
+	 *  o read IntCtl.IPFDC to determine the fast debug channel interrupt
 	 */
 	if (cpu_has_mips_r2) {
 		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
 		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
 		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
+		cp0_fdc_irq = (read_c0_intctl() >> INTCTLB_IPFDC) & 7;
+		if (!cp0_fdc_irq)
+			cp0_fdc_irq = -1;
 	} else {
 		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_compare_irq_shift = CP0_LEGACY_PERFCNT_IRQ;
 		cp0_perfcount_irq = -1;
+		cp0_fdc_irq = -1;
 	}
 
 	if (!cpu_data[cpu].asid_cache)
-- 
2.0.5
