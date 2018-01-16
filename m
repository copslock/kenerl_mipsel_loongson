Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:54:15 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:42522 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994682AbeAPPs0SEBFE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:26 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 14/14] MIPS: ingenic: Initial GCW Zero support
Date:   Tue, 16 Jan 2018 16:48:04 +0100
Message-Id: <20180116154804.21150-15-paul@crapouillou.net>
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117704; bh=Xa3dYX7/MrSx6EUvB/SCtGZZnzcss0R5Gfd3Jf6F3o8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E9REr7E/pDN1FEIZn3NN98J2xoEsaeZvw1pFdIgk5NmPsX85xCe8fBILGPeAfd8CNMxfd1t0x7/dQMENTMbYXZf65leJHt/Ea9xittYJnxNXpNU7Sasqk958zncZJCoJYoCg6xuCtbgEHYU/LIZtfWRMY8ia47TD+kpgx8u5G0c=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62190
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
Acked-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 arch/mips/boot/dts/ingenic/Makefile |  1 +
 arch/mips/boot/dts/ingenic/gcw0.dts | 62 +++++++++++++++++++++++++++++++++++++
 arch/mips/configs/gcw0_defconfig    | 27 ++++++++++++++++
 arch/mips/jz4740/Kconfig            |  4 +++
 4 files changed, 94 insertions(+)
 create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
 create mode 100644 arch/mips/configs/gcw0_defconfig

 v2: No change
 v3: No change
 v4: No change
 v5: Use SPDX license identifier
     Drop custom CROSS_COMPILE from defconfig
 v6: Add "model" property in devicetree
 v7: No change

diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index 6a31759839b4..5b1361a89e02 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
+dtb-$(CONFIG_JZ4770_GCW0)	+= gcw0.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
new file mode 100644
index 000000000000..35f0291e8d38
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "jz4770.dtsi"
+
+/ {
+	compatible = "gcw,zero", "ingenic,jz4770";
+	model = "GCW Zero";
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
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
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
index 000000000000..99ac1fa3b35f
--- /dev/null
+++ b/arch/mips/configs/gcw0_defconfig
@@ -0,0 +1,27 @@
+CONFIG_MACH_INGENIC=y
+CONFIG_JZ4770_GCW0=y
+CONFIG_HIGHMEM=y
+# CONFIG_BOUNCE is not set
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_SECCOMP is not set
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
index 29a9361a2b77..4dd0c446ecec 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -8,6 +8,10 @@ config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 	select MACH_JZ4740
 
+config JZ4770_GCW0
+	bool "Game Consoles Worldwide GCW Zero"
+	select MACH_JZ4770
+
 config JZ4780_CI20
 	bool "MIPS Creator CI20"
 	select MACH_JZ4780
-- 
2.11.0
