Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:21:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18619 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861303AbaGQIVgae6Yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:21:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E8A281D3A245F
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:26 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 09:21:28 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:28 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:28 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/7] MIPS: GIC: move GIC interrupt bitmap declarations
Date:   Thu, 17 Jul 2014 09:20:53 +0100
Message-ID: <1405585259-24941-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41258
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

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

Several bitmaps are declared in arch/mips/include/asm/gic.h, but the
scope of their use is limited to arch/mips/kernel/irq-gic.c. Move the
declarations from the header file to the C file.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/gic.h | 12 ------------
 arch/mips/kernel/irq-gic.c  | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 10f6a99f92c2..5b0e6a4b2c30 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -306,18 +306,6 @@
 	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe)), \
 		 GIC_SH_MAP_TO_VPE_REG_BIT(vpe))
 
-struct gic_pcpu_mask {
-	DECLARE_BITMAP(pcpu_mask, GIC_NUM_INTRS);
-};
-
-struct gic_pending_regs {
-	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
-};
-
-struct gic_intrmask_regs {
-	DECLARE_BITMAP(intrmask, GIC_NUM_INTRS);
-};
-
 /*
  * Interrupt Meta-data specification. The ipiflag helps
  * in building ipi_map.
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 88e4c323382c..a1dea3ea59a0 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -28,6 +28,18 @@ unsigned int gic_irq_flags[GIC_NUM_INTRS];
 /* The index into this array is the vector # of the interrupt. */
 struct gic_shared_intr_map gic_shared_intr_map[GIC_NUM_INTRS];
 
+struct gic_pcpu_mask {
+	DECLARE_BITMAP(pcpu_mask, GIC_NUM_INTRS);
+};
+
+struct gic_pending_regs {
+	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
+};
+
+struct gic_intrmask_regs {
+	DECLARE_BITMAP(intrmask, GIC_NUM_INTRS);
+};
+
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
-- 
2.0.0
