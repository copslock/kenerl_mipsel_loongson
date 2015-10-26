Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 12:32:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55509 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011343AbbJZLbuMY8vG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 12:31:50 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 004458E23381D;
        Mon, 26 Oct 2015 11:31:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Oct 2015 11:31:44 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 26 Oct 2015 11:31:43 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <robh+dt@kernel.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH_V3 2/4] MIPS: dt: xilfpga: Add xilfpga device tree files.
Date:   Mon, 26 Oct 2015 11:30:55 +0000
Message-ID: <1445859057-47665-3-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1445859057-47665-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1445859057-47665-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49694
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

Add device tree files for the MIPSfpga platform.

See Documentation/devicetree/bindings/mips/img/xilfpga.txt
for details about MIPSfpga

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V2 -> V3

no change

V1 -> V2
Reformatted git log for 80 column
Added nexys4ddr compatible
Fixed some whitespace
Removed a redundant status okay
---
 arch/mips/boot/dts/Makefile                |  1 +
 arch/mips/boot/dts/xilfpga/Makefile        |  9 ++++++
 arch/mips/boot/dts/xilfpga/microAptiv.dtsi | 21 ++++++++++++++
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts   | 46 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)
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
index 0000000..686ebd1
--- /dev/null
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -0,0 +1,46 @@
+/dts-v1/;
+
+#include "microAptiv.dtsi"
+
+/ {
+	compatible = "digilent,nexys4ddr";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x08000000>;
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
+		reg = <0x10600000 0x10000>;
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
+		clocks	= <&ext>;
+	};
+};
+
+&ext {
+	clock-frequency = <50000000>;
+};
-- 
1.9.1
