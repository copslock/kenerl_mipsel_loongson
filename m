Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 08:59:59 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33607 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026169AbcDFG75OOnNQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 08:59:57 +0200
Received: by mail-pf0-f194.google.com with SMTP id e190so3433058pfe.0;
        Tue, 05 Apr 2016 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PkvxneDEOjUpcTuG3tjkQglOA3cHsnZD0YLOOmXvN04=;
        b=DUK/3UPDan1v0KpbOCUehjCi71AR4unIUcbIlAPsPhn4Z3Uj+TCsS2V8/5FJzn43ye
         uikX9s249fv8i72ajOKZr4cySfebrilUqKtOpPovif6n1SlKsIU0tm/TDVnhWNp2Qw3P
         G7y+LrvxlLxV+LLl+b1zPvquoR+flPuGwTM46kbeqn1jP+kdw8AKzZNEdml3GjYXpwqQ
         qd7jCS0rdcoLYO3S0nR7x3xOftuSKt3fGX6TZS65IzAHc/qb4ojaqsECUuwe2YFOXyGr
         4lTORkd/EFzGc5wJXvNZsyO/QjKxGjAgYFsXrheeclS9Pvhnx0m/9eR+tZ6TGZQDktpI
         i26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PkvxneDEOjUpcTuG3tjkQglOA3cHsnZD0YLOOmXvN04=;
        b=ZQ++Yczw5uZUsYIiuGJIhdOJuR3M1Qrqphb8ShPtRwYvNvdt+APu2FajYFGJmqfnPd
         MwK/nOU284GygUuWnbR5zfnqtXPWOtWkr8Bn8NulzhvtV+Vq2T7oDjokwv/ZH447t7iC
         vWjBMcFFRu4zGdTXT5DxPd7v8GXlLbIN/G5OlX7oBxVLFNzTW6U84zfBa6Y4pYZ4T/B4
         gfKo31LSq7ibRov7krFbsLhn2d/vEoDl9aaAhKEQF5sn1Uzx8E/7gPHk+0JlDqg/n5pG
         8HqLsc32+4DkMgHJr5dPUAuqYMobaXODQntBlnorTtxfyNb4BQZkUTdU5c74IXkid/dq
         brKg==
X-Gm-Message-State: AD7BkJIzskbiPhto2SxUqwZnUbUOXP6bQa0DTx/c7s3FQw1KHNAXCso34G9GOcemFdXrDw==
X-Received: by 10.98.72.149 with SMTP id q21mr67204605pfi.148.1459922479791;
        Tue, 05 Apr 2016 23:01:19 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id u64sm1672167pfa.86.2016.04.05.23.01.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 23:01:19 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Add support UART, I2C, SATA device
Date:   Wed,  6 Apr 2016 15:01:08 +0900
Message-Id: <1459922468-11371-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.8.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Add UART, I2C, SATA device tree nodes on Broadcom BCM7xxx MIPS-based
platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi     |  69 +++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7346.dtsi     |   2 -
 arch/mips/boot/dts/brcm/bcm7358.dtsi     |   2 -
 arch/mips/boot/dts/brcm/bcm7360.dtsi     |  42 +++++++++-
 arch/mips/boot/dts/brcm/bcm7362.dtsi     |   2 -
 arch/mips/boot/dts/brcm/bcm7420.dtsi     |  77 +++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7425.dtsi     |  94 +++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 134 ++++++++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts |  24 ++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts |   8 ++
 arch/mips/boot/dts/brcm/bcm97420c.dts    |  28 +++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  28 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  36 +++++++++
 13 files changed, 530 insertions(+), 16 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 3ae16053a0c9..550e1d9e3ee0 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -85,14 +85,15 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0xf000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <18>;
+			interrupts = <18>, <19>;
+			interrupt-names = "upg_main", "upg_bsc";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -118,6 +119,70 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <64>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		bsca: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscc: i2c@406300 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406300 0x58>;
+		      interrupts = <26>;
+		      interrupt-names = "upg_bscc";
+		      status = "disabled";
+		};
+
+		bscd: i2c@406380 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406380 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
 		ehci0: usb@488300 {
 			compatible = "brcm,bcm7125-ehci", "generic-ehci";
 			reg = <0x488300 0x100>;
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 7ae7b3e6e0f8..ec959061d52e 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -24,8 +24,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 060805be619a..ca57fb5eb122 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -18,8 +18,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index bcdb09bfe07b..1c0c3d438c7a 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -18,8 +18,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
@@ -241,5 +239,45 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <86>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@180100 {
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 8177676d497a..6b4713add4b8 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -24,8 +24,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 3302a1b8a5c9..0586bf662571 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -86,14 +86,15 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0x1f000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <18>;
+			interrupts = <18>, <19>;
+			interrupt-names = "upg_main", "upg_bsc";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -118,6 +119,78 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <64>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		bsca: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscc: i2c@406300 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406300 0x58>;
+		      interrupts = <26>;
+		      interrupt-names = "upg_bscc";
+		      status = "disabled";
+		};
+
+		bscd: i2c@406380 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406380 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
+		bsce: i2c@406800 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406800 0x58>;
+		      interrupts = <28>;
+		      interrupt-names = "upg_bsce";
+		      status = "disabled";
+		};
+
 		enet0: ethernet@468000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 8214d45bad46..c1c15edaf829 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -87,14 +87,32 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <55>;
+			interrupts = <55>, <53>;
+			interrupt-names = "upg_main", "upg_bsc";
+		};
+
+		upg_aon_irq0_intc: upg_aon_irq0_intc@409480 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x409480 0x8>;
+
+			brcm,int-map-mask = <0x40>, <0x18000000>, <0x100000>;
+			brcm,int-fwd-mask = <0>;
+			brcm,irq-can-wake;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <56>, <54>, <59>;
+			interrupt-names = "upg_main_aon", "upg_bsc_aon",
+					  "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -119,6 +137,78 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <63>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		bsca: i2c@409180 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x409180 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@409400 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x409400 0x58>;
+		      interrupts = <28>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscc: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bscc";
+		      status = "disabled";
+		};
+
+		bscd: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
+		bsce: i2c@406300 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406300 0x58>;
+		      interrupts = <26>;
+		      interrupt-names = "upg_bsce";
+		      status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 56035e5b7008..7d6ab1f93f0b 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -101,14 +101,32 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <60>;
+			interrupts = <60>, <58>;
+			interrupt-names = "upg_main", "upg_bsc";
+		};
+
+		upg_aon_irq0_intc: upg_aon_irq0_intc@409480 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x409480 0x8>;
+
+			brcm,int-map-mask = <0x40>, <0x18000000>, <0x100000>;
+			brcm,int-fwd-mask = <0>;
+			brcm,irq-can-wake;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <61>, <59>, <64>;
+			interrupt-names = "upg_main_aon", "upg_bsc_aon",
+					  "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -133,6 +151,78 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <67>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <68>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		bsca: i2c@406300 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406300 0x58>;
+		      interrupts = <26>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@409400 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x409400 0x58>;
+		      interrupts = <28>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscc: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bscc";
+		      status = "disabled";
+		};
+
+		bscd: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
+		bsce: i2c@409180 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x409180 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bsce";
+		      status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
@@ -235,5 +325,45 @@
 			interrupts = <78>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <45>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@180100 {
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index e046b1109eab..f2449d147c6d 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -21,6 +21,30 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscc {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
 /* FIXME: USB is wonky; disable it for now */
 &ehci0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index d48462e091f1..73124be9548a 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -56,3 +56,11 @@
 &ohci0 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index 67fe1f3a3891..600d57abee05 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -23,6 +23,34 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscc {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
+&bsce {
+	status = "okay";
+};
+
 /* FIXME: MAC driver comes up but cannot attach to PHY */
 &enet0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 689c68a4f9c8..119c714805cb 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -23,6 +23,34 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscc {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
+&bsce {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 1df088183523..13553ab2d0fd 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -23,6 +23,34 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscc {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
+&bsce {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
@@ -58,3 +86,11 @@
 &ohci3 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.8.0
