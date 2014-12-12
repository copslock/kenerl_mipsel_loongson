Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:14:16 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37985 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008614AbaLLWIxbtsOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:53 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so7367543pab.5
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9GhLKhe0C70l1PWbggdWOZtVPjiRMlMUqttWpdHZk/U=;
        b=ZdLWFpbxNimwzuOZg/qpK8EkgldUuuJ+Dns+vzU1O0d8qDlLsfaToeFpC5iCur9CVL
         yWeDquA+EmYd/YRJaC3b+8O8aPvbPM6PX7Z/z2+3nNpGWdHCCePHm5d3VufRvPUqXqKn
         EqGCBiO0p4pkhZk3XH1goDWQFhHy1qUBnwxLSfVQ30t5teZJrF2tnlfeGa46h7MwQ+tY
         EbT/80CwwEC/uPAekL3gPlCoCsuZiMnxUnpx8lRX55aa2dKud8gOEs39evuLp93vHVKw
         ck7TAqiMaWJzq58+hFT8EqW3mtiIANe5vMA8BUb280dzSKec9uTxn8FpTCeWwDWAa6Zh
         Ih7A==
X-Received: by 10.68.102.5 with SMTP id fk5mr30187007pbb.136.1418422127553;
        Fri, 12 Dec 2014 14:08:47 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:47 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 21/23] MIPS: BMIPS: Refresh BCM3384 DTS files
Date:   Fri, 12 Dec 2014 14:07:12 -0800
Message-Id: <1418422034-17099-22-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

The DT bindings for this platform have changed as the bootloader and
product requirements evolved.  In particular, there are both
Linux-on-Zephyr and Linux-on-Viper configurations.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/boot/dts/bcm3384.dtsi        | 109 ----------------------------
 arch/mips/boot/dts/bcm3384_zephyr.dtsi | 126 +++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/bcm93384wvg.dts     |   9 +--
 3 files changed, 127 insertions(+), 117 deletions(-)
 delete mode 100644 arch/mips/boot/dts/bcm3384.dtsi
 create mode 100644 arch/mips/boot/dts/bcm3384_zephyr.dtsi

diff --git a/arch/mips/boot/dts/bcm3384.dtsi b/arch/mips/boot/dts/bcm3384.dtsi
deleted file mode 100644
index 21b074a..0000000
diff --git a/arch/mips/boot/dts/bcm3384_zephyr.dtsi b/arch/mips/boot/dts/bcm3384_zephyr.dtsi
new file mode 100644
index 0000000..a7bd856
--- /dev/null
+++ b/arch/mips/boot/dts/bcm3384_zephyr.dtsi
@@ -0,0 +1,126 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm3384", "brcm,bcm33843";
+
+	memory@0 {
+		device_type = "memory";
+
+		/* Typical range.  The bootloader should fill this in. */
+		reg = <0x0 0x08000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* On BMIPS5000 this is 1/8th of the CPU core clock */
+		mips-hpt-frequency = <100000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "brcm,ubus", "simple-bus";
+		ranges;
+		dma-ranges = <0x00000000 0x08000000 0x08000000>,
+			     <0x08000000 0x00000000 0x08000000>;
+
+		periph_intc: periph_intc@14e00038 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x14e00038 0x4 0x14e0003c 0x4>,
+			      <0x14e00340 0x4 0x14e00344 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		zmips_intc: zmips_intc@104b0060 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x104b0060 0x4 0x104b0064 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <29>;
+			brcm,int-map-mask = <0xffffffff>;
+		};
+
+		iop_intc: iop_intc@14e00058 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x14e00058 0x4 0x14e0005c 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <6>;
+			brcm,int-map-mask = <0xffffffff>;
+		};
+
+		uart0: serial@14e00520 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x14e00520 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		ehci0: usb@15400300 {
+			compatible = "brcm,bcm3384-ehci", "generic-ehci";
+			reg = <0x15400300 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <41>;
+			status = "disabled";
+		};
+
+		ohci0: usb@15400400 {
+			compatible = "brcm,bcm3384-ohci", "generic-ohci";
+			reg = <0x15400400 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <40>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/bcm93384wvg.dts b/arch/mips/boot/dts/bcm93384wvg.dts
index 8317411..d1e44a1 100644
--- a/arch/mips/boot/dts/bcm93384wvg.dts
+++ b/arch/mips/boot/dts/bcm93384wvg.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "bcm3384.dtsi"
+/include/ "bcm3384_zephyr.dtsi"
 
 / {
 	compatible = "brcm,bcm93384wvg", "brcm,bcm3384";
@@ -10,13 +10,6 @@
 		bootargs = "console=ttyS0,115200";
 		stdout-path = &uart0;
 	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x04000000>;
-		dma-xor-mask = <0x08000000>;
-		dma-xor-limit = <0x0fffffff>;
-	};
 };
 
 &uart0 {
-- 
2.1.1
