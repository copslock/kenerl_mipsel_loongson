Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:40:24 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35696 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042094AbcFMHixgfM1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:53 +0200
Received: by mail-wm0-f68.google.com with SMTP id k184so12589126wme.2;
        Mon, 13 Jun 2016 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQGhCOjIvVZ9NZxrdetBpl7F5I+qM7YIjTTIIXIUZNE=;
        b=l7TBgRoxWgxH4RSMqbrxr+U+NR/PJGgJcApsYqI4cJWiUvt/qP4mrnIO2z6Jb7nUjH
         gHZirmUpdS156yYBCSbSeidV+S8+ibh3FNKb4leN5jkQCMAIvvc6H/wKSJTCOBJpgEiW
         2qsFMfaD2HccoJYjTNqEvcu9MA8w8hpExo3akm8Ft5PIH6mzrJW0Yc9hGMGyYeOdmifC
         NHxCxCmYNJFFHqgedOdLwZ1uOdOme1F1EiQIeEovoehKYjovnAWkvN1R6gvrquaLfgL9
         8pt3NZ30WGoQ2I7d8tUjxksMGmaoQGC3yM7BSVZAPNaA5kyLvUPWx5v2r6vOkXk9vRS2
         d2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQGhCOjIvVZ9NZxrdetBpl7F5I+qM7YIjTTIIXIUZNE=;
        b=m7UxqFVaalXBUkYGweSrm/zTubX8c2qGQFJE9IoKOWEPkjJxBmkcgiQ70RkNBTQEBu
         60MVdSPOqsyEcoDDT9ygFnaLNdrNYAHTK383OPDMhVJ4NAc+/QchoovepudBWUAz7ZYg
         79EkZPOSA/smMefVaT7VWkfB+rQ0FxEqDD6+KBujFyU2ZicvsvdVJZkJNwl+MUMi/dpu
         bcObdKlPK8DtGpPLWocEz2V6/reXPi1C8elNiVb43yryyt/SeLrjUdt5En5TZnKbnekx
         Oi/MWTpZ884vRNipggPDLwHPgY0foSa08zz2nZxZ0kGtqPi961o68T2/kuLrUBE2QRbX
         W/Ew==
X-Gm-Message-State: ALyK8tLPQGE4ZYcTjjGo4xGpD8DH5mopFP1NdANeW+QwX230dEVCh9EOC7ib35e0/vKsoA==
X-Received: by 10.28.175.7 with SMTP id y7mr9488470wme.59.1465803528310;
        Mon, 13 Jun 2016 00:38:48 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 6/6] MIPS: BMIPS: Add device tree example for BCM6362
Date:   Mon, 13 Jun 2016 09:38:54 +0200
Message-Id: <1465803534-25840-6-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1465803534-25840-1-git-send-email-noltari@gmail.com>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54029
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

This adds a device tree example for SFR NeufBox 6.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/Kconfig                    |   4 +
 arch/mips/boot/dts/brcm/Makefile           |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi       | 134 +++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96362nb6ser.dts |  22 +++++
 4 files changed, 162 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm6362.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm96362nb6ser.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 5b0ad8c..43da496 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -33,6 +33,10 @@ config DT_BCM96358NB4SER
 	bool "BCM96358NB4SER"
 	select BUILTIN_DTB
 
+config DT_BCM96362NB6SER
+	bool "BCM96362NB6SER"
+	select BUILTIN_DTB
+
 config DT_BCM96368MVWG
 	bool "BCM96368MVWG"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index c553b95..161e54b 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
 dtb-$(CONFIG_DT_BCM963268VR3032U)	+= bcm963268vr3032u.dtb
 dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
+dtb-$(CONFIG_DT_BCM96362NB6SER)		+= bcm96362nb6ser.dtb
 dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
 dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
 dtb-$(CONFIG_DT_BCM97125CBMB)		+= bcm97125cbmb.dtb
@@ -20,6 +21,7 @@ dtb-$(CONFIG_DT_NONE)			+= \
 						bcm93384wvg_viper.dtb	\
 						bcm963268vr3032u.dtb	\
 						bcm96358nb4ser.dtb	\
+						bcm96362nb6ser.dtb	\
 						bcm96368mvwg.dtb	\
 						bcm9ejtagprb.dtb	\
 						bcm97125cbmb.dtb	\
diff --git a/arch/mips/boot/dts/brcm/bcm6362.dtsi b/arch/mips/boot/dts/brcm/bcm6362.dtsi
new file mode 100644
index 0000000..c507da5
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6362.dtsi
@@ -0,0 +1,134 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6362";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <200000000>;
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
+		periph_clk: periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	cpu_intc: interrupt-controller {
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
+		periph_cntl: syscon@10000000 {
+			compatible = "syscon";
+			reg = <0x10000000 0x14>;
+			native-endian;
+		};
+
+		reboot: syscon-reboot@10000008 {
+			compatible = "syscon-reboot";
+			regmap = <&periph_cntl>;
+			offset = <0x8>;
+			mask = <0x1>;
+		};
+
+		periph_intc: interrupt-controller@10000020 {
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0x10000020 0x10>,
+			      <0x10000030 0x10>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		uart0: serial@10000100 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000100 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <3>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@10000120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000120 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <4>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		leds0: led-controller@10001900 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6328-leds";
+			reg = <0x10001900 0x24>;
+
+			status = "disabled";
+		};
+
+		ehci: usb@10002500 {
+			compatible = "brcm,bcm6362-ehci", "generic-ehci";
+			reg = <0x10002500 0x100>;
+			big-endian;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <10>;
+
+			status = "disabled";
+		};
+
+		ohci: usb@10002600 {
+			compatible = "brcm,bcm6362-ohci", "generic-ohci";
+			reg = <0x10002600 0x100>;
+			big-endian;
+			no-big-frame-no;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <9>;
+
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts b/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts
new file mode 100644
index 0000000..a470230
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm96362nb6ser.dts
@@ -0,0 +1,22 @@
+/dts-v1/;
+
+/include/ "bcm6362.dtsi"
+
+/ {
+	compatible = "sfr,nb6-ser", "brcm,bcm6362";
+	model = "SFT NeufBox 6 (Sercomm)";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
