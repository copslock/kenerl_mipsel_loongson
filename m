Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:13:19 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37435 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992974AbdHRNMvsiRH9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:12:51 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 51E401A4513;
        Fri, 18 Aug 2017 15:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 32BB51A4510;
        Fri, 18 Aug 2017 15:12:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 5/8] MIPS: ranchu: Add Ranchu as a new generic-based board
Date:   Fri, 18 Aug 2017 15:08:57 +0200
Message-Id: <1503061833-26563-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59651
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

Provide amendments to the Mips generic platform framework so that
the new generic-based board Ranchu can be chosen to be built.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                                   |  6 +++
 arch/mips/configs/generic/board-ranchu.config | 30 +++++++++++
 arch/mips/generic/Kconfig                     | 11 ++++
 arch/mips/generic/Makefile                    |  1 +
 arch/mips/generic/board-ranchu.c              | 78 +++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426875..03403c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11063,6 +11063,12 @@ S:	Maintained
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
index 0000000..fee9ad4
--- /dev/null
+++ b/arch/mips/configs/generic/board-ranchu.config
@@ -0,0 +1,30 @@
+CONFIG_VIRT_BOARD_RANCHU=y
+
+CONFIG_BATTERY_GOLDFISH=y
+CONFIG_FB=y
+CONFIG_FB_GOLDFISH=y
+CONFIG_GOLDFISH=y
+CONFIG_STAGING=y
+CONFIG_GOLDFISH_AUDIO=y
+CONFIG_GOLDFISH_PIC=y
+CONFIG_GOLDFISH_PIPE=y
+CONFIG_GOLDFISH_TTY=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GOLDFISH=y
+
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
+
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 51ffbba..fe1231d 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -36,4 +36,15 @@ config FIT_IMAGE_FDT_BOSTON
 	  enable this if you wish to boot on a MIPS Boston board, as it is
 	  expected by the bootloader.
 
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
index 56b3ea5..14931f2 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -14,4 +14,5 @@ obj-y += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
+obj-$(CONFIG_VIRT_BOARD_RANCHU)	+= board-ranchu.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
new file mode 100644
index 0000000..500874d
--- /dev/null
+++ b/arch/mips/generic/board-ranchu.c
@@ -0,0 +1,78 @@
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
+#include <linux/of_address.h>
+
+#include <asm/machine.h>
+#include <asm/time.h>
+
+#define GOLDFISH_TIMER_LOW		0x00
+#define GOLDFISH_TIMER_HIGH		0x04
+
+static __init uint64_t read_rtc_time(void __iomem *base)
+{
+	u64 time_low;
+	u64 time_high;
+
+	time_low = readl(base + GOLDFISH_TIMER_LOW);
+	time_high = readl(base + GOLDFISH_TIMER_HIGH);
+
+	return (time_high << 32) | time_low;
+}
+
+static __init unsigned int ranchu_measure_hpt_freq(void)
+{
+	u64 rtc_start, rtc_current, rtc_delta;
+	unsigned int start, count;
+	struct device_node *np;
+	void __iomem *rtc_base;
+
+	np = of_find_compatible_node(NULL, NULL, "google,goldfish-rtc");
+	if (!np)
+		panic("%s(): Failed to find 'google,goldfish-rtc' dt node!",
+		      __func__);
+
+	rtc_base = of_iomap(np, 0);
+	if (!rtc_base)
+		panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
+
+	/*
+	 * poll the nanosecond resolution RTC for 1 second
+	 * to calibrate the CPU frequency
+	 */
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
+	count += 5000;	/* round */
+	count -= count % 10000;
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
