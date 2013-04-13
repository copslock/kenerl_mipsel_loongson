Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 10:56:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54446 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832029Ab3DMIyeB0DTn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 10:54:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 6/6] DT: MIPS: ralink: add MT7620 dts files
Date:   Sat, 13 Apr 2013 10:50:26 +0200
Message-Id: <1365843026-11015-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36136
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

Add a dtsi file for MT7620 SoC and a sample dts file.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig             |    4 +++
 arch/mips/ralink/dts/Makefile        |    1 +
 arch/mips/ralink/dts/mt7620.dtsi     |   58 ++++++++++++++++++++++++++++++++++
 arch/mips/ralink/dts/mt7620_eval.dts |   18 +++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 arch/mips/ralink/dts/mt7620.dtsi
 create mode 100644 arch/mips/ralink/dts/mt7620_eval.dts

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 493411f..8254502 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -46,6 +46,10 @@ choice
 		bool "RT3883 eval kit"
 		depends on SOC_RT3883
 
+	config DTB_MT7620_EVAL
+		bool "MT7620 eval kit"
+		depends on SOC_MT7620
+
 endchoice
 
 endif
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
index 040a986..036603a 100644
--- a/arch/mips/ralink/dts/Makefile
+++ b/arch/mips/ralink/dts/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
 obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
 obj-$(CONFIG_DTB_RT3883_EVAL) := rt3883_eval.dtb.o
+obj-$(CONFIG_DTB_MT7620_EVAL) := mt7620_eval.dtb.o
diff --git a/arch/mips/ralink/dts/mt7620.dtsi b/arch/mips/ralink/dts/mt7620.dtsi
new file mode 100644
index 0000000..5087c57
--- /dev/null
+++ b/arch/mips/ralink/dts/mt7620.dtsi
@@ -0,0 +1,58 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,mtk7620n-soc", "ralink,mt7620-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips24KEc";
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
+	palmbus@10000000 {
+		compatible = "palmbus";
+		reg = <0x10000000 0x200000>;
+                ranges = <0x0 0x10000000 0x1FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc@0 {
+			compatible = "ralink,mt7620-sysc", "ralink,mt7620n-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,mt7620-intc", "ralink,rt2880-intc";
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
+			compatible = "ralink,mt7620-memc", "ralink,rt3050-memc";
+			reg = <0x300 0x100>;
+		};
+
+		uartlite@c00 {
+			compatible = "ralink,mt7620-uart", "ralink,rt2880-uart", "ns16550a";
+			reg = <0xc00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+
+			reg-shift = <2>;
+		};
+	};
+};
diff --git a/arch/mips/ralink/dts/mt7620_eval.dts b/arch/mips/ralink/dts/mt7620_eval.dts
new file mode 100644
index 0000000..72dec59
--- /dev/null
+++ b/arch/mips/ralink/dts/mt7620_eval.dts
@@ -0,0 +1,18 @@
+/dts-v1/;
+
+/include/ "mt7620.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,mt7620a-eval-board", "ralink,mt7620a-soc";
+	model = "Ralink MT7620 evaluation board";
+
+	memory@0 {
+		reg = <0x0 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+};
-- 
1.7.10.4
