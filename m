Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:20:56 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62156 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013765AbaKPATc45oZZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:32 +0100
Received: by mail-pa0-f54.google.com with SMTP id hz1so8633175pad.41
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKssXeGx+M4pQWiXvhE40b1Mo0cDv/0QSyFVTMgDKcE=;
        b=oeiMgighQEZzgUxRTRozPqo9k/cuWNJO/B57gsVfGpOQ5bGCGVi2Fox3/HKs7gmspB
         9JoZEVHq9pJO9l4jjEPHwC9HnI/Y3wXA/IPvJc8jzsm6jRxQjHpJb8B5U8TR/axTWSdI
         cDnHiYYN8V+pWoWBA3ytJDAbUIkjKUxOSzU2KdcZpvvsm7vHo5NejRy4WIPiqD9xe+5a
         F/H1ikdqvcr6HTYCauUq1XSvx5qihGVm9w50CpnQHiOcuRKvCj9adSzZaUNcSGECGrJm
         ua/su8DEPAnVRChYYpUbOL+NFOKQj1TNX7YHCoXRxH0nycrLA5WSfgsBHwfnXshbo2da
         xbhw==
X-Received: by 10.70.89.41 with SMTP id bl9mr19800445pdb.55.1416097167324;
        Sat, 15 Nov 2014 16:19:27 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:26 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/22] irqchip: bcm7120-l2: Change DT binding to allow non-contiguous IRQEN/IRQSTAT
Date:   Sat, 15 Nov 2014 16:17:29 -0800
Message-Id: <1416097066-20452-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44196
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

To date, all supported controllers have had the IRQEN register at offset
0x00 and the IRQSTAT register at 0x04.  So in DT we would typically see
something like:

    reg = <0xf0406800 0x8>;

We still want to support this format, but we also need to support cases
where IRQEN and IRQSTAT aren't adjacent.  So, we will amend the driver to
accept an alternate format that looks like this:

    reg = <0xf0406800 0x4 0xf0406804 0x4>;

i.e. if the first resource_size() == 4, assume that the first resource
points to IRQEN and that the next resource points to IRQSTAT.  If the
first resource_size() == 8, retain the current behavior.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  5 +-
 drivers/irqchip/irq-bcm7120-l2.c                   | 76 +++++++++++++++++-----
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
index bae1f21..e3b0cba 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
@@ -55,7 +55,10 @@ Required properties:
 - compatible: should be "brcm,bcm7120-l2-intc"
 - reg: specifies the base physical address and size of the registers;
   multiple pairs may be specified, with the first pair handling IRQ offsets
-  0..31 and the second pair handling 32..63
+  0..31 and the second pair handling 32..63. A register pair may be
+  specified as either <base 0x8>, where IRQEN lives at base+0x00 and
+  IRQSTAT lives at base+0x04, or <enreg 0x4 statreg 0x4>, where the
+  address of each register is listed independently.
 - interrupt-controller: identifies the node as an interrupt controller
 - #interrupt-cells: specifies the number of cells needed to encode an interrupt
   source, should be 1.
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e8441ee..576a92b 100644
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
@@ -22,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/irqdomain.h>
 #include <linux/reboot.h>
 #include <linux/bitops.h>
@@ -29,12 +31,8 @@
 
 #include "irqchip.h"
 
-/* Register offset in the L2 interrupt controller */
-#define IRQEN		0x00
-#define IRQSTAT		0x04
-
 #define MAX_WORDS	4
-#define MAX_MAPPINGS	MAX_WORDS
+#define MAX_MAPPINGS	(MAX_WORDS * 2)
 #define IRQS_PER_WORD	32
 
 struct bcm7120_l2_intc_data {
@@ -128,6 +126,61 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	return 0;
 }
 
+static int __init bcm7120_l2_intc_map_regs(struct device_node *dn,
+					   struct bcm7120_l2_intc_data *data)
+{
+	unsigned int idx, n_regs = 0, gc_idx = 0;
+	void __iomem *en_reg = NULL, *stat_reg = NULL;
+
+	for (idx = 0; n_regs < MAX_WORDS * 2; idx++) {
+		struct resource res;
+		resource_size_t sz;
+		void __iomem *map_base;
+
+		if (of_address_to_resource(dn, idx, &res))
+			break;
+		sz = resource_size(&res);
+		map_base = data->map_base[idx] = ioremap(res.start, sz);
+		if (!map_base)
+			return -EINVAL;
+
+		if (n_regs % 2 == 0) {
+			/* Accept either enable + status, or just enable:
+			 * reg = <0x10000024 0x8>;
+			 * reg = <0x10000024 0x4 0x1000002c 0x4>;
+			 */
+			en_reg = map_base;
+			if (sz == 8) {
+				stat_reg = map_base + 0x04;
+				n_regs += 2;
+			} else if (sz == 4) {
+				n_regs += 1;
+				continue;
+			} else {
+				return -EINVAL;
+			}
+		} else {
+			/* If the last register was enable, we're looking
+			 * for its corresponding status register
+			 */
+			if (sz == 4) {
+				stat_reg = map_base;
+				n_regs += 1;
+			} else {
+				return -EINVAL;
+			}
+		}
+
+		data->pair_base[gc_idx] = min(en_reg, stat_reg);
+		data->en_offset[gc_idx] = en_reg - data->pair_base[gc_idx];
+		data->stat_offset[gc_idx] = stat_reg - data->pair_base[gc_idx];
+		gc_idx++;
+	}
+
+	data->n_words = gc_idx;
+	return gc_idx ? 0 : -ENOENT;
+}
+
 int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 					struct device_node *parent)
 {
@@ -144,18 +197,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	if (!data)
 		return -ENOMEM;
 
-	for (idx = 0; idx < MAX_WORDS; idx++) {
-		data->map_base[idx] = of_iomap(dn, idx);
-		if (!data->map_base[idx])
-			break;
-
-		data->pair_base[idx] = data->map_base[idx];
-		data->en_offset[idx] = IRQEN;
-		data->stat_offset[idx] = IRQSTAT;
-
-		data->n_words = idx + 1;
-	}
-	if (!data->n_words) {
+	if (bcm7120_l2_intc_map_regs(dn, data) < 0) {
 		pr_err("failed to remap intc L2 registers\n");
 		ret = -ENOMEM;
 		goto out_unmap;
-- 
2.1.1
