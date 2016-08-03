Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 11:59:58 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36259 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993023AbcHCJ6Zsj490 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:25 +0200
Received: by mail-wm0-f65.google.com with SMTP id x83so35403013wma.3;
        Wed, 03 Aug 2016 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxR1eFlnqMqUPJDLtS31gGnAR6qBygu4kW0PeRv2JmE=;
        b=vKD24Rd2cMSsC5vbSyXnCQrRUPM2Oee8q5S8CErD39fStrRNujaUS9r0IZuw+LNFy5
         XAkynBRLCVzG+Nhx/niAh8+PAc0JEI3gb/iv3Tb9c+cRLeZkzYEKsXUvxw7qeV48G3et
         qEAoWSWC0e9u0LCPuJFEanqN5gWTpFU2jD9Z922g4RwgZ8P/hcq5CI77tGeNPS6w9xM2
         dNKKVxp+B2tIshp+KkrAvunQCREnluxwNi41C0VinXFW+Njwy9ok+lW37+KAQcxOFICW
         zHAaaZNJWaP46NOYFCTuZJKn7ZFdTvJi7PIKx8yu3DGvlVtl3JjnNzsTYnVv8xv0gbNC
         46uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxR1eFlnqMqUPJDLtS31gGnAR6qBygu4kW0PeRv2JmE=;
        b=EMgVFtyxPNMZ6BuYIGiJftc6f0cV4Lv1nhdSLuPsC/u1EmuKZlvroPNmyo4/gXBGop
         bqMhXH3f2xEYVMJeH15K/JhGHAsILfqa9NI8bPZnqkxLcYvISjarsSyv/tVSMGtL7siS
         MQJICcxGsFSLY/wRUSY2SWJ4pwjuscs11FNLOm3L8D+kJz+xnEPOeBDvW/PFp3CrVwwj
         orI2YouAyst4wcUo+1tGWTnwyEknI+0XQTL4ENsl/ZGxFC8xdy7VUt5iy9uK0VdGhiHp
         6SgfntsYDYT3Iho6kTVInRPCUYZM1Y/NfVbibmCTVbjDwjuBdi6T4GNKZKSQYbCpS5Ae
         8elA==
X-Gm-Message-State: AEkoousOeJt903GSsZK6d56ddmJjySDFjq6SGB9Wgeez9m1tUJsMmxfbHuMGjHWnwcbszg==
X-Received: by 10.194.67.74 with SMTP id l10mr60291222wjt.145.1470218300463;
        Wed, 03 Aug 2016 02:58:20 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 5/7] MIPS: BMIPS: Add device tree example for BCM3368
Date:   Wed,  3 Aug 2016 11:58:28 +0200
Message-Id: <1470218310-2978-5-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54406
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
 arch/mips/bmips/Kconfig                            |   4 +
 arch/mips/boot/dts/brcm/Makefile                   |   2 +
 .../mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dts |  22 +++++
 arch/mips/boot/dts/brcm/bcm3368.dtsi               | 101 +++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dts
 create mode 100644 arch/mips/boot/dts/brcm/bcm3368.dtsi

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 6a0946c..f499fd2 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -65,6 +65,10 @@ config DT_COMTREND_VR3032U
 	bool "Comtrend VR-3032u"
 	select BUILTIN_DTB
 
+config DT_NETGEAR_CVG834G
+	bool "NETGEAR CVG834G"
+	select BUILTIN_DTB
+
 config DT_SFR_NEUFBOX4_SERCOMM
 	bool "SFR Neufbox 4 (Sercomm)"
 	select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 8281ec6..a698e84 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -11,9 +11,11 @@ dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 dtb-$(CONFIG_DT_COMTREND_VR3032U)	+= bcm63268-comtrend-vr-3032u.dtb
+dtb-$(CONFIG_DT_NETGEAR_CVG834G)	+= bcm3368-netgear-cvg834g.dtb
 dtb-$(CONFIG_DT_SFR_NEUFBOX4_SERCOMM)	+= bcm6358-neufbox4-sercomm.dtb
 
 dtb-$(CONFIG_DT_NONE) += \
+	bcm3368-netgear-cvg834g.dtb \
 	bcm6358-neufbox4-sercomm.dtb \
 	bcm63268-comtrend-vr-3032u.dtb \
 	bcm93384wvg.dtb \
diff --git a/arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dts b/arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dts
new file mode 100644
index 0000000..2f2e80f
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dts
@@ -0,0 +1,22 @@
+/dts-v1/;
+
+/include/ "bcm3368.dtsi"
+
+/ {
+	compatible = "netgear,cvg834g", "brcm,bcm3368";
+	model = "NETGEAR CVG834G";
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
-- 
2.1.4
