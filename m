Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 10:56:25 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54428 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827494Ab3DMIydJk3Lf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 10:54:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/6] DT: MIPS: ralink: add RT2880 dts files
Date:   Sat, 13 Apr 2013 10:50:24 +0200
Message-Id: <1365843026-11015-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add a dtsi file for RT2880 SoC and a sample dts file.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig             |    4 +++
 arch/mips/ralink/dts/Makefile        |    1 +
 arch/mips/ralink/dts/rt2880.dtsi     |   58 ++++++++++++++++++++++++++++++++++
 arch/mips/ralink/dts/rt2880_eval.dts |   48 ++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 arch/mips/ralink/dts/rt2880.dtsi
 create mode 100644 arch/mips/ralink/dts/rt2880_eval.dts

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 86f6c77..2f6fbb8 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -34,6 +34,10 @@ choice
 	config DTB_RT_NONE
 		bool "None"
 
+	config DTB_RT2880_EVAL
+		bool "RT2880 eval kit"
+		depends on SOC_RT288X
+
 	config DTB_RT305X_EVAL
 		bool "RT305x eval kit"
 		depends on SOC_RT305X
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
index 1a69fb3..f635a01 100644
--- a/arch/mips/ralink/dts/Makefile
+++ b/arch/mips/ralink/dts/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
 obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
diff --git a/arch/mips/ralink/dts/rt2880.dtsi b/arch/mips/ralink/dts/rt2880.dtsi
new file mode 100644
index 0000000..182afde
--- /dev/null
+++ b/arch/mips/ralink/dts/rt2880.dtsi
@@ -0,0 +1,58 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt2880-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips4KEc";
+		};
+	};
+
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	palmbus@300000 {
+		compatible = "palmbus";
+		reg = <0x300000 0x200000>;
+                ranges = <0x0 0x300000 0x1FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc@0 {
+			compatible = "ralink,rt2880-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,rt2880-intc";
+			reg = <0x200 0x100>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
+
+		memc@300 {
+			compatible = "ralink,rt2880-memc";
+			reg = <0x300 0x100>;
+		};
+
+		uartlite@c00 {
+			compatible = "ralink,rt2880-uart", "ns16550a";
+			reg = <0xc00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <8>;
+
+			reg-shift = <2>;
+		};
+	};
+};
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
new file mode 100644
index 0000000..e967b43
--- /dev/null
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -0,0 +1,48 @@
+/dts-v1/;
+
+/include/ "rt2880.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt2880-eval-board", "ralink,rt2880-soc";
+	model = "Ralink RT2880 evaluation board";
+
+	memory@0 {
+		reg = <0x8000000 0x2000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+
+	cfi@1f000000 {
+		compatible = "cfi-flash";
+		reg = <0x1f000000 0x400000>;
+
+		bank-width = <2>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0x30000>;
+			read-only;
+		};
+		partition@30000 {
+			label = "uboot-env";
+			reg = <0x30000 0x10000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "calibration";
+			reg = <0x40000 0x10000>;
+			read-only;
+		};
+		partition@50000 {
+			label = "linux";
+			reg = <0x50000 0x3b0000>;
+		};
+	};
+};
-- 
1.7.10.4
