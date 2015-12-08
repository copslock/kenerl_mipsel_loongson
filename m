Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:27:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63008 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013397AbbLHNVyeotOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id CF2AFB5B27A34;
        Tue,  8 Dec 2015 13:18:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:46 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:45 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 19/19] irqchip/mips-gic: Add new DT property to reserve IPIs
Date:   Tue, 8 Dec 2015 13:20:30 +0000
Message-ID: <1449580830-23652-20-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

The new property will allow to specify the range of GIC hwirqs to use for IPIs.

This is an optinal property. We preserve the previous behaviour of allocating
the last 2 * gic_vpes if it's not specified or DT is not supported.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/mips-gic.txt    |  7 +++++++
 drivers/irqchip/irq-mips-gic.c                               | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
index aae4c384ee1f..173595305e26 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
@@ -23,6 +23,12 @@ Optional properties:
 - mti,reserved-cpu-vectors : Specifies the list of CPU interrupt vectors
   to which the GIC may not route interrupts.  Valid values are 2 - 7.
   This property is ignored if the CPU is started in EIC mode.
+- mti,reserved-ipi-vectors : Specifies the range of GIC interrupts that are
+  reserved for IPIs.
+  It accepts 2 values, the 1st is the starting interrupt and the 2nd is the size
+  of the reserved range.
+  If not specified, the driver will allocate the last 2 * number of VPEs in the
+  system.
 
 Required properties for timer sub-node:
 - compatible : Should be "mti,gic-timer".
@@ -44,6 +50,7 @@ Example:
 		#interrupt-cells = <3>;
 
 		mti,reserved-cpu-vectors = <7>;
+		mti,reserved-ipi-vectors = <40 8>;
 
 		timer {
 			compatible = "mti,gic-timer";
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 8c86d9361a6f..d9535a308788 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -957,6 +957,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 			      struct device_node *node)
 {
 	unsigned int gicconfig;
+	unsigned int v[2];
 
 	__gic_base_addr = gic_base_addr;
 
@@ -1027,8 +1028,15 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
 
-	/* Make the last 2 * gic_vpes available for IPIs */
-	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
+	if (node &&
+	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
+		bitmap_set(ipi_resrv, v[0], v[1]);
+	} else {
+		/* Make the last 2 * gic_vpes available for IPIs */
+		bitmap_set(ipi_resrv,
+			   gic_shared_intrs - 2 * gic_vpes,
+			   2 * gic_vpes);
+	}
 
 	gic_basic_init();
 }
-- 
2.1.0
