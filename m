Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 11:59:37 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992897AbcHCJ6YhW6Y0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:24 +0200
Received: by mail-wm0-f66.google.com with SMTP id o80so35422935wme.0;
        Wed, 03 Aug 2016 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9d1OoW1NDMResMUO/q+Mg5w+Xry6CplJddohsi3t/g=;
        b=eWMowQCDYT/JbAnKWnoFXS6eB04lN9lnqlRsPDK6sbpXQMONFfLAL60mcKvnsLQutI
         oFk9T9hnyiMo4r5J5aRRtxvQVV6NXPYQw4N8JPO01MHD95LUGe1pmT46W0YxpNTRf7CD
         kZkS4LW3Sd6TFXq2iUCX8AnRUT7ZLvSa+ZWquBlw7aktiKujNTH9bIUJ0cThiuu1I5Vf
         +XOIeC9oGbtxfBCbcirFi1CLIhouD/CuyFjIY4LIZe/rBt2tr9CoMHBxsuG5yuNCurl8
         zdVALR6p09eGERxV2zdraAOCK4uWi4et9Lj1xfPR5YkRrDdWErd+dhe+hnhDDzBE/0/c
         CwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9d1OoW1NDMResMUO/q+Mg5w+Xry6CplJddohsi3t/g=;
        b=fodZ3Yhnj11tklffpobI2GYSafKTpw5cCn8Fm6Vx/hSEYYv84NRJaHaP4/LOmh4xyK
         4I41wVjQ+a8GtaHd5yt/50Ty6011zIp8/4HZ21q9PqXA6ukS0BQY58D8jJNwYzFaDRx7
         vagtFqMr2RJk7J8qv1JgTei98iNJwgpPvQNGmaS2e2qp1rZa2c+4JQ8rz3SdBZHLWBtH
         7a26Ld+eBOXxCyXqwJIGXuCwzma2k3yeTLc+vssQ/HfdWjvzKblInBfQoyVX6a3qyMzI
         iSDc+T0x50P8bNR5x3RjXJ2IXKwYykgCHlAPQK6+muRcRCrVPTIlhtism3ZEdr1T5/gt
         qvEA==
X-Gm-Message-State: AEkoousn0P+JBRVxxKZBQXy5eYUvkbjbQkmQ1+stmFOqyEi7N/n4YkblI1ilbPubOuc8xg==
X-Received: by 10.194.29.2 with SMTP id f2mr59133118wjh.161.1470218298716;
        Wed, 03 Aug 2016 02:58:18 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 3/7] MIPS: BMIPS: Add device tree example for BCM63268
Date:   Wed,  3 Aug 2016 11:58:26 +0200
Message-Id: <1470218310-2978-3-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54405
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
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 .../boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts   | 108 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm63268.dtsi              | 134 +++++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm63268.dtsi

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index c8f1427..6a0946c 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -61,6 +61,10 @@ config DT_BCM97435SVMB
 	bool "BCM97435SVMB"
 	select BUILTIN_DTB
 
+config DT_COMTREND_VR3032U
+	bool "Comtrend VR-3032u"
+	select BUILTIN_DTB
+
 config DT_SFR_NEUFBOX4_SERCOMM
 	bool "SFR Neufbox 4 (Sercomm)"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 0abe298..8281ec6 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -10,10 +10,12 @@ dtb-$(CONFIG_DT_BCM97362SVMB)		+= bcm97362svmb.dtb
 dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
+dtb-$(CONFIG_DT_COMTREND_VR3032U)	+= bcm63268-comtrend-vr-3032u.dtb
 dtb-$(CONFIG_DT_SFR_NEUFBOX4_SERCOMM)	+= bcm6358-neufbox4-sercomm.dtb
 
 dtb-$(CONFIG_DT_NONE) += \
 	bcm6358-neufbox4-sercomm.dtb \
+	bcm63268-comtrend-vr-3032u.dtb \
 	bcm93384wvg.dtb \
 	bcm93384wvg_viper.dtb \
 	bcm96358nb4ser.dtb \
diff --git a/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts b/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
new file mode 100644
index 0000000..430d35c
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts
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
-- 
2.1.4
