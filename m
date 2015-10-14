Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 14:53:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49771 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009545AbbJNMwma2rLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 14:52:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3EA53992ADF0A;
        Wed, 14 Oct 2015 13:52:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 14 Oct 2015 13:52:36 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 14 Oct 2015 13:52:35 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>
CC:     <linux-mips@linux-mips.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 3/5] MIPS: dt: xilfpga: Add xilfpga device tree files.
Date:   Wed, 14 Oct 2015 13:51:55 +0100
Message-ID: <1444827117-10939-4-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/boot/dts/Makefile                |  1 +
 arch/mips/boot/dts/xilfpga/Makefile        |  9 ++++++
 arch/mips/boot/dts/xilfpga/microAptiv.dtsi | 21 +++++++++++++
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts   | 47 ++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 arch/mips/boot/dts/xilfpga/Makefile
 create mode 100644 arch/mips/boot/dts/xilfpga/microAptiv.dtsi
 create mode 100644 arch/mips/boot/dts/xilfpga/nexys4ddr.dts

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 778a340..0571ef7 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -6,6 +6,7 @@ dts-dirs	+= mti
 dts-dirs	+= netlogic
 dts-dirs	+= qca
 dts-dirs	+= ralink
+dts-dirs	+= xilfpga
 
 obj-y		:= $(addsuffix /, $(dts-dirs))
 
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
new file mode 100644
index 0000000..913a752
--- /dev/null
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_XILFPGA_NEXYS4DDR)	+= nexys4ddr.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files	:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/xilfpga/microAptiv.dtsi b/arch/mips/boot/dts/xilfpga/microAptiv.dtsi
new file mode 100644
index 0000000..81d518e
--- /dev/null
+++ b/arch/mips/boot/dts/xilfpga/microAptiv.dtsi
@@ -0,0 +1,21 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "img,xilfpga";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mips,m14Kc";
+			clocks	= <&ext>;
+			reg = <0>;
+		};
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+};
diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
new file mode 100644
index 0000000..e225ae7
--- /dev/null
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -0,0 +1,47 @@
+/dts-v1/;
+
+#include "microAptiv.dtsi"
+
+/ {
+	compatible = "img,xilfpga";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x07ffffff>;
+	};
+
+	cpuintc: interrupt-controller@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	axi_gpio: gpio@10600000 {
+		#gpio-cells = <1>;
+		compatible = "xlnx,xps-gpio-1.00.a";
+		gpio-controller;
+		reg = < 0x10600000 0x10000 >;
+		xlnx,all-inputs = <0x0>;
+		xlnx,dout-default = <0x0>;
+		xlnx,gpio-width = <0x16>;
+		xlnx,interrupt-present = <0x0>;
+		xlnx,is-dual = <0x0>;
+		xlnx,tri-default = <0xffffffff>;
+	} ;
+
+	axi_uart16550: serial@10400000 {
+		compatible = "ns16550a";
+		reg = <0x10400000 0x10000>;
+
+		reg-shift = <2>;
+		reg-offset = <0x1000>;
+
+		clock-frequency = <50000000>;
+		status = "okay";
+	};
+};
+
+&ext {
+	clock-frequency = <50000000>;
+};
-- 
1.9.1
