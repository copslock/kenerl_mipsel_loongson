Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 13:22:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:1033 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6837164AbaEGLVgpNG-n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 13:21:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EECACA5BB5B57
        for <linux-mips@linux-mips.org>; Wed,  7 May 2014 12:21:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 12:21:26 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 7 May 2014 12:21:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/5] MIPS: Malta: add suspend state entry code
Date:   Wed, 7 May 2014 12:20:57 +0100
Message-ID: <1399461660-17623-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
References: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40041
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

This patch introduces code which will enter a suspend state via the
PIIX4. This can only be done when PCI support is enabled since it
requires access to PCI I/O space and the generation of a special cycle
on the PCI bus. In cases where PCI is disabled the mips_pm_suspend
function will simply always return an error.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                           |  6 ++
 arch/mips/include/asm/mach-malta/malta-pm.h | 37 +++++++++++
 arch/mips/mti-malta/Makefile                |  2 +
 arch/mips/mti-malta/malta-pm.c              | 96 +++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-malta/malta-pm.h
 create mode 100644 arch/mips/mti-malta/malta-pm.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5cd695f..7d742ce 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1659,6 +1659,12 @@ config SYS_HAS_CPU_XLR
 config SYS_HAS_CPU_XLP
 	bool
 
+config MIPS_MALTA_PM
+	depends on MIPS_MALTA
+	depends on PCI
+	bool
+	default y
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/include/asm/mach-malta/malta-pm.h b/arch/mips/include/asm/mach-malta/malta-pm.h
new file mode 100644
index 0000000..21d131f
--- /dev/null
+++ b/arch/mips/include/asm/mach-malta/malta-pm.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MIPS_MACH_MALTA_PM_H__
+#define __ASM_MIPS_MACH_MALTA_PM_H__
+
+#include <asm/mips-boards/piix4.h>
+
+#ifdef CONFIG_MIPS_MALTA_PM
+
+/**
+ * mips_pm_suspend - enter a suspend state
+ * @state: the state to enter, one of PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_*
+ *
+ * Enters a suspend state via the Malta's PIIX4. If the state to be entered
+ * is one which loses context (eg. SOFF) then this function will never
+ * return.
+ */
+extern int mips_pm_suspend(unsigned state);
+
+#else /* !CONFIG_MIPS_MALTA_PM */
+
+static inline int mips_pm_suspend(unsigned state)
+{
+	return -EINVAL;
+}
+
+#endif /* !CONFIG_MIPS_MALTA_PM */
+
+#endif /* __ASM_MIPS_MACH_MALTA_PM_H__ */
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index eae0ba3..5c372c6 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -11,3 +11,5 @@ obj-y				:= malta-amon.o malta-display.o malta-init.o \
 
 # FIXME FIXME FIXME
 obj-$(CONFIG_MIPS_MT_SMTC)	+= malta-smtc.o
+
+obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
diff --git a/arch/mips/mti-malta/malta-pm.c b/arch/mips/mti-malta/malta-pm.c
new file mode 100644
index 0000000..c1e456c
--- /dev/null
+++ b/arch/mips/mti-malta/malta-pm.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+
+#include <asm/mach-malta/malta-pm.h>
+
+static struct pci_bus *pm_pci_bus;
+static resource_size_t pm_io_offset;
+
+int mips_pm_suspend(unsigned state)
+{
+	int spec_devid;
+	u16 sts;
+
+	if (!pm_pci_bus || !pm_io_offset)
+		return -ENODEV;
+
+	/* Ensure the power button status is clear */
+	while (1) {
+		sts = inw(pm_io_offset + PIIX4_FUNC3IO_PMSTS);
+		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
+			break;
+		outw(sts, pm_io_offset + PIIX4_FUNC3IO_PMSTS);
+	}
+
+	/* Enable entry to suspend */
+	outw(state | PIIX4_FUNC3IO_PMCNTRL_SUS_EN,
+	     pm_io_offset + PIIX4_FUNC3IO_PMCNTRL);
+
+	/* If the special cycle occurs too soon this doesn't work... */
+	mdelay(10);
+
+	/*
+	 * The PIIX4 will enter the suspend state only after seeing a special
+	 * cycle with the correct magic data on the PCI bus. Generate that
+	 * cycle now.
+	 */
+	spec_devid = PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
+	pci_bus_write_config_dword(pm_pci_bus, spec_devid, 0,
+				   PIIX4_SUSPEND_MAGIC);
+
+	/* Give the system some time to power down */
+	mdelay(1000);
+
+	return 0;
+}
+
+static int __init malta_pm_setup(void)
+{
+	struct pci_dev *dev;
+	int res, io_region = PCI_BRIDGE_RESOURCES;
+
+	/* Find a reference to the PCI bus */
+	pm_pci_bus = pci_find_next_bus(NULL);
+	if (!pm_pci_bus) {
+		pr_warn("malta-pm: failed to find reference to PCI bus\n");
+		return -ENODEV;
+	}
+
+	/* Find the PIIX4 PM device */
+	dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+			     PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID,
+			     PCI_ANY_ID, NULL);
+	if (!dev) {
+		pr_warn("malta-pm: failed to find PIIX4 PM\n");
+		return -ENODEV;
+	}
+
+	/* Request access to the PIIX4 PM IO registers */
+	res = pci_request_region(dev, io_region, "PIIX4 PM IO registers");
+	if (res) {
+		pr_warn("malta-pm: failed to request PM IO registers (%d)\n",
+			res);
+		pci_dev_put(dev);
+		return -ENODEV;
+	}
+
+	/* Find the offset to the PIIX4 PM IO registers */
+	pm_io_offset = pci_resource_start(dev, io_region);
+
+	pci_dev_put(dev);
+	return 0;
+}
+
+late_initcall(malta_pm_setup);
-- 
1.8.5.3
