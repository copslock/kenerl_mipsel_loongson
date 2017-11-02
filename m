Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:25:01 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:55539 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993543AbdKBQXePaXSw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:23:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 00DE21A4B39;
        Thu,  2 Nov 2017 17:23:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 6B61C1A4AD6;
        Thu,  2 Nov 2017 17:23:23 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v7 5/5] MIPS: ranchu: Add Ranchu as a new generic-based board
Date:   Thu,  2 Nov 2017 17:21:24 +0100
Message-Id: <1509639716-4787-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509639716-4787-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509639716-4787-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60687
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

From: Miodrag Dinic <miodrag.dinic@mips.com>

Provide amendments to the MIPS generic platform framework so that
the new generic-based board Ranchu can be chosen to be built.

The Ranchu board is intended to be used by Android emulator. The name
"Ranchu" originates from Android development community. "Goldfish" and
"Ranchu" are terms used for two generations of virtual boards used by
Android emulator. The name "Ranchu" is a newer one among the two, and
this patch deals with Ranchu. However, for historical reasons, some
devices/drivers still contain the name "Goldfish".

MIPS Ranchu machine includes a number of Goldfish devices. The support
for Virtio devices is also included. Ranchu board supports up to 16
Virtio devices which can be attached using Virtio MMIO Bus. This is
summarized in the following picture:

       ABUS
        ||----MIPS CPU
        ||       |                    IRQs
        ||----Goldfish PIC------------(32)--------
        ||                     | | | | | | | | |
        ||----Goldfish TTY------ | | | | | | | |
        ||                       | | | | | | | |
        ||----Goldfish RTC-------- | | | | | | |
        ||                         | | | | | | |
        ||----Goldfish FB----------- | | | | | |
        ||                           | | | | | |
        ||----Goldfish Events--------- | | | | |
        ||                             | | | | |
        ||----Goldfish Audio------------ | | | |
        ||                               | | | |
        ||----Goldfish Battery------------ | | |
        ||                                 | | |
        ||----Android PIPE------------------ | |
        ||                                   | |
        ||----Virtio MMIO Bus                | |
        ||    |    |    |                    | |
        ||    |    |   (virtio-block)--------- |
        ||   (16)  |                           |
        ||    |   (virtio-net)------------------

Device Tree is created on the QEMU side based on the information about
devices IO map and IRQ numbers. Kernel will load this DTB using UHI
boot protocol DTB handover mode.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 MAINTAINERS                                   |  7 +++
 arch/mips/configs/generic/board-ranchu.config | 30 +++++++++
 arch/mips/generic/Kconfig                     | 10 +++
 arch/mips/generic/Makefile                    |  1 +
 arch/mips/generic/board-ranchu.c              | 88 +++++++++++++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bf5587..3cce323 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11308,6 +11308,13 @@ S:	Maintained
 F:	Documentation/blockdev/ramdisk.txt
 F:	drivers/block/brd.c
 
+RANCHU VIRTUAL BOARD FOR MIPS
+M:	Miodrag Dinic <miodrag.dinic@mips.com>
+L:	linux-mips@linux-mips.org
+S:	Supported
+F:	arch/mips/generic/board-ranchu.c
+F:	arch/mips/configs/generic/board-ranchu.config
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
index e0436aa..7e66173 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -42,4 +42,14 @@ config FIT_IMAGE_FDT_NI169445
 	  Enable this to include the FDT for the 169445 platform from
 	  National Instruments in the FIT kernel image.
 
+config VIRT_BOARD_RANCHU
+	bool "Support Ranchu platform for Android emulator"
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
index 56b3ea5..2fee84a 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -15,3 +15,4 @@ obj-y += proc.o
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
+obj-$(CONFIG_VIRT_BOARD_RANCHU)	+= board-ranchu.o
diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
new file mode 100644
index 0000000..7e0d5f8
--- /dev/null
+++ b/arch/mips/generic/board-ranchu.c
@@ -0,0 +1,88 @@
+/*
+ * Support code for virtual Ranchu board for MIPS.
+ *
+ * Author: Miodrag Dinic <miodrag.dinic@mips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/of_address.h>
+#include <linux/types.h>
+
+#include <asm/machine.h>
+#include <asm/mipsregs.h>
+#include <asm/time.h>
+
+#define GOLDFISH_TIMER_LOW		0x00
+#define GOLDFISH_TIMER_HIGH		0x04
+
+static __init u64 read_rtc_time(void __iomem *base)
+{
+	u32 time_low;
+	u32 time_high;
+
+	/*
+	 * Reading the low address latches the high value
+	 * as well so there is no fear that we may read
+	 * inaccurate high value.
+	 */
+	time_low = readl(base + GOLDFISH_TIMER_LOW);
+	time_high = readl(base + GOLDFISH_TIMER_HIGH);
+
+	return ((u64)time_high << 32) | time_low;
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
+	 * Poll the nanosecond resolution RTC for one
+	 * second to calibrate the CPU frequency.
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
+	iounmap(rtc_base);
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
+static const struct of_device_id __initdata ranchu_of_match[] = {
+	{
+		.compatible = "mti,ranchu",
+		.data = &__mips_mach_ranchu,
+	},
+};
-- 
2.7.4
