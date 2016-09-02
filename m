Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:54:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3514 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992236AbcIBPxDaefdA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:53:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EDC448348A855;
        Fri,  2 Sep 2016 16:52:42 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:52:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Stephan Linz <linz@li-pro.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/12] MIPS: Malta: Use PIIX4 poweroff driver to power down
Date:   Fri, 2 Sep 2016 16:48:58 +0100
Message-ID: <20160902154859.24269-13-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55016
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

Remove the platform code used to power down the system, instead relying
upon the new PIIX4 poweroff driver. This reduces the amount of platform
code required for the Malta board in preparation for allowing it to be
part of a more generic kernel.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/Kconfig                           |  6 --
 arch/mips/configs/malta_defconfig           |  1 +
 arch/mips/configs/malta_kvm_defconfig       |  1 +
 arch/mips/configs/malta_kvm_guest_defconfig |  1 +
 arch/mips/configs/malta_qemu_32r6_defconfig |  1 +
 arch/mips/configs/maltaaprp_defconfig       |  1 +
 arch/mips/configs/maltasmvp_defconfig       |  1 +
 arch/mips/configs/maltasmvp_eva_defconfig   |  1 +
 arch/mips/configs/maltaup_defconfig         |  1 +
 arch/mips/configs/maltaup_xpa_defconfig     |  1 +
 arch/mips/mti-malta/Makefile                |  2 -
 arch/mips/mti-malta/malta-pm.c              | 96 -----------------------------
 arch/mips/mti-malta/malta-reset.c           | 30 ---------
 13 files changed, 9 insertions(+), 134 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-pm.c
 delete mode 100644 arch/mips/mti-malta/malta-reset.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d875a5a..40e4b5d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1948,12 +1948,6 @@ config SYS_HAS_CPU_XLR
 config SYS_HAS_CPU_XLP
 	bool
 
-config MIPS_MALTA_PM
-	depends on MIPS_MALTA
-	depends on PCI
-	bool
-	default y
-
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 58d43f3..f785767 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -319,6 +319,7 @@ CONFIG_LIBERTAS=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index c8f7e28..fe1b941 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -332,6 +332,7 @@ CONFIG_LIBERTAS=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index d2f54e5..a4ad822 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -332,6 +332,7 @@ CONFIG_LIBERTAS=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index cbf37dd..e284b3d 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -133,6 +133,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 35f6ba2..73dca90 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -133,6 +133,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 900f145..b5ae55b 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -135,6 +135,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 8e2738b..c3c059c8 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -138,6 +138,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 6dc4e30..28749b5 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -132,6 +132,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 3d0d9cb..b733833 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -327,6 +327,7 @@ CONFIG_LIBERTAS=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_PIIX4_POWEROFF=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 0407774..8bb4ab3 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -11,11 +11,9 @@ obj-y				+= malta-dtshim.o
 obj-y				+= malta-init.o
 obj-y				+= malta-int.o
 obj-y				+= malta-memory.o
-obj-y				+= malta-reset.o
 obj-y				+= malta-setup.o
 obj-y				+= malta-time.o
 
 obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
-obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
 
 CFLAGS_malta-dtshim.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/mips/mti-malta/malta-pm.c b/arch/mips/mti-malta/malta-pm.c
deleted file mode 100644
index c1e456c..0000000
--- a/arch/mips/mti-malta/malta-pm.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2014 Imagination Technologies
- * Author: Paul Burton <paul.burton@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/pci.h>
-
-#include <asm/mach-malta/malta-pm.h>
-
-static struct pci_bus *pm_pci_bus;
-static resource_size_t pm_io_offset;
-
-int mips_pm_suspend(unsigned state)
-{
-	int spec_devid;
-	u16 sts;
-
-	if (!pm_pci_bus || !pm_io_offset)
-		return -ENODEV;
-
-	/* Ensure the power button status is clear */
-	while (1) {
-		sts = inw(pm_io_offset + PIIX4_FUNC3IO_PMSTS);
-		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
-			break;
-		outw(sts, pm_io_offset + PIIX4_FUNC3IO_PMSTS);
-	}
-
-	/* Enable entry to suspend */
-	outw(state | PIIX4_FUNC3IO_PMCNTRL_SUS_EN,
-	     pm_io_offset + PIIX4_FUNC3IO_PMCNTRL);
-
-	/* If the special cycle occurs too soon this doesn't work... */
-	mdelay(10);
-
-	/*
-	 * The PIIX4 will enter the suspend state only after seeing a special
-	 * cycle with the correct magic data on the PCI bus. Generate that
-	 * cycle now.
-	 */
-	spec_devid = PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
-	pci_bus_write_config_dword(pm_pci_bus, spec_devid, 0,
-				   PIIX4_SUSPEND_MAGIC);
-
-	/* Give the system some time to power down */
-	mdelay(1000);
-
-	return 0;
-}
-
-static int __init malta_pm_setup(void)
-{
-	struct pci_dev *dev;
-	int res, io_region = PCI_BRIDGE_RESOURCES;
-
-	/* Find a reference to the PCI bus */
-	pm_pci_bus = pci_find_next_bus(NULL);
-	if (!pm_pci_bus) {
-		pr_warn("malta-pm: failed to find reference to PCI bus\n");
-		return -ENODEV;
-	}
-
-	/* Find the PIIX4 PM device */
-	dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
-			     PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID,
-			     PCI_ANY_ID, NULL);
-	if (!dev) {
-		pr_warn("malta-pm: failed to find PIIX4 PM\n");
-		return -ENODEV;
-	}
-
-	/* Request access to the PIIX4 PM IO registers */
-	res = pci_request_region(dev, io_region, "PIIX4 PM IO registers");
-	if (res) {
-		pr_warn("malta-pm: failed to request PM IO registers (%d)\n",
-			res);
-		pci_dev_put(dev);
-		return -ENODEV;
-	}
-
-	/* Find the offset to the PIIX4 PM IO registers */
-	pm_io_offset = pci_resource_start(dev, io_region);
-
-	pci_dev_put(dev);
-	return 0;
-}
-
-late_initcall(malta_pm_setup);
diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
deleted file mode 100644
index dd6f62a..0000000
--- a/arch/mips/mti-malta/malta-reset.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/io.h>
-#include <linux/pm.h>
-#include <linux/reboot.h>
-
-#include <asm/reboot.h>
-#include <asm/mach-malta/malta-pm.h>
-
-static void mips_machine_power_off(void)
-{
-	mips_pm_suspend(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF);
-
-	pr_info("Failed to power down, resetting\n");
-	machine_restart(NULL);
-}
-
-static int __init mips_reboot_setup(void)
-{
-	pm_power_off = mips_machine_power_off;
-
-	return 0;
-}
-arch_initcall(mips_reboot_setup);
-- 
2.9.3
