Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 03:11:35 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32826 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026407AbbEEBLTX6z0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 03:11:19 +0200
Received: by pacwv17 with SMTP id wv17so176141173pac.0;
        Mon, 04 May 2015 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2uoQ4D6kWGqL+3l9BNLveqS26VwLRRXxhBR9WAXNbA=;
        b=0G2A/gSMN+WWjAY82VvnJHSyrHCsNxRC1RUP3U34nCQ7E4GpmNMAGDTY5VD/SsWu2B
         Woeqn3ASXmP2MNa0kAdDzxHry96DcOdB2EwKzRYa0sfCNJQDz4pYrztaRRpLdMUnwyEo
         63Tu85gZvJ+t/GNr/oBXYesF7mAo35eaBfxUMa7NXimTDv235nO4NVwRwZCUu8Qm0IjK
         6wTgM5+b6FgycnGGZC5qUp6sun2JVk0sCXMpyMSw38pRpjyYgrdAiTUgtN83+m4PBMpH
         fvmlD5CVzlRaCL/UKVIkl0TwSq/RkjSYK441qivyNsBhsWChlowqRLeKDqErqfuejB4n
         yjCA==
X-Received: by 10.66.232.104 with SMTP id tn8mr46139774pac.73.1430788274419;
        Mon, 04 May 2015 18:11:14 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id nt15sm14030698pdb.14.2015.05.04.18.11.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 18:11:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        Steven.Hill@imgtec.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: add BCM7435 dtsi
Date:   Mon,  4 May 2015 18:10:56 -0700
Message-Id: <1430788257-10244-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1430788257-10244-1-git-send-email-f.fainelli@gmail.com>
References: <1430788257-10244-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Add the bare minimum required to boot a BCM7435-based system:

- BMIPS5200 CPU nodes
- Level 1 and 2 interrupt controllers
- UARTs
- EHCI/OHCI controllers

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 239 +++++++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm7435.dtsi

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
new file mode 100644
index 000000000000..8b9432cc062b
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -0,0 +1,239 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm7435";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <163125000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5200";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5200";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+		cpu@2 {
+			compatible = "brcm,bmips5200";
+			device_type = "cpu";
+			reg = <2>;
+		};
+
+		cpu@3 {
+			compatible = "brcm,bmips5200";
+			device_type = "cpu";
+			reg = <3>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
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
+	clocks {
+		uart_clk: uart_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <81000000>;
+		};
+	};
+
+	rdb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges = <0 0x10000000 0x01000000>;
+
+		periph_intc: periph_intc@41b500 {
+			compatible = "brcm,bcm7038-l1-intc";
+			reg = <0x41b500 0x40>, <0x41b600 0x40>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>, <3>;
+		};
+
+		sun_l2_intc: sun_l2_intc@403000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x403000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <52>;
+		};
+
+		gisb-arb@400000 {
+			compatible = "brcm,bcm7400-gisb-arb";
+			reg = <0x400000 0xdc>;
+			native-endian;
+			interrupt-parent = <&sun_l2_intc>;
+			interrupts = <0>, <2>;
+			brcm,gisb-arb-master-mask = <0xf77f>;
+			brcm,gisb-arb-master-names = "ssp_0", "cpu_0", "webcpu_0",
+						     "pcie_0", "bsp_0",
+						     "rdc_0", "raaga_0",
+						     "avd_1", "jtag_0",
+						     "svd_0", "vice_0",
+						     "vice_1", "raaga_1",
+						     "scpu";
+		};
+
+		upg_irq0_intc: upg_irq0_intc@406780 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x406780 0x8>;
+
+			brcm,int-map-mask = <0x44>;
+			brcm,int-fwd-mask = <0x70000>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <60>;
+		};
+
+		sun_top_ctrl: syscon@404000 {
+			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
+			reg = <0x404000 0x51c>;
+			little-endian;
+		};
+
+		reboot {
+			compatible = "brcm,brcmstb-reboot";
+			syscon = <&sun_top_ctrl 0x304 0x308>;
+		};
+
+		uart0: serial@406b00 {
+			compatible = "ns16550a";
+			reg = <0x406b00 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		enet0: ethernet@b80000 {
+			phy-mode = "internal";
+			phy-handle = <&phy1>;
+			mac-address = [ 00 10 18 36 23 1a ];
+			compatible = "brcm,genet-v3";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			reg = <0xb80000 0x11c88>;
+			interrupts = <17>, <18>;
+			interrupt-parent = <&periph_intc>;
+			status = "disabled";
+
+			mdio@e14 {
+				compatible = "brcm,genet-mdio-v3";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				reg = <0xe14 0x8>;
+
+				phy1: ethernet-phy@1 {
+					max-speed = <100>;
+					reg = <0x1>;
+					compatible = "brcm,40nm-ephy",
+						"ethernet-phy-ieee802.3-c22";
+				};
+			};
+		};
+
+		ehci0: usb@480300 {
+			compatible = "brcm,bcm7435-ehci", "generic-ehci";
+			reg = <0x480300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <70>;
+			status = "disabled";
+		};
+
+		ohci0: usb@480400 {
+			compatible = "brcm,bcm7435-ohci", "generic-ohci";
+			reg = <0x480400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <72>;
+			status = "disabled";
+		};
+
+		ehci1: usb@480500 {
+			compatible = "brcm,bcm7435-ehci", "generic-ehci";
+			reg = <0x480500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <71>;
+			status = "disabled";
+		};
+
+		ohci1: usb@480600 {
+			compatible = "brcm,bcm7435-ohci", "generic-ohci";
+			reg = <0x480600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <73>;
+			status = "disabled";
+		};
+
+		ehci2: usb@490300 {
+			compatible = "brcm,bcm7435-ehci", "generic-ehci";
+			reg = <0x490300 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <75>;
+			status = "disabled";
+		};
+
+		ohci2: usb@490400 {
+			compatible = "brcm,bcm7435-ohci", "generic-ohci";
+			reg = <0x490400 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <77>;
+			status = "disabled";
+		};
+
+		ehci3: usb@490500 {
+			compatible = "brcm,bcm7435-ehci", "generic-ehci";
+			reg = <0x490500 0x100>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <76>;
+			status = "disabled";
+		};
+
+		ohci3: usb@490600 {
+			compatible = "brcm,bcm7435-ohci", "generic-ohci";
+			reg = <0x490600 0x100>;
+			native-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <78>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.1.0
