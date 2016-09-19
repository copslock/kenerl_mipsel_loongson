Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 23:27:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57580 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993045AbcISVZNEgurb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 23:25:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3E8D730E84671;
        Mon, 19 Sep 2016 22:24:52 +0100 (IST)
Received: from localhost (10.100.200.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Sep
 2016 22:24:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Chris Brand <chris.brand@broadcom.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2 13/14] power: reset: Add Intel PIIX4 poweroff driver
Date:   Mon, 19 Sep 2016 22:21:30 +0100
Message-ID: <20160919212132.28893-14-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160919212132.28893-1-paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.110]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55186
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

Add a driver which allows powering off the system via an Intel PIIX4
southbridge, by entering the PIIX4 SOff state. This is useful on the
MIPS Malta development board, where it will power down the FPGA based
board until its ON/NMI button is pressed, or the QEMU implementation of
the MIPS Malta board where it will cause QEMU to exit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Add MODULE_LICENSE
- Allow non-MIPS builds with COMPILE_TEST

 drivers/power/reset/Kconfig          |  10 ++++
 drivers/power/reset/Makefile         |   1 +
 drivers/power/reset/piix4-poweroff.c | 104 +++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/power/reset/piix4-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c74c3f6..abeb772 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -104,6 +104,16 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
 
+config POWER_RESET_PIIX4_POWEROFF
+	tristate "Intel PIIX4 power-off driver"
+	depends on PCI
+	depends on MIPS || COMPILE_TEST
+	help
+	  This driver supports powering off a system using the Intel PIIX4
+	  southbridge, for example the MIPS Malta development board. The
+	  southbridge SOff state is entered in response to a request to
+	  power off the system.
+
 config POWER_RESET_LTC2952
 	bool "LTC2952 PowerPath power-off driver"
 	depends on OF_GPIO
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 1be307c..11dae3b 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
new file mode 100644
index 0000000..11f0999
--- /dev/null
+++ b/drivers/power/reset/piix4-poweroff.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm.h>
+
+static struct pci_dev *pm_dev;
+static resource_size_t io_offset;
+
+enum piix4_pm_io_reg {
+	PIIX4_FUNC3IO_PMSTS			= 0x00,
+#define PIIX4_FUNC3IO_PMSTS_PWRBTN_STS		BIT(8)
+	PIIX4_FUNC3IO_PMCNTRL			= 0x04,
+#define PIIX4_FUNC3IO_PMCNTRL_SUS_EN		BIT(13)
+#define PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF	(0x0 << 10)
+};
+
+#define PIIX4_SUSPEND_MAGIC			0x00120002
+
+static void piix4_poweroff(void)
+{
+	int spec_devid;
+	u16 sts;
+
+	/* Ensure the power button status is clear */
+	while (1) {
+		sts = inw(io_offset + PIIX4_FUNC3IO_PMSTS);
+		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
+			break;
+		outw(sts, io_offset + PIIX4_FUNC3IO_PMSTS);
+	}
+
+	/* Enable entry to suspend */
+	outw(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF | PIIX4_FUNC3IO_PMCNTRL_SUS_EN,
+	     io_offset + PIIX4_FUNC3IO_PMCNTRL);
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
+	pci_bus_write_config_dword(pm_dev->bus, spec_devid, 0,
+				   PIIX4_SUSPEND_MAGIC);
+
+	/* Give the system some time to power down, then error */
+	mdelay(1000);
+	pr_emerg("Unable to poweroff system\n");
+}
+
+static int piix4_poweroff_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	int res, io_region = PCI_BRIDGE_RESOURCES;
+
+	/* Request access to the PIIX4 PM IO registers */
+	res = pci_request_region(dev, io_region, "PIIX4 PM IO registers");
+	if (res) {
+		dev_err(&dev->dev, "failed to request PM IO registers: %d\n",
+			res);
+		return res;
+	}
+
+	pm_dev = dev;
+	io_offset = pci_resource_start(dev, io_region);
+	pm_power_off = piix4_poweroff;
+
+	return 0;
+}
+
+static void piix4_poweroff_remove(struct pci_dev *dev)
+{
+	if (pm_power_off == piix4_poweroff)
+		pm_power_off = NULL;
+}
+
+static const struct pci_device_id piix4_poweroff_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
+	{ 0 },
+};
+
+static struct pci_driver piix4_poweroff_driver = {
+	.name		= "piix4-poweroff",
+	.id_table	= piix4_poweroff_ids,
+	.probe		= piix4_poweroff_probe,
+	.remove		= piix4_poweroff_remove,
+};
+
+module_pci_driver(piix4_poweroff_driver);
+MODULE_AUTHOR("Paul Burton <paul.burton@imgtec.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
