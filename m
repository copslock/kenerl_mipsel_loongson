Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:07:40 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44616 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013343AbcBYKHiikXam (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:07:38 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA6GtA003589;
        Thu, 25 Feb 2016 02:06:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA6Gp9003586;
        Thu, 25 Feb 2016 02:06:16 -0800
Date:   Thu, 25 Feb 2016 02:06:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-16a8083cedbe628228dbb08fc1469c70e6208619@git.kernel.org>
Cc:     jason@lakedaemon.net, tglx@linutronix.de, ralf@linux-mips.org,
        jiang.liu@linux.intel.com, lisa.parratt@imgtec.com,
        marc.zyngier@arm.com, robh@kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, qsyousef@gmail.com,
        qais.yousef@imgtec.com, linux-mips@linux-mips.org
Reply-To: mingo@kernel.org, robh@kernel.org, linux-mips@linux-mips.org,
          qais.yousef@imgtec.com, qsyousef@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jason@lakedaemon.net,
          tglx@linutronix.de, lisa.parratt@imgtec.com,
          jiang.liu@linux.intel.com, ralf@linux-mips.org,
          marc.zyngier@arm.com
In-Reply-To: <1449580830-23652-20-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-20-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/mips-gic: Add new DT property to reserve
 IPIs
Git-Commit-ID: 16a8083cedbe628228dbb08fc1469c70e6208619
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  16a8083cedbe628228dbb08fc1469c70e6208619
Gitweb:     http://git.kernel.org/tip/16a8083cedbe628228dbb08fc1469c70e6208619
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:30 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:58 +0100

irqchip/mips-gic: Add new DT property to reserve IPIs

The new property will allow to specify the range of GIC hwirqs to use for IPIs.

This is an optinal property. We preserve the previous behaviour of allocating
the last 2 * gic_vpes if it's not specified or DT is not supported.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-20-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 .../devicetree/bindings/interrupt-controller/mips-gic.txt    |  7 +++++++
 drivers/irqchip/irq-mips-gic.c                               | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
index aae4c38..1735953 100644
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
index 37831a5..94a30da 100644
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
