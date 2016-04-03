Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 11:56:42 +0200 (CEST)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34181 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007523AbcDCJ4Z1aRid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 11:56:25 +0200
Received: by mail-lb0-f195.google.com with SMTP id vk4so16409085lbb.1;
        Sun, 03 Apr 2016 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKJi5dO1Zm4a2fg/esMigoXGRSbhQQxwOgR2WnYyxJs=;
        b=yqiV42+xFxue0B0lddCqQ+h9iu3oVa29ZucKpL8XSn3SonWhYmFvvSEBN2CtArW8jk
         7T0OiP6TviCkVtmair8Ckb8SVM2tHXsvGVrGkenLuXzgZXUjy4iXwUWGdPoY7HFtZyaK
         JNsrKW1uIeZkSzhM9uSGRauYucXxKTvsh9/nOk5cZ5wzuyRXHnPJPGPtlASjnJj5VO3l
         /ZADbIvPyt4e726q4JYjpBxjmU4MHK2CB7l+k6pfGGYTG5v0AJN4zOSKCyDxCgX1NYu/
         swcq+T2TTDklRoJopT+DqFcqSzsoFsf3h7LtWtLnEgAG5hZP3k8U9a8EgJh3wFu82fRG
         +xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKJi5dO1Zm4a2fg/esMigoXGRSbhQQxwOgR2WnYyxJs=;
        b=J3g2SS3vLu3Xjveh3N4HdP3Sb5e91QkX05KNwPYJPRYM2v07KRo7M0YVqojqdF/Vrh
         0scd6cDov6LexcGGGqhjWvmSDs6+6cD0sxel0Vuvdz0J5Csp6BAFLFVERG/CSBzYPEZZ
         AYhIIZS4y2+9gjnPaTN1TR1JeoGsxOuO4LhDZNXMWnc6M5L/DXII8O20z6z/+z0kN0Cs
         VqnDdlDH/c95C/IsjcKP8hPF79q3BfPuCooi5OZCzEFUpMVBcKcC8hYP5AsVGcAW1zpq
         4u4PJWqe7MdyddfIm8qizNfgcBaBpfOz8OakKrxso9CSwSBzX19SSM40BtNMLiGue1GX
         0Cfg==
X-Gm-Message-State: AD7BkJJ0zk1F8iquFmANmweypKKizRCbch5STQ4GugxAflTRNRL948hpf/CuDCkZ+csMTw==
X-Received: by 10.28.222.84 with SMTP id v81mr6823717wmg.42.1459677379617;
        Sun, 03 Apr 2016 02:56:19 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id w202sm6645124wmw.18.2016.04.03.02.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 02:56:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com, robh@kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 2/2] bmips: add device tree example for BCM6358
Date:   Sun,  3 Apr 2016 11:56:16 +0200
Message-Id: <1459677376-10449-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459677376-10449-1-git-send-email-noltari@gmail.com>
References: <1456054881-26787-1-git-send-email-noltari@gmail.com>
 <1459677376-10449-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52840
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
 v3: Device tree fixes
  - Use interrupt-controller instead of periph_intc.
  - Use led@# instead of naming the LEDs.
 v2: Remove led0 alias and use stdout-path only

 .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               | 111 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  46 +++++++++
 5 files changed, 164 insertions(+), 1 deletion(-)
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
index 0000000..5ac1ef0
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
+			little-endian;
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
