Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:10:39 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35018 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008602AbaLLWIfKsc0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:35 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so8089136pad.10
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOMVfpk1BclZ1v0Ll0wO+pvqye6H539Z7BAGd1wbdM8=;
        b=f08w9coH01KzXrCr50qFihxgI+ljciHcOecum5RWHnArZzFDt+Lh+TM/E6uFaoN0Zy
         Pygm7z1AfjmqhHVPNNOBcwXfUYT6VjJN7gX8LiMBzbePkdlJhj4rW80MYiMgnbd0h95p
         Shhp+4VcaTnPptYlGvqhBWcySj0B3wGWLTRKnYaAPbycg+p9+rOh+0OSt0t4b6rhkusK
         VchB0gjTsCKsYAWSTvXh0MWRMRcsu7tFVxmW6+M6W4X5BfhNBoLgJKTJjil56/gLP3nT
         VDO26Es8p3dC37fs1xEB/yRN6fEX16Uoy0scuDkH/brSbgaJuf/q8teAqBXafVOjTy68
         UrLg==
X-Received: by 10.66.118.198 with SMTP id ko6mr30249078pab.19.1418422108202;
        Fri, 12 Dec 2014 14:08:28 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:27 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 08/23] irqchip: bcm7120-l2: Add support for BCM3380-style controllers
Date:   Fri, 12 Dec 2014 14:06:59 -0800
Message-Id: <1418422034-17099-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

These controllers support multiple enable/status pairs (64+ IRQs),
can put the enable/status words at different offsets, and do not
support multiple parent IRQs.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../interrupt-controller/brcm,bcm3380-l2-intc.txt  | 41 ++++++++++++++++
 drivers/irqchip/irq-bcm7120-l2.c                   | 55 ++++++++++++++++++++--
 2 files changed, 92 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
new file mode 100644
index 0000000..8f48aad
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
@@ -0,0 +1,41 @@
+Broadcom BCM3380-style Level 1 / Level 2 interrupt controller
+
+This interrupt controller shows up in various forms on many BCM338x/BCM63xx
+chipsets.  It has the following properties:
+
+- outputs a single interrupt signal to its interrupt controller parent
+
+- contains one or more enable/status word pairs, which often appear at
+  different offsets in different blocks
+
+- no atomic set/clear operations
+
+Required properties:
+
+- compatible: should be "brcm,bcm3380-l2-intc"
+- reg: specifies one or more enable/status pairs, in the following format:
+  <enable_reg 0x4 status_reg 0x4>...
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+  this one is cascaded from
+- interrupts: specifies the interrupt line in the interrupt-parent controller
+  node, valid values depend on the type of parent interrupt controller
+
+Optional properties:
+
+- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
+  wakeup source for system suspend/resume.
+
+Example:
+
+irq0_intc: interrupt-controller@10000020 {
+	compatible = "brcm,bcm3380-l2-intc";
+	reg = <0x10000024 0x4 0x1000002c 0x4>,
+	      <0x10000020 0x4 0x10000028 0x4>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	interrupt-parent = <&cpu_intc>;
+	interrupts = <2>;
+};
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 6a62858..3ba5cc7 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kconfig.h>
+#include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -120,10 +121,15 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	/* For multiple parent IRQs with multiple words, this looks like:
 	 * <irq0_w0 irq0_w1 irq1_w0 irq1_w1 ...>
 	 */
-	for (idx = 0; idx < data->n_words; idx++)
-		data->irq_map_mask[idx] |=
-			be32_to_cpup(data->map_mask_prop +
-				     irq * data->n_words + idx);
+	for (idx = 0; idx < data->n_words; idx++) {
+		if (data->map_mask_prop) {
+			data->irq_map_mask[idx] |=
+				be32_to_cpup(data->map_mask_prop +
+					     irq * data->n_words + idx);
+		} else {
+			data->irq_map_mask[idx] = 0xffffffff;
+		}
+	}
 
 	irq_set_handler_data(parent_irq, data);
 	irq_set_chained_handler(parent_irq, bcm7120_l2_intc_irq_handle);
@@ -165,6 +171,37 @@ static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
 	return 0;
 }
 
+static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
+					     struct bcm7120_l2_intc_data *data)
+{
+	unsigned int gc_idx;
+
+	for (gc_idx = 0; gc_idx < MAX_WORDS; gc_idx++) {
+		unsigned int map_idx = gc_idx * 2;
+		void __iomem *en = of_iomap(dn, map_idx + 0);
+		void __iomem *stat = of_iomap(dn, map_idx + 1);
+		void __iomem *base = min(en, stat);
+
+		data->map_base[map_idx + 0] = en;
+		data->map_base[map_idx + 1] = stat;
+
+		if (!base)
+			break;
+
+		data->pair_base[gc_idx] = base;
+		data->en_offset[gc_idx] = en - base;
+		data->stat_offset[gc_idx] = stat - base;
+	}
+
+	if (!gc_idx) {
+		pr_err("unable to map registers\n");
+		return -EINVAL;
+	}
+
+	data->n_words = gc_idx;
+	return 0;
+}
+
 int __init bcm7120_l2_intc_probe(struct device_node *dn,
 				 struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
@@ -279,5 +316,15 @@ int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
 				     "BCM7120 L2");
 }
 
+int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
+				      struct device_node *parent)
+{
+	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
+				     "BCM3380 L2");
+}
+
 IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
 		bcm7120_l2_intc_probe_7120);
+
+IRQCHIP_DECLARE(bcm3380_l2_intc, "brcm,bcm3380-l2-intc",
+		bcm7120_l2_intc_probe_3380);
-- 
2.1.1
