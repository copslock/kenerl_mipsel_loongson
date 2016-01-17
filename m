Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 12:28:19 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34829 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009313AbcAQL2AD7B02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jan 2016 12:28:00 +0100
Received: by mail-wm0-f68.google.com with SMTP id 123so3957029wmz.2;
        Sun, 17 Jan 2016 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=uc78Tc9GNftUd8PibzyzIo+/Qo/eXuf0dSLkkoqiFa8=;
        b=PqmvMeG9XuHpJIFPoefsQHUeGKKP8hWltV8n9cWiXBXWJYtsnsqTy2j6FkkFA/0JZO
         bzktkSGXSjCczKxKZUrbYWxf8brqbGo2w2ltyRLOkvGjxzLOz9x3nJIikk/pFD9BL/qF
         y4cClw6tlxihez6H7847IEz/IYPhyIXleFQhAvHavmBO05TZhVb0gNJ2g2ee5p4xB44X
         mo12M8cODoaDT2fdHmhhMZlABBzBCKYA24A9dzcIZVNL69t83ieaA6/sy5BTlHcmYf2q
         lZOxPPWt1hzytX5SHxVSwkUsRrY+NuyU8E3Qq3vFy7cuX50MRzfyH9q7lgQAs2Hr0/8V
         d5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=uc78Tc9GNftUd8PibzyzIo+/Qo/eXuf0dSLkkoqiFa8=;
        b=go6Zo0BU/CtevN1LXgQQQp/QSFviXMxMSg7t0Kkdl1InO0HJnPKFv5tRqKPq0hiPOh
         GafvduvvYglmYdzT2OAdw2+2lHuI2Ks6ACFFIFLUnoQ4GPBRzhn6+p4ce7z2gAadLeur
         /MFwHfonO+IFfK0DqAj7AKsbi+zteXUfmQsJvxc7fTirLH3UQhnJ9c6g4W8As/KT/X60
         re05cnEGyfGsM7eWR2GYbfsz9SlGM4gBwBkZyjdFAAfNIuY7StmtQH7BcIaPYZdMB/0b
         7TBdqauYhqFa8PDd+PbJxJVayHXxxdrLj7bVib9lqAkymxI/8+PKPhHES8/4r/YOcEuh
         s/6Q==
X-Gm-Message-State: AG10YORzNgYOQ5/MNFVC8zkVNghT0x3S4iKL87LqPjvv30hVj0emrxfDu6AE3jf4KVSM5A==
X-Received: by 10.28.64.131 with SMTP id n125mr7285799wma.65.1453030074861;
        Sun, 17 Jan 2016 03:27:54 -0800 (PST)
Received: from skynet.lan (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id fx8sm10617166wjb.13.2016.01.17.03.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 03:27:53 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] bmips: add device tree example for BCM6358
Date:   Sun, 17 Jan 2016 12:28:21 +0100
Message-Id: <1453030101-14794-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51177
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
 .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               | 111 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  47 +++++++++
 5 files changed, 165 insertions(+), 1 deletion(-)
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
index 0000000..b2d11da
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
@@ -0,0 +1,111 @@
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
+		leds0 = &leds0;
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
+		};
+
+		reboot: syscon-reboot@fffe0008 {
+			compatible = "syscon-reboot";
+			regmap = <&periph_cntl>;
+			offset = <0x8>;
+			mask = <0x1>;
+		};
+
+		periph_intc: periph_intc@fffe000c {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0xfffe0010 0x4 0xfffe000c 0x4>,
+			      <0xfffe003c 0x4 0xfffe0038 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
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
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
new file mode 100644
index 0000000..ca95084
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
@@ -0,0 +1,47 @@
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
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&leds0 {
+	status = "ok";
+
+	alarm_white@0 {
+		reg = <0>;
+		active-low;
+		label = "nb4-ser:white:alarm";
+	};
+	tv_white@2 {
+		reg = <2>;
+		active-low;
+		label = "nb4-ser:white:tv";
+	};
+	tel_white@3 {
+		reg = <3>;
+		active-low;
+		label = "nb4-ser:white:tel";
+	};
+	adsl_white@4 {
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
1.9.1
