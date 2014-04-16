Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:56:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:54927 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837156AbaDPMzgzvyJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:55:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2A398694FA6D0
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:55:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:55:29 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:55:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/39] MIPS: allow GIC clockevent device config from other CPUs
Date:   Wed, 16 Apr 2014 13:52:58 +0100
Message-ID: <1397652810-4336-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39814
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

This patch allows the GIC clockevent device for a CPU to be configured
by another CPU. This makes GIC clockevent devices suitable for use as
the tick broadcast device, where formerly the GIC timer local to the
configuring CPU would have been configured incorrectly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/gic.h |  1 +
 arch/mips/kernel/cevt-gic.c |  2 +-
 arch/mips/kernel/irq-gic.c  | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 0827166..10f6a99 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -380,6 +380,7 @@ extern unsigned int gic_compare_int (void);
 extern cycle_t gic_read_count(void);
 extern cycle_t gic_read_compare(void);
 extern void gic_write_compare(cycle_t cnt);
+extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
index 925bae5..6093716 100644
--- a/arch/mips/kernel/cevt-gic.c
+++ b/arch/mips/kernel/cevt-gic.c
@@ -26,7 +26,7 @@ static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 
 	cnt = gic_read_count();
 	cnt += (u64)delta;
-	gic_write_compare(cnt);
+	gic_write_cpu_compare(cnt, cpumask_first(evt->cpumask));
 	res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
 	return res;
 }
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 8520dad..88e4c32 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -54,6 +54,21 @@ void gic_write_compare(cycle_t cnt)
 				(int)(cnt & 0xffffffff));
 }
 
+void gic_write_cpu_compare(cycle_t cnt, int cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), cpu);
+	GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_HI),
+				(int)(cnt >> 32));
+	GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_LO),
+				(int)(cnt & 0xffffffff));
+
+	local_irq_restore(flags);
+}
+
 cycle_t gic_read_compare(void)
 {
 	unsigned int hi, lo;
-- 
1.8.5.3
