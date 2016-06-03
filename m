Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 10:12:45 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041872AbcFCIMCniXzm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 10:12:02 +0200
Received: by mail-wm0-f66.google.com with SMTP id n184so21129353wmn.1;
        Fri, 03 Jun 2016 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3lkYpl0k7MA/FLnwODN6zdLs6SHBUKylxGpGQ4JcJ8=;
        b=m1IZcKD/6rKgTDDt8hf2UH7Sh36isuqujj4CEuUfrZbVLuVIkcC722jF7ZwejztRkT
         NzlwejUgK4QENduQNEzAGGtQR30NSvnYETrDKgdSr0Ii0EWlLDrEYtChFmYsT3DDA/vI
         0JoataGPdYHXoZRDOkyMAahnUlj/mytQasgh1jgV6HSpV1MAeCzYF3YEOB3sMmI5+JwA
         lte0NptAVLNDCWuARk3MN6/248flGmmwxrAbl7oT7uStLoha64KI6IFqJQxpVQJ1NqcG
         apADAdDuaX7YoTR6pHA9O7Gt6RyRK2kzFxu5Dld/hznl2IwMlAltrsDw96H2k1MqTH+u
         jdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3lkYpl0k7MA/FLnwODN6zdLs6SHBUKylxGpGQ4JcJ8=;
        b=lILrHZACdzvz7lLyZaIRstZT68H5grfw+YmCYXd1cyJ9AFGNmWjMCQ1YH7q/EnQdNr
         f3+qxNdwxP8eEBIrk9MW00e5iSWY0MzlpoHnc+t+5SM/u8tNiLp5y+/Qu7dbsRw03hxm
         SVjmtGnf24EQ5IwR8CgE2Of8GtCRMIHOf70pkq9HtVIcxsWmg2poeKSejGuTDuoGPTsI
         rQEwEw1HGq0y4gueg104yQecvxbL2uLY72JXKVObZl8YK+rCLSlz5+xUxLALIJ57PS2q
         ZvO1WkKPzhWzfF9iCgPxetDQqsL0EM//hU/lu5cbG8clrNSW9Dwwix5P1iajZW6tYWQf
         EYUA==
X-Gm-Message-State: ALyK8tLhmh6qqAjVZ7/OES56d8zbzB0cPwqilXC/20W6KgHH7GOoXPttUQEvWdvBj5xu8Q==
X-Received: by 10.28.91.145 with SMTP id p139mr2755873wmb.50.1464941517414;
        Fri, 03 Jun 2016 01:11:57 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id x124sm5078158wmg.24.2016.06.03.01.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 01:11:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/3] MIPS: BMIPS: Add device tree example for BCM6345
Date:   Fri,  3 Jun 2016 10:12:04 +0200
Message-Id: <1464941524-3992-3-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1464941524-3992-1-git-send-email-noltari@gmail.com>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53778
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

This adds a device tree example for generic BCM96345GW2.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/Kconfig                 |  4 ++
 arch/mips/boot/dts/brcm/Makefile        |  2 +
 arch/mips/boot/dts/brcm/bcm6345.dtsi    | 94 +++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96345GW2.dts | 21 ++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm6345.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm96345GW2.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 14f4b4c..b2426eb 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -25,6 +25,10 @@ config DT_BCM963268VR3032U
         bool "BCM963268VR3032U"
         select BUILTIN_DTB
 
+config DT_BCM96345GW2
+        bool "BCM96345GW2"
+        select BUILTIN_DTB
+
 config DT_BCM96358NB4SER
 	bool "BCM96358NB4SER"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 2060e70..fe1f189 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,6 +1,7 @@
 dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
 dtb-$(CONFIG_DT_BCM963268VR3032U)	+= bcm963268vr3032u.dtb
+dtb-$(CONFIG_DT_BCM96345GW2)		+= bcm96345gw2.dtb
 dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
 dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
 dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
@@ -17,6 +18,7 @@ dtb-$(CONFIG_DT_NONE)			+= \
 						bcm93384wvg.dtb		\
 						bcm93384wvg_viper.dtb	\
 						bcm963268vr3032u.dtb	\
+						bcm96345gw2.dtb		\
 						bcm96358nb4ser.dtb	\
 						bcm96368mvwg.dtb	\
 						bcm9ejtagprb.dtb	\
diff --git a/arch/mips/boot/dts/brcm/bcm6345.dtsi b/arch/mips/boot/dts/brcm/bcm6345.dtsi
new file mode 100644
index 0000000..49b6439
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6345.dtsi
@@ -0,0 +1,94 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6345";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <70000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips3300";
+			device_type = "cpu";
+			reg = <0>;
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
+			reg = <0xfffe000c 0x8>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@fffe0300 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0xfffe0300 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		ohci: usb@fffe2100 {
+			compatible = "brcm,bcm6345-ohci", "generic-ohci";
+			reg = <0xfffe2100 0x100>;
+			big-endian;
+			no-big-frame-no;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <5>;
+
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96345GW2.dts b/arch/mips/boot/dts/brcm/bcm96345GW2.dts
new file mode 100644
index 0000000..91271f3
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm96345GW2.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+/include/ "bcm6345.dtsi"
+
+/ {
+	compatible = "brcm,bcm96345gw2", "brcm,bcm6345";
+	model = "Broadcom BCM96345GW2";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x01000000>;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
