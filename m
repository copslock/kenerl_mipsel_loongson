Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:39:07 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35660 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034278AbcFMHiuQd3LC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:50 +0200
Received: by mail-wm0-f66.google.com with SMTP id k184so12588774wme.2;
        Mon, 13 Jun 2016 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCfsoPk6B6+Cf9EpFbJvMnq7o8/9zb9jHC36zVoElwE=;
        b=qXPKcORg2OPp5csEZbI3S4U9ivAAyljs4swCW7rIYTFg9BMxLb03nB2NnBzExEJh37
         cCD9GiVEFN2uzu0uHBhznpTzRnpwFKHCMD1CxGwRABASOpLwRelttbey63pmAbUhyRhz
         FZPbAJJKlYmDvpboOULXFc0Lp3RdPQ6zSZ2jMpc+E+NUllj37BgpTWp/oQtU9S2CFUK1
         T06E0GcJRMGsz721cgED5aWWDjdFIA08mATXdlaXk7K6xoYUFYtQaLb1Jxr4VBObZw0p
         xjwFx+NL7hAM9JmuE/86+WJ/hAnyjpo/r6v840y+2iZFFg1zLEMejj1CqMGfXKoK9s5A
         VVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCfsoPk6B6+Cf9EpFbJvMnq7o8/9zb9jHC36zVoElwE=;
        b=HhKyItFIcYtJ7KFrvGSHPG2cQ7WbfUXCswBJV7nVA8ge/biWKokKvOYVnhhiHRywlu
         tvitJbACMF5xD8z2lmg5bE1yqKW3jvGESt99MjRpCHODfh4GlCb3ldhywo8DvembQVYU
         /UAysRB1paAlHS5voER1Cy6JiCutERs5+YFgz49D7GxSinSCLk2cwk56yoLWi7cmU5zU
         AUnAxlFL/ryqlyIIEx4wB1ulb/AzQ3SC3M9h3CDFlSv3iicBaRRVJU0sWn++s6DCsywQ
         8nJmt7bNRynBeiyluVo20hwhwQ+8CQXKa2cdAkSXts8afIT83FWzNUuIC9oVe2GecEZc
         EIYA==
X-Gm-Message-State: ALyK8tIAGMgnunqvDCQUtjfLoko9jaegDoakBhmJUMVQsyok2cZAjN0bP9/st+oGQTUabw==
X-Received: by 10.194.172.36 with SMTP id az4mr14712575wjc.114.1465803524968;
        Mon, 13 Jun 2016 00:38:44 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/6] MIPS: BMIPS: Add device tree example for BCM63268
Date:   Mon, 13 Jun 2016 09:38:50 +0200
Message-Id: <1465803534-25840-2-git-send-email-noltari@gmail.com>
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
X-archive-position: 54025
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

This adds a device tree example for Comtrend VR-3032u, which
also serves as a real example for brcm,bcm6328-leds.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/Kconfig                      |   4 +
 arch/mips/boot/dts/brcm/Makefile             |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi        | 134 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm963268vr3032u.dts | 108 +++++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm63268.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm963268vr3032u.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 264328d..14f4b4c 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -21,6 +21,10 @@ config DT_BCM93384WVG_VIPER
 	bool "BCM93384WVG Viper CPU (EXPERIMENTAL)"
 	select BUILTIN_DTB
 
+config DT_BCM963268VR3032U
+        bool "BCM963268VR3032U"
+        select BUILTIN_DTB
+
 config DT_BCM96358NB4SER
 	bool "BCM96358NB4SER"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index fda9d38..2060e70 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
+dtb-$(CONFIG_DT_BCM963268VR3032U)	+= bcm963268vr3032u.dtb
 dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
 dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
 dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
@@ -15,6 +16,7 @@ dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 dtb-$(CONFIG_DT_NONE)			+= \
 						bcm93384wvg.dtb		\
 						bcm93384wvg_viper.dtb	\
+						bcm963268vr3032u.dtb	\
 						bcm96358nb4ser.dtb	\
 						bcm96368mvwg.dtb	\
 						bcm9ejtagprb.dtb	\
diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
new file mode 100644
index 0000000..7e6bf2c
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
@@ -0,0 +1,134 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm63268";
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
+			reg = <0x10000020 0x20>,
+			      <0x10000040 0x20>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		uart0: serial@10000180 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000180 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <5>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@100001a0 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x100001a0 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <34>;
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
+			compatible = "brcm,bcm63268-ehci", "generic-ehci";
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
+			compatible = "brcm,bcm63268-ohci", "generic-ohci";
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
diff --git a/arch/mips/boot/dts/brcm/bcm963268vr3032u.dts b/arch/mips/boot/dts/brcm/bcm963268vr3032u.dts
new file mode 100644
index 0000000..430d35c
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm963268vr3032u.dts
@@ -0,0 +1,108 @@
+/dts-v1/;
+
+/include/ "bcm63268.dtsi"
+
+/ {
+	compatible = "comtrend,vr-3032u", "brcm,bcm63268";
+	model = "Comtrend VR-3032u";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x04000000>;
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
+	brcm,serial-leds;
+	brcm,serial-dat-low;
+	brcm,serial-shift-inv;
+
+	led@0 {
+		reg = <0>;
+		brcm,hardware-controlled;
+		brcm,link-signal-sources = <0>;
+		/* GPHY0 Speed 0 */
+	};
+	led@1 {
+		reg = <1>;
+		brcm,hardware-controlled;
+		brcm,link-signal-sources = <1>;
+		/* GPHY0 Speed 1 */
+	};
+	led@2 {
+		reg = <2>;
+		active-low;
+		label = "vr-3032u:red:inet";
+	};
+	led@3 {
+		reg = <3>;
+		active-low;
+		label = "vr-3032u:green:dsl";
+	};
+	led@4 {
+		reg = <4>;
+		active-low;
+		label = "vr-3032u:green:usb";
+	};
+	led@7 {
+		reg = <7>;
+		active-low;
+		label = "vr-3032u:green:wps";
+	};
+	led@8 {
+		reg = <8>;
+		active-low;
+		label = "vr-3032u:green:inet";
+	};
+	led@9 {
+		reg = <9>;
+		brcm,hardware-controlled;
+		/* EPHY0 Activity */
+	};
+	led@10 {
+		reg = <10>;
+		brcm,hardware-controlled;
+		/* EPHY1 Activity */
+	};
+	led@11 {
+		reg = <11>;
+		brcm,hardware-controlled;
+		/* EPHY2 Activity */
+	};
+	led@12 {
+		reg = <12>;
+		brcm,hardware-controlled;
+		/* GPHY0 Activity */
+	};
+	led@13 {
+		reg = <13>;
+		brcm,hardware-controlled;
+		/* EPHY0 Speed */
+	};
+	led@14 {
+		reg = <14>;
+		brcm,hardware-controlled;
+		/* EPHY1 Speed */
+	};
+	led@15 {
+		reg = <15>;
+		brcm,hardware-controlled;
+		/* EPHY2 Speed */
+	};
+	led@20 {
+		reg = <20>;
+		active-low;
+		label = "vr-3032u:green:power";
+		default-state = "on";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
