Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 13:13:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25275 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012895AbbKYMIamJQJf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 13:08:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 1D157DE386A65;
        Wed, 25 Nov 2015 12:08:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 25 Nov 2015 12:08:24 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 25 Nov 2015 12:08:24 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 19/19] irqchip/mips-gic: Add new DT property to reserve IPIs
Date:   Wed, 25 Nov 2015 12:06:57 +0000
Message-ID: <1448453217-3874-20-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50104
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
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org

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
index c7043a15253b..659fe734d1b7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -945,6 +945,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 			      struct device_node *node)
 {
 	unsigned int gicconfig;
+	unsigned int v[2];
 
 	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
 
@@ -1013,8 +1014,15 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
 
-	/* Make the last 2 * NR_CPUS available for IPIs */
-	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
+	if (node &&
+	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", &v, 2)) {
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
