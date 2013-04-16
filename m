Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 11:18:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42056 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835169Ab3DPJQvi1Ika (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 11:16:51 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 6/6] DT: MIPS: ralink: add MT7620A dts files
Date:   Tue, 16 Apr 2013 11:12:42 +0200
Message-Id: <1366103562-21463-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366103562-21463-1-git-send-email-blogic@openwrt.org>
References: <1366103562-21463-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36234
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

Add a dtsi file for MT7620A SoC and a sample dts file.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig              |    4 +++
 arch/mips/ralink/dts/Makefile         |    1 +
 arch/mips/ralink/dts/mt7620a.dtsi     |   58 +++++++++++++++++++++++++++++++++
 arch/mips/ralink/dts/mt7620a_eval.dts |   16 +++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 arch/mips/ralink/dts/mt7620a.dtsi
 create mode 100644 arch/mips/ralink/dts/mt7620a_eval.dts

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 493411f..026e823 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -46,6 +46,10 @@ choice
 		bool "RT3883 eval kit"
 		depends on SOC_RT3883
 
+	config DTB_MT7620A_EVAL
+		bool "MT7620A eval kit"
+		depends on SOC_MT7620
+
 endchoice
 
 endif
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
index 040a986..18194fa 100644
--- a/arch/mips/ralink/dts/Makefile
+++ b/arch/mips/ralink/dts/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
 obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
 obj-$(CONFIG_DTB_RT3883_EVAL) := rt3883_eval.dtb.o
+obj-$(CONFIG_DTB_MT7620A_EVAL) := mt7620a_eval.dtb.o
diff --git a/arch/mips/ralink/dts/mt7620a.dtsi b/arch/mips/ralink/dts/mt7620a.dtsi
new file mode 100644
index 0000000..08bf24f
--- /dev/null
+++ b/arch/mips/ralink/dts/mt7620a.dtsi
@@ -0,0 +1,58 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,mtk7620a-soc";
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
+			compatible = "ralink,mt7620a-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,mt7620a-intc", "ralink,rt2880-intc";
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
+			compatible = "ralink,mt7620a-memc", "ralink,rt3050-memc";
+			reg = <0x300 0x100>;
+		};
+
+		uartlite@c00 {
+			compatible = "ralink,mt7620a-uart", "ralink,rt2880-uart", "ns16550a";
+			reg = <0xc00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+
+			reg-shift = <2>;
+		};
+	};
+};
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
new file mode 100644
index 0000000..35eb874
--- /dev/null
+++ b/arch/mips/ralink/dts/mt7620a_eval.dts
@@ -0,0 +1,16 @@
+/dts-v1/;
+
+/include/ "mt7620a.dtsi"
+
+/ {
+	compatible = "ralink,mt7620a-eval-board", "ralink,mt7620a-soc";
+	model = "Ralink MT7620A evaluation board";
+
+	memory@0 {
+		reg = <0x0 0x2000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+};
-- 
1.7.10.4
