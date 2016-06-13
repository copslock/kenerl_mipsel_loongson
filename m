Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:39:46 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042089AbcFMHiv5HQ8C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:51 +0200
Received: by mail-wm0-f68.google.com with SMTP id m124so12562874wme.3;
        Mon, 13 Jun 2016 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tz4mZRzLHBOc9FOF9wkCVg55wbZedAWSxanCntXWURY=;
        b=Rg1CmBG5TwxjJxrDORUdXAfjkMcug+moEdFl1K2Or8ZShC3qRW6/nIWNn+ACZUSSO7
         n1uBLfScT4bV8XLZHsuUXsUq02nOnX1ZB0HGvRYsnvT8zbTpK4kLCAgKWlDT1lxqtkd0
         AR3PS7PTAzk1NhqMxlKXjQCRmjB/kdH75HnB9jkWk1XZpvjMnnEb8ozADLpSEtGREuZm
         IrIMeKFSMKPY9qBodHrFcK3h9aMW0HYUyd+4mt02EJZqrYfMHmC0kvwklAOhNtNvTLR1
         nt/8Gyy2PWP6+2ua7KmtLeaQzrYw19jhg98WaemJt6XpYHSJ39FxeHLLyeu5zPeKwE6y
         Bnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tz4mZRzLHBOc9FOF9wkCVg55wbZedAWSxanCntXWURY=;
        b=kqAM2C8iQyxYMrsSXgqqG5eFKgY5wY2rvY5mBRi+rS52j4xUAFvdEvBm3AvwMB1fvX
         Sd6N6zJ32bz0olnqTUtnBilMeMJwCU2HozLfBxaEGOT4gMj8WvG5xFuQRYLXhSaW3YXD
         nlzfVkmYnF58AAXk54HMkQeIfbVYI2Zv4wvVvpWM0rfHLHihFFvON2klZE1DjNcht+fs
         /VBBnIfkhPDhDoMtOkxu1e5GsUskqQysyeDzKiMcBYVX6wPVRdnXPUiCmgmO/vspnrzE
         K0DjkezE5wrNlRoNeYzmsGkeZNqOh7ALAp/sSrybG0FA5C0rFXuJCI90jjzwQICaUrOU
         61pw==
X-Gm-Message-State: ALyK8tIkiHAcJ3PNZ8PXK0Q7ZNHl9x4bErjGV/WFD67BheOZ87KdqkB5Rl+DenzK2pjdiA==
X-Received: by 10.28.158.17 with SMTP id h17mr10714773wme.1.1465803526676;
        Mon, 13 Jun 2016 00:38:46 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 4/6] MIPS: BMIPS: Add device tree example for BCM3368
Date:   Mon, 13 Jun 2016 09:38:52 +0200
Message-Id: <1465803534-25840-4-git-send-email-noltari@gmail.com>
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
X-archive-position: 54027
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

This adds a device tree example for Netgear CVG834G.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/Kconfig                     |   4 ++
 arch/mips/boot/dts/brcm/Makefile            |   2 +
 arch/mips/boot/dts/brcm/bcm3368.dtsi        | 101 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm93368cvg834g.dts |  22 ++++++
 4 files changed, 129 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm3368.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm93368cvg834g.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 14f4b4c..5b0ad8c 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -13,6 +13,10 @@ choice
 config DT_NONE
 	bool "None"
 
+config DT_BCM93368CVG834G
+	bool "BCM93368CVG834G"
+	select BUILTIN_DTB
+
 config DT_BCM93384WVG
 	bool "BCM93384WVG Zephyr CPU"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 2060e70..c553b95 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_DT_BCM93368CVG834G)	+= bcm93368cvg834g.dtb
 dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
 dtb-$(CONFIG_DT_BCM963268VR3032U)	+= bcm963268vr3032u.dtb
@@ -14,6 +15,7 @@ dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 
 dtb-$(CONFIG_DT_NONE)			+= \
+						bcm93368cvg834g.dtb	\
 						bcm93384wvg.dtb		\
 						bcm93384wvg_viper.dtb	\
 						bcm963268vr3032u.dtb	\
diff --git a/arch/mips/boot/dts/brcm/bcm3368.dtsi b/arch/mips/boot/dts/brcm/bcm3368.dtsi
new file mode 100644
index 0000000..bee855c
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm3368.dtsi
@@ -0,0 +1,101 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm3368";
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
+		periph_cntl: syscon@fff8c000 {
+			compatible = "syscon";
+			reg = <0xfff8c000 0xc>;
+			native-endian;
+		};
+
+		reboot: syscon-reboot@fff8c008 {
+			compatible = "syscon-reboot";
+			regmap = <&periph_cntl>;
+			offset = <0x8>;
+			mask = <0x1>;
+		};
+
+		periph_intc: interrupt-controller@fff8c00c {
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0xfff8c00c 0x8>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@fff8c100 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0xfff8c100 0x18>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+
+			clocks = <&periph_clk>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@fff8c120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0xfff8c120 0x18>;
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
diff --git a/arch/mips/boot/dts/brcm/bcm93368cvg834g.dts b/arch/mips/boot/dts/brcm/bcm93368cvg834g.dts
new file mode 100644
index 0000000..68475c4
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm93368cvg834g.dts
@@ -0,0 +1,22 @@
+/dts-v1/;
+
+/include/ "bcm3368.dtsi"
+
+/ {
+	compatible = "netgear,cvg834g", "brcm,bcm3368";
+	model = "Netgear CVG834G";
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
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
