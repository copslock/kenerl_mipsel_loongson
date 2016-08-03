Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 12:00:21 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993038AbcHCJ61dL4e0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:27 +0200
Received: by mail-wm0-f67.google.com with SMTP id x83so35403134wma.3;
        Wed, 03 Aug 2016 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYKgmLk34L4WQjJZBAJ0pVsjy9CwGtKQqa3/w1Wj/g4=;
        b=hG0Xz8pkQoXrZX5MWYH6UmD4FM+eiIbDP/BdexV1fctGZFSanyGV+SrJi/Z96+io31
         TTvrLCsfBbGIRwBaSCnczSGKGe48COGV9sI210QUqUbEC/wBUJj3kyyVW5M6n2jUzqmn
         5y954jxulxwIBUTYMlTx0xFxHSo6AYOkvV1Lr5X1hyQC/jr6Xe7phxrThKklV5wJNUkV
         7UqwcXr5VqwKCCdd7PTOhsOMXNWtEoms7vMQ6YF+VxTr+xxScNqMPnbmzF4Y83r/SXxA
         cc2EwZJHaynz1Yb49WUZ3Jj8V1nt8Papn/fVgOsB8RePDHFx2mrMDIEPpCKBZ0tFICUC
         Joow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYKgmLk34L4WQjJZBAJ0pVsjy9CwGtKQqa3/w1Wj/g4=;
        b=NDbKsEn9FCZ3hltrlGPFMcAW1MkSkLYhcmyEtIGHomyEqjjFdJp4eYqOC3nwabEKi1
         flZcyG6+6gztYviQqMhe1qxpWaUEjNe4UGGOa2oAdnNVTHEm8udQqAfOZTMlW5WvCRuQ
         A3vzNhE3N7LZK+BBq4XPCIkNnBCjZ8g5j32rI9Cyqt6gMc0+BetRrwLlrzrXh4+qbUC7
         DzIagFpM5KwRFNjJZiJHjJrqHNSj3d0QsgrIFcw2jcY1zFiAhueGqLf4wUblFBQOD+9G
         8EI8rOLjpjhUk5dYHn804rrr8NAqtevasRt7WMbP7r1IF2V8TZsCo/hJ0ytziKEaRpTg
         4jCg==
X-Gm-Message-State: AEkoouvio0F/p9/yTUha960DOFWd5RpeW85kc3G1mDXSf2IfIYmUgdbJjn8hsdRSv85YLQ==
X-Received: by 10.28.168.150 with SMTP id r144mr62297646wme.66.1470218302182;
        Wed, 03 Aug 2016 02:58:22 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 7/7] MIPS: BMIPS: Add device tree example for BCM6362
Date:   Wed,  3 Aug 2016 11:58:30 +0200
Message-Id: <1470218310-2978-7-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54407
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
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 .../boot/dts/brcm/bcm6362-neufbox6-sercomm.dts     |  22 ++++
 arch/mips/boot/dts/brcm/bcm6362.dtsi               | 134 +++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm6362.dtsi

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index f499fd2..2d60f25 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -73,6 +73,10 @@ config DT_SFR_NEUFBOX4_SERCOMM
 	bool "SFR Neufbox 4 (Sercomm)"
 	select BUILTIN_DTB
 
+config DT_SFR_NEUFBOX6_SERCOMM
+	bool "SFR Neufbox 6 (Sercomm)"
+	select BUILTIN_DTB
+
 endchoice
 
 endif
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index a698e84..d61bc2a 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -13,10 +13,12 @@ dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 dtb-$(CONFIG_DT_COMTREND_VR3032U)	+= bcm63268-comtrend-vr-3032u.dtb
 dtb-$(CONFIG_DT_NETGEAR_CVG834G)	+= bcm3368-netgear-cvg834g.dtb
 dtb-$(CONFIG_DT_SFR_NEUFBOX4_SERCOMM)	+= bcm6358-neufbox4-sercomm.dtb
+dtb-$(CONFIG_DT_SFR_NEUFBOX6_SERCOMM)	+= bcm6362-neufbox6-sercomm.dtb
 
 dtb-$(CONFIG_DT_NONE) += \
 	bcm3368-netgear-cvg834g.dtb \
 	bcm6358-neufbox4-sercomm.dtb \
+	bcm6362-neufbox6-sercomm.dtb \
 	bcm63268-comtrend-vr-3032u.dtb \
 	bcm93384wvg.dtb \
 	bcm93384wvg_viper.dtb \
diff --git a/arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dts b/arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dts
new file mode 100644
index 0000000..480f2a5
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dts
@@ -0,0 +1,22 @@
+/dts-v1/;
+
+/include/ "bcm6362.dtsi"
+
+/ {
+	compatible = "sfr,nb6-ser", "brcm,bcm6362";
+	model = "SFR NeufBox 6 (Sercomm)";
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
-- 
2.1.4
