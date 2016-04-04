Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:09:39 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35830 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025989AbcDDIJWCzJU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 10:09:22 +0200
Received: by mail-lb0-f196.google.com with SMTP id gk8so18369183lbc.2;
        Mon, 04 Apr 2016 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzuR1AEF/4lP/cw6keyD+UDm+HDZ7TLwg93Bdo+9UZs=;
        b=xsqzO7G+3fBM61OuReULSGHa6h9+afi2vZ8X6nKLCemlvtm5rG+/Du+hNi5TV7XAgR
         PT6eASFnBirXrttxeKu6VGbCz5RmQz5lIlWwNiH0AYVGIjCghL6YHkmsd6ASfgjzoIZh
         +/AyGkoW8/trhInQT9FVPxZ2Gy0JXZQdyKCwjFDG0P9tVZGQwIPV7Nuwh813RePmY4hd
         YahxpG0TQF3+DN+mY5sm6iHmYQXgeRleUP58FfAcKgq/3hOhDqGjgvc2Rnz1LBJDYJXT
         X0MldvRsHS81c6/sjD7k3QTA1iIuS81JT3QCjPzR6AtlBm9Oi4BKaNOEaC44T0gbx7JB
         UVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzuR1AEF/4lP/cw6keyD+UDm+HDZ7TLwg93Bdo+9UZs=;
        b=ZKDqq8V0xSvUdTwqWrVdKkYrzPmKNEQ3DRWuBLsHEvNnYSaKS68mJwaKk99hWCnhG+
         1EKgZEVXUPyC+DgNuC5t74+8JiYDEt8rYkzyTuFZ7mB1RcPE+hCqdpj1+WP44QXb3Lit
         EwGOp8hfbOt1/BRCHHI5+moa+6Nce3y5WSlMjlpwg+P6ZknTJHInnWwDcYjS2OB4hdXs
         sVd2q1zoJ3upuxtVqkU2VHWuhZEshVEWj/M7qnx3JtxNUR4cCy1Aq1rrMme195CV6n6V
         IH/NCggI+Z8YSqdpn1B+SSHB8K+jjaA0DXRrd0VaqgH9SUm5U7FaV12Tu0Kw2CpHiUTt
         aCWQ==
X-Gm-Message-State: AD7BkJL73Ptss5F1XXF2FJLAfQrNVJ1mACbSNuuqFNw+LqYOE2XKPAlt9mvoUQs4R4/b2Q==
X-Received: by 10.28.138.198 with SMTP id m189mr10977486wmd.19.1459757356695;
        Mon, 04 Apr 2016 01:09:16 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id k125sm12462455wmb.14.2016.04.04.01.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 01:09:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com, robh@kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 2/2] bmips: add device tree example for BCM6358
Date:   Mon,  4 Apr 2016 10:09:13 +0200
Message-Id: <1459757353-14683-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459757353-14683-1-git-send-email-noltari@gmail.com>
References: <1459677376-10449-1-git-send-email-noltari@gmail.com>
 <1459757353-14683-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

This adds a device tree example for SFR Neufbox4 (Sercomm version), which
also serves as a real example for brcm,bcm6358-leds.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v4: Device tree improvements:
  - Switch to native-endian for syscon.
  - Switch to bcm6345-l1-intc interrupt controller.
  - Add ehci and ohci nodes.
 v3: Device tree fixes
  - Use interrupt-controller instead of periph_intc.
  - Use led@# instead of naming the LEDs.
 v2: Remove led0 alias and use stdout-path only

 .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               | 130 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  46 ++++++++
 5 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/brcm/bcm6358.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 7bab90c..e58a4f6 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
-              "brcm,bcm6328", "brcm,bcm6368",
+              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
 
diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index e2c4fd6..264328d 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -21,6 +21,10 @@ config DT_BCM93384WVG_VIPER
 	bool "BCM93384WVG Viper CPU (EXPERIMENTAL)"
 	select BUILTIN_DTB
 
+config DT_BCM96358NB4SER
+	bool "BCM96358NB4SER"
+	select BUILTIN_DTB
+
 config DT_BCM96368MVWG
 	bool "BCM96368MVWG"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index eabeb60..fda9d38 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
+dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
 dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
 dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
 dtb-$(CONFIG_DT_BCM97125CBMB)		+= bcm97125cbmb.dtb
@@ -14,6 +15,7 @@ dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 dtb-$(CONFIG_DT_NONE)			+= \
 						bcm93384wvg.dtb		\
 						bcm93384wvg_viper.dtb	\
+						bcm96358nb4ser.dtb	\
 						bcm96368mvwg.dtb	\
 						bcm9ejtagprb.dtb	\
 						bcm97125cbmb.dtb	\
diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi b/arch/mips/boot/dts/brcm/bcm6358.dtsi
new file mode 100644
index 0000000..5dc8432
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
@@ -0,0 +1,130 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6358";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <150000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips4350";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+		uart1 = &uart1;
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
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges;
+
+		periph_cntl: syscon@fffe0000 {
+			compatible = "syscon";
+			reg = <0xfffe0000 0xc>;
+			native-endian;
+		};
+
+		reboot: syscon-reboot@fffe0008 {
+			compatible = "syscon-reboot";
+			regmap = <&periph_cntl>;
+			offset = <0x8>;
+			mask = <0x1>;
+		};
+
+		periph_intc: interrupt-controller@fffe000c {
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0xfffe000c 0x8>,
+			      <0xfffe0038 0x8>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		leds0: led-controller@fffe00d0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6358-leds";
+			reg = <0xfffe00d0 0x8>;
+
+			status = "disabled";
+		};
+
+		uart0: serial@fffe0100 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0xfffe0100 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@fffe0120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0xfffe0120 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <3>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		ehci0: usb@fffe1300 {
+			compatible = "brcm,bcm6358-ehci", "generic-ehci";
+			reg = <0xfffe1300 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <10>;
+			status = "disabled";
+		};
+
+		ohci0: usb@fffe1400 {
+			compatible = "brcm,bcm6358-ohci", "generic-ohci";
+			reg = <0xfffe1400 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <5>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
new file mode 100644
index 0000000..f412117
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
@@ -0,0 +1,46 @@
+/dts-v1/;
+
+/include/ "bcm6358.dtsi"
+
+/ {
+	compatible = "sfr,nb4-ser", "brcm,bcm6358";
+	model = "SFR Neufbox 4 (Sercomm)";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x02000000>;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&leds0 {
+	status = "ok";
+
+	led@0 {
+		reg = <0>;
+		active-low;
+		label = "nb4-ser:white:alarm";
+	};
+	led@2 {
+		reg = <2>;
+		active-low;
+		label = "nb4-ser:white:tv";
+	};
+	led@3 {
+		reg = <3>;
+		active-low;
+		label = "nb4-ser:white:tel";
+	};
+	led@4 {
+		reg = <4>;
+		active-low;
+		label = "nb4-ser:white:adsl";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
