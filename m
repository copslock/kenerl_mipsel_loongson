Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 12:31:03 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:52398
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994541AbeJAKa0DWTYd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 12:30:26 +0200
Received: by mail-wm1-x341.google.com with SMTP id 189-v6so7902703wmw.2;
        Mon, 01 Oct 2018 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lv5fgwVngiSUCZ65IESqPJcG9y3aI8hBjWgPOfOBa3o=;
        b=WAllNThrKjrHE3iAEPkzNM6UZAHVYcLBnVNrDRjbtMLthkl0ftZ7/UxSP67oR4eLvb
         TSlsnjw5xrmVMEjhOJYpP5Ga9VNdyq5nNiM3JtS3au56l9UisEJMFnbIAJhlye0qmYDD
         otwOp0qiAUZJDsqRAFG8xBcVhkvygzcCA1AErF9Eu0DM1dmTO9nXNp7P5UIe/ETFcV0Y
         yQLp5WEhWNa0qUBfN7eRCKUaGRiJi5aAtyiJZjmY6QlwBEwx/tf3AbJuUDEiEqz6CBLB
         cwRomLgPGF0iafpnszpGt3dRB4OPuqsugbYLNFiR0UIqZLR06codfuCy3IL7eRq+0Djf
         cvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lv5fgwVngiSUCZ65IESqPJcG9y3aI8hBjWgPOfOBa3o=;
        b=WfZTj2dWj0neMcc2Pxxc22Lw7WoWnPJANlx+eYCC1aZUrbTRrIkizhtgR/0A+eQtsK
         L1u2yDeF0a8OOa9XiUxiBWUD6j36+tBqg9nHG1CfQ/klhlkRH1Gx0iWnpTEt9nWyrxBU
         a7qOcyzsUkazqdA9Jwk/T+X8q6vFGepaZwQsmGWGF+7AfqpIObGNIJQ87tY91mM/kX5f
         u4wNpAGbDvPHZDoZEadhqhvORCgq1oMeURMxCjxvhV4Db4o1fb1D4fTRmMPwwARxxeGq
         KM7ARpSv4QVhwu90ahxLBcT8FL1SpV3nk6Qb8sNVKpzvdw/i3/vtE2jIDzLa2U2IgONb
         P2Iw==
X-Gm-Message-State: ABuFfoh1O9VgCY17UrrlyS1Cw2TpQTGe7T6lIplc04QigVvp6H0mprb7
        EOXhE1W6MiTFeDtljuq6YYAUCR1FavM=
X-Google-Smtp-Source: ACcGV617gxDpdT9e+aAeQLFvWcMl+0rX0Iw9v9tF1rhgXMs3g+iSea78C/GLDyMZDNhwOJBNmKyW/Q==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr8806025wmh.61.1538389820465;
        Mon, 01 Oct 2018 03:30:20 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:19 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 3/7] irqchip/rtl8186: Add RTL8186 interrupt controller driver
Date:   Mon,  1 Oct 2018 13:29:48 +0300
Message-Id: <20181001102952.7913-4-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

The Realtek RTL8186 SoC is a MIPS based SoC
used in some home routers [1][2].

This adds a driver to handle the interrupt controller
on this SoC.

[1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
[2] https://wikidevi.com/wiki/Realtek_RTL8186

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/irqchip/Kconfig       |   5 ++
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-rtl8186.c | 107 ++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtl8186.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..83099905a871 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,4 +371,9 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
+config RTL8186_IRQ
+	bool
+	depends on MACH_RTL8186
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..2e0bb859a8f4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RTL8186_IRQ)		+= irq-rtl8186.o
diff --git a/drivers/irqchip/irq-rtl8186.c b/drivers/irqchip/irq-rtl8186.c
new file mode 100644
index 000000000000..3eb6b947d5a0
--- /dev/null
+++ b/drivers/irqchip/irq-rtl8186.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek RTL8186 SoC interrupt controller driver.
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define RTL8186_NR_IRQS 11
+
+#define GIMR 0x00
+#define GISR 0x04
+
+static struct {
+	void __iomem *base;
+	struct irq_domain *domain;
+} intc;
+
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	u32 hwirq, virq;
+	u32 gimr = readl(intc.base + GIMR);
+	u32 gisr = readl(intc.base + GISR);
+	u32 pending = gimr & gisr & ((1 << RTL8186_NR_IRQS) - 1);
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	while (pending) {
+		hwirq = fls(pending) - 1;
+		virq = irq_linear_revmap(intc.domain, hwirq);
+		do_IRQ(virq);
+		pending &= ~BIT(hwirq);
+	}
+}
+
+static void rtl8186_irq_mask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel(readl(intc.base + GIMR) & (~(BIT(irq))), intc.base + GIMR);
+}
+
+static void rtl8186_irq_unmask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel((readl(intc.base + GIMR) | (BIT(irq))), intc.base + GIMR);
+}
+
+static struct irq_chip rtl8186_irq_chip = {
+	.name = "RTL8186",
+	.irq_mask = rtl8186_irq_mask,
+	.irq_unmask = rtl8186_irq_unmask,
+};
+
+static int rtl8186_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				       irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &rtl8186_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops rtl8186_irq_ops = {
+	.map = rtl8186_intc_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init rtl8186_intc_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	intc.base = of_io_request_and_map(node, 0, of_node_full_name(node));
+
+	if (IS_ERR(intc.base))
+		panic("%pOF: unable to map resource", node);
+
+	intc.domain = irq_domain_add_linear(node, RTL8186_NR_IRQS,
+					    &rtl8186_irq_ops, NULL);
+
+	if (!intc.domain)
+		panic("%pOF: unable to create IRQ domain\n", node);
+
+	/* Start with all interrupts disabled */
+	writel(0, intc.base + GIMR);
+
+	/*
+	 * Enable all hardware interrupts in CP0 status register.
+	 * Software interrupts are disabled.
+	 */
+	set_c0_status(ST0_IM);
+	clear_c0_status(STATUSF_IP0 | STATUSF_IP1);
+	clear_c0_cause(CAUSEF_IP);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(rtl8186_intc, "realtek,rtl8186-intc", rtl8186_intc_of_init);
-- 
2.19.0
