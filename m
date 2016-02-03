Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:18:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006154AbcBCDSVPF470 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:18:21 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D78265536CEA4;
        Wed,  3 Feb 2016 03:18:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:18:15 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:18:14 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 08/15] irqchip: mips-gic: Provide VP ID accessor
Date:   Wed, 3 Feb 2016 03:15:28 +0000
Message-ID: <1454469335-14778-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51636
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

Provide a gic_read_local_vp_id() function to read the VCNUM field of the
GICs local VP_IDENT register. This will be used by a further patch to
check that the value reported by the GIC matches up with the kernels
calculation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c   |  8 ++++++++
 include/linux/irqchip/mips-gic.h | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 787bafc..e569c52 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -230,6 +230,14 @@ void gic_stop_count(void)
 
 #endif
 
+unsigned gic_read_local_vp_id(void)
+{
+	unsigned long ident;
+
+	ident = gic_read(GIC_REG(VPE_LOCAL, GIC_VP_IDENT));
+	return ident & GIC_VP_IDENT_VCNUM_MSK;
+}
+
 static bool gic_local_irq_is_routable(int intr)
 {
 	u32 vpe_ctl;
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index ce824db..d5d82c7 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -103,6 +103,7 @@
 #define GIC_VPE_SWINT0_MAP_OFS		0x0054
 #define GIC_VPE_SWINT1_MAP_OFS		0x0058
 #define GIC_VPE_OTHER_ADDR_OFS		0x0080
+#define GIC_VP_IDENT_OFS		0x0088
 #define GIC_VPE_WD_CONFIG0_OFS		0x0090
 #define GIC_VPE_WD_COUNT0_OFS		0x0094
 #define GIC_VPE_WD_INITIAL0_OFS		0x0098
@@ -211,6 +212,10 @@
 #define GIC_VPE_SMASK_FDC_SHF		6
 #define GIC_VPE_SMASK_FDC_MSK		(MSK(1) << GIC_VPE_SMASK_FDC_SHF)
 
+/* GIC_VP_IDENT fields */
+#define GIC_VP_IDENT_VCNUM_SHF		0
+#define GIC_VP_IDENT_VCNUM_MSK		(MSK(6) << GIC_VP_IDENT_VCNUM_SHF)
+
 /* GIC nomenclature for Core Interrupt Pins. */
 #define GIC_CPU_INT0		0 /* Core Interrupt 2 */
 #define GIC_CPU_INT1		1 /* .		      */
@@ -281,4 +286,16 @@ static inline int gic_get_usm_range(struct resource *gic_usm_res)
 
 #endif /* CONFIG_MIPS_GIC */
 
+/**
+ * gic_read_local_vp_id() - read the local VPs VCNUM
+ *
+ * Read the VCNUM of the local VP from the GIC_VP_IDENT register and
+ * return it to the caller. This ID should be used to refer to the VP
+ * via the GICs VP-other region, or when calculating an offset to a
+ * bit representing the VP in interrupt masks.
+ *
+ * Return: The VCNUM value for the local VP.
+ */
+extern unsigned gic_read_local_vp_id(void);
+
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.7.0
