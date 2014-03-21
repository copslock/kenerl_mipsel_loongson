Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 16:21:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49517 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861299AbaCUPVYmiixH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 16:21:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E5166B3A6FB3
        for <linux-mips@linux-mips.org>; Fri, 21 Mar 2014 15:21:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 21 Mar 2014 15:21:16 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 21 Mar 2014 15:21:10 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] MIPS: Malta: support powering down
Date:   Fri, 21 Mar 2014 15:20:32 +0000
Message-ID: <1395415232-42288-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com>
References: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39539
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

This patch makes the mips_machine_halt function (used as _machine_halt &
pm_power_off) actually power down the Malta via the PIIX4. It may then
be powered back up by pressing the "ON/NMI" button (S4) on the board.

Tested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-boards/piix4.h |  9 ++++
 arch/mips/mti-malta/malta-reset.c         | 71 +++++++++++++++++++++++++++++--
 arch/mips/pci/fixup-malta.c               |  6 +++
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/piix4.h b/arch/mips/include/asm/mips-boards/piix4.h
index 9cf5404..a44faf4 100644
--- a/arch/mips/include/asm/mips-boards/piix4.h
+++ b/arch/mips/include/asm/mips-boards/piix4.h
@@ -55,4 +55,13 @@
 #define PIIX4_FUNC3_PMREGMISC			0x80
 #define   PIIX4_FUNC3_PMREGMISC_EN			(1 << 0)
 
+/* Power Management IO Space */
+#define PIIX4_FUNC3IO_PMSTS			0x00
+#define   PIIX4_FUNC3IO_PMSTS_PWRBTN_STS		(1 << 8)
+#define PIIX4_FUNC3IO_PMCNTRL			0x04
+#define   PIIX4_FUNC3IO_PMCNTRL_SUS_EN			(1 << 13)
+
+/* Data for magic special PCI cycle */
+#define PIIX4_SUSPEND_MAGIC			0x00120002
+
 #endif /* __ASM_MIPS_BOARDS_PIIX4_H */
diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index d627d4b..ef04c8b 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -6,10 +6,13 @@
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
  */
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
+#include <asm/mips-boards/piix4.h>
 
 #define SOFTRES_REG	0x1f000500
 #define GORESET		0x42
@@ -24,10 +27,72 @@ static void mips_machine_restart(char *command)
 
 static void mips_machine_halt(void)
 {
-	unsigned int __iomem *softres_reg =
-		ioremap(SOFTRES_REG, sizeof(unsigned int));
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	int spec_devid, res;
+	int io_region = PCI_BRIDGE_RESOURCES;
+	resource_size_t io;
+	u16 sts;
 
-	__raw_writel(GORESET, softres_reg);
+	/* Find the PIIX4 PM device */
+	dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+			     PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID,
+			     PCI_ANY_ID, NULL);
+	if (!dev) {
+		printk("Failed to find PIIX4 PM\n");
+		goto fail;
+	}
+
+	/* Request access to the PIIX4 PM IO registers */
+	res = pci_request_region(dev, io_region, "PIIX4 PM IO registers");
+	if (res) {
+		printk("Failed to request PIIX4 PM IO registers (%d)\n", res);
+		goto fail_dev_put;
+	}
+
+	/* Find the offset to the PIIX4 PM IO registers */
+	io = pci_resource_start(dev, io_region);
+
+	/* Ensure the power button status is clear */
+	while (1) {
+		sts = inw(io + PIIX4_FUNC3IO_PMSTS);
+		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
+			break;
+		outw(sts, io + PIIX4_FUNC3IO_PMSTS);
+	}
+
+	/* Enable entry to suspend */
+	outw(PIIX4_FUNC3IO_PMCNTRL_SUS_EN, io + PIIX4_FUNC3IO_PMCNTRL);
+
+	/* If the special cycle occurs too soon this doesn't work... */
+	mdelay(10);
+
+	/* Find a reference to the PCI bus */
+	bus = pci_find_next_bus(NULL);
+	if (!bus) {
+		printk("Failed to find PCI bus\n");
+		goto fail_release_region;
+	}
+
+	/*
+	 * The PIIX4 will enter the suspend state only after seeing a special
+	 * cycle with the correct magic data on the PCI bus. Generate that
+	 * cycle now.
+	 */
+	spec_devid = PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
+	pci_bus_write_config_dword(bus, spec_devid, 0, PIIX4_SUSPEND_MAGIC);
+
+	/* Give the system some time to power down */
+	mdelay(1000);
+
+	/* If all went well this will never execute */
+fail_release_region:
+	pci_release_region(dev, io_region);
+fail_dev_put:
+	pci_dev_put(dev);
+fail:
+	printk("Failed to power down, resetting\n");
+	mips_machine_restart(NULL);
 }
 
 static int __init mips_reboot_setup(void)
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 2f9e52a..40e920c 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -68,6 +68,7 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 	u32 reg_val32;
+	u16 reg_val16;
 	/* PIIX PIRQC[A:D] irq mappings */
 	static int piixirqmap[PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX] = {
 		0,  0,	0,  3,
@@ -107,6 +108,11 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 	pci_read_config_byte(pdev, PIIX4_FUNC0_SERIRQC, &reg_val);
 	reg_val |= PIIX4_FUNC0_SERIRQC_EN | PIIX4_FUNC0_SERIRQC_CONT;
 	pci_write_config_byte(pdev, PIIX4_FUNC0_SERIRQC, reg_val);
+
+	/* Enable response to special cycles */
+	pci_read_config_word(pdev, PCI_COMMAND, &reg_val16);
+	pci_write_config_word(pdev, PCI_COMMAND,
+			      reg_val16 | PCI_COMMAND_SPECIAL);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
-- 
1.8.5.3
