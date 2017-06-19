Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:54:12 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58807 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993009AbdFSPt5knhCH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id C724B1A45D1;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A45BB1A46A9;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 05/10] MIPS: ranchu: Add Ranchu as a new generic-based board
Date:   Mon, 19 Jun 2017 17:49:35 +0200
Message-Id: <1497887380-13718-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Provide amendments to Mips generic platform framework so that
a new generic-based virtual board Ranchu can be chosen to be built.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                                   |  6 ++
 arch/mips/configs/generic/board-ranchu.config | 23 ++++++++
 arch/mips/generic/Kconfig                     | 11 ++++
 arch/mips/generic/Makefile                    |  1 +
 arch/mips/generic/board-ranchu.c              | 83 +++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb4c6ea..35dfdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10678,6 +10678,12 @@ S:	Maintained
 F:	Documentation/blockdev/ramdisk.txt
 F:	drivers/block/brd.c
 
+RANCHU VIRTUAL BOARD FOR MIPS
+M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
+L:	linux-mips@linux-mips.org
+S:	Supported
+F:	arch/mips/generic/board-ranchu.c
+
 RANDOM NUMBER DRIVER
 M:	"Theodore Ts'o" <tytso@mit.edu>
 S:	Maintained
diff --git a/arch/mips/configs/generic/board-ranchu.config b/arch/mips/configs/generic/board-ranchu.config
new file mode 100644
index 0000000..7ce0948
--- /dev/null
+++ b/arch/mips/configs/generic/board-ranchu.config
@@ -0,0 +1,23 @@
+CONFIG_VIRT_BOARD_RANCHU=y
+
+CONFIG_BATTERY_GOLDFISH=y
+CONFIG_FB_GOLDFISH=y
+CONFIG_GOLDFISH=y
+CONFIG_GOLDFISH_AUDIO=y
+CONFIG_GOLDFISH_PIC=y
+CONFIG_GOLDFISH_PIPE=y
+CONFIG_GOLDFISH_TTY=y
+CONFIG_RTC_DRV_GOLDFISH=y
+
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
+
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index a606b3f..15be3f9 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -16,4 +16,15 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+config VIRT_BOARD_RANCHU
+	bool "Ranchu platform for Android emulator"
+	select LEGACY_BOARDS
+	help
+	  This enables support for the platform used by Android emulator.
+
+	  Ranchu platform consists of a set of virtual devices. This platform
+	  enables emulation of variety of virtual configurations while using
+	  Android emulator. Android emulator is based on Qemu, and contains
+	  the support for the same set of virtual devices.
+
 endif
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index acb9b6d..4ae52f3 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -13,4 +13,5 @@ obj-y += irq.o
 obj-y += proc.o
 
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
+obj-$(CONFIG_VIRT_BOARD_RANCHU)	+= board-ranchu.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
new file mode 100644
index 0000000..5dc96e5
--- /dev/null
+++ b/arch/mips/generic/board-ranchu.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2017 Imagination Technologies Ltd.
+ * Author: Miodrag Dinic <miodrag.dinic@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/machine.h>
+#include <asm/time.h>
+
+#define GOLDFISH_TIMER_LOW		0x00
+#define GOLDFISH_TIMER_HIGH		0x04
+#define GOLDFISH_TIMER_BASE		0x1f005000
+
+static __init uint64_t read_rtc_time(void __iomem *base)
+{
+	uint64_t time_low;
+	uint64_t time_high;
+	uint64_t time_high_prev;
+
+	time_high = readl(base + GOLDFISH_TIMER_HIGH);
+	do {
+		time_high_prev = time_high;
+		time_low = readl(base + GOLDFISH_TIMER_LOW);
+		time_high = readl(base + GOLDFISH_TIMER_HIGH);
+	} while (time_high != time_high_prev);
+
+	return ((int64_t)time_high << 32) | time_low;
+}
+
+static __init unsigned int ranchu_measure_hpt_freq(void)
+{
+	uint64_t rtc_start, rtc_current, rtc_delta;
+	unsigned int start, count;
+	unsigned int prid = read_c0_prid() & 0xffff00;
+	void __iomem *rtc_base = ioremap(GOLDFISH_TIMER_BASE, 0x1000);
+
+	if (!rtc_base)
+		panic("%s(): Failed to ioremap Goldfish timer base %p!",
+			__func__, (void *)GOLDFISH_TIMER_BASE);
+
+	/*
+	 * poll the nanosecond resolution RTC for 1 second
+	 * to calibrate the CPU frequency
+	 */
+
+	rtc_start = read_rtc_time(rtc_base);
+	start = read_c0_count();
+
+	do {
+		rtc_current = read_rtc_time(rtc_base);
+		rtc_delta = rtc_current - rtc_start;
+	} while (rtc_delta < NSEC_PER_SEC);
+
+	count = read_c0_count() - start;
+
+	mips_hpt_frequency = count;
+	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
+		(prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
+		count *= 2;
+
+	count += 5000;	/* round */
+	count -= count%10000;
+
+	return count;
+}
+
+static const struct of_device_id ranchu_of_match[];
+
+MIPS_MACHINE(ranchu) = {
+	.matches = ranchu_of_match,
+	.measure_hpt_freq = ranchu_measure_hpt_freq,
+};
+
+static const struct of_device_id ranchu_of_match[] = {
+	{
+		.compatible = "mti,ranchu",
+		.data = &__mips_mach_ranchu,
+	},
+};
-- 
2.7.4
