Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 22:10:42 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59894 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdFGUFFgE0Lq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 22:05:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 15/15] MIPS: ingenic: Initial GCW Zero support
Date:   Wed,  7 Jun 2017 22:04:39 +0200
Message-Id: <20170607200439.24450-16-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-1-paul@crapouillou.net>
References: <20170607200439.24450-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The GCW Zero (http://www.gcw-zero.com) is a retro-gaming focused
handheld game console, successfully kickstarted in ~2012, running Linux.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/Makefile |  1 +
 arch/mips/boot/dts/ingenic/gcw0.dts | 60 +++++++++++++++++++++++++++++++++++++
 arch/mips/configs/gcw0_defconfig    | 28 +++++++++++++++++
 arch/mips/jz4740/Kconfig            |  4 +++
 arch/mips/jz4740/boards.c           |  1 +
 5 files changed, 94 insertions(+)
 create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
 create mode 100644 arch/mips/configs/gcw0_defconfig

diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index f2b864f07850..f64ad1c27a28 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
+dtb-$(CONFIG_JZ4770_GCW0)	+= gcw0.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
new file mode 100644
index 000000000000..9c9a0137ccdf
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -0,0 +1,60 @@
+/dts-v1/;
+
+#include "jz4770.dtsi"
+
+/ {
+	compatible = "gcw,zero", "ingenic,jz4770";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial2:57600n8";
+	};
+
+	board {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <>;
+
+		otg_phy: otg-phy {
+			compatible = "usb-nop-xceiv";
+			clocks = <&cgu JZ4770_CLK_OTG_PHY>;
+			clock-names = "main_clk";
+		};
+	};
+};
+
+&ext {
+	clock-frequency = <12000000>;
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&cgu {
+	/* Put high-speed peripherals under PLL1, such that we can change the
+	 * PLL0 frequency on demand without having to suspend peripherals.
+	 * We use a rate of 432 MHz, which is the least common multiple of
+	 * 27 MHz (required by TV encoder) and 48 MHz (required by USB host).
+	 */
+	assigned-clocks =
+		<&cgu JZ4770_CLK_PLL1>,
+		<&cgu JZ4770_CLK_UHC>;
+	assigned-clock-parents =
+		<0>,
+		<&cgu JZ4770_CLK_PLL1>;
+	assigned-clock-rates =
+		<432000000>;
+};
+
+&uhc {
+	/* The WiFi module is connected to the UHC. */
+	status = "okay";
+};
diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
new file mode 100644
index 000000000000..471497033855
--- /dev/null
+++ b/arch/mips/configs/gcw0_defconfig
@@ -0,0 +1,28 @@
+CONFIG_MACH_INGENIC=y
+CONFIG_JZ4770_GCW0=y
+CONFIG_HIGHMEM=y
+# CONFIG_BOUNCE is not set
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_SECCOMP is not set
+CONFIG_CROSS_COMPILE="mipsel-gcw0-linux-uclibc-"
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_EMBEDDED=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_NETDEVICES=y
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_INGENIC=y
+CONFIG_USB=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_TMPFS=y
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 922850503271..db270653fe8c 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -7,6 +7,10 @@ config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 	select MACH_JZ4740
 
+config JZ4770_GCW0
+	bool "Game Consoles Worldwide GCW Zero"
+	select MACH_JZ4770
+
 config JZ4780_CI20
 	bool "MIPS Creator CI20"
 	select MACH_JZ4780
diff --git a/arch/mips/jz4740/boards.c b/arch/mips/jz4740/boards.c
index a3cf64cf004a..98a4d8e68cf0 100644
--- a/arch/mips/jz4740/boards.c
+++ b/arch/mips/jz4740/boards.c
@@ -12,5 +12,6 @@
 #include <asm/mips_machine.h>
 
 MIPS_MACHINE(MACH_INGENIC_JZ4740, "qi,lb60", "Qi Hardware Ben Nanonote", NULL);
+MIPS_MACHINE(MACH_INGENIC_JZ4770, "gcw,zero", "GCW Zero", NULL);
 MIPS_MACHINE(MACH_INGENIC_JZ4780, "img,ci20",
 			"Imagination Technologies CI20", NULL);
-- 
2.11.0
