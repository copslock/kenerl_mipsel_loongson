Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 04:10:37 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35680 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990507AbcHLCJxxpyNx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 04:09:53 +0200
Received: by mail-pa0-f67.google.com with SMTP id cf3so630156pad.2;
        Thu, 11 Aug 2016 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VlGtJbxhNOAv6rm9j3MOQ5GRzFnjRcvfO9NBdTmIsPM=;
        b=j2dYFJx9G/VSDL0xm1U84cyFcghAUmqIXpD/W18Ob9UpXJwDeTMbKHnmmFIHtao5ND
         WLRw9iwCnO81GcKL0Vn2gacuYg0KwDsarXrywndXtISmEX5H1yh9Jj5z50dm0FNRH4H+
         BskxlLDHlG1Z5IXObS9jMZb5fd6iBDbS7625QceBxatsY5R0wkjoDOTPpOkftYBkOqYb
         Ky92GZBB5E3VU5DLj8lPFHXpKUCpyDXJLxSRF3ZW0PQJ9gb20Apl5tIuN3qbc0cNZJOh
         9B0fdAGrG9uomZgY1HvuQq8WcU5DwRSW5ej9CZIO61yt3aJaortVI7eBiHnevURC5n82
         vi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VlGtJbxhNOAv6rm9j3MOQ5GRzFnjRcvfO9NBdTmIsPM=;
        b=SbHYSOsep2MC1s6jmpY+eh73bG3RT2hOAMqgvGxkBGYRxvIbkEK9AHB9IDSah6zAzl
         COtW/ZfcQkw12NwPOnKm8T0UfoH32/1U6AZ6VUtkBs8SGjiD7RnaQZE5UKBzBkYTxndy
         H8O+jaT2iLUjPEqzpvVDrsjQri7XftXsgK/I06wdNp/lD9piAwLHdkhQmlETM1iLQpdb
         6ixdolO95vRqNueY/i2k1sNLKssct8XnfXE8/Jd9qWkZwXWshNpSBIvGLEmXJUaDvLrw
         ChaAeouK+D1CF7bhInmHB3tmPCeo6RKKvdlYFLLtXs9PYQidP6OfMk/npZRfC3/oJ8e+
         1SaA==
X-Gm-Message-State: AEkoouvY+bi6JptegPSK/2AWULDDRQIUHeAq/xmxi2ReZAs62n5HP+46Me7R2lDtJgcxHQ==
X-Received: by 10.66.193.65 with SMTP id hm1mr23251803pac.12.1470967787629;
        Thu, 11 Aug 2016 19:09:47 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ao6sm8209846pac.8.2016.08.11.19.09.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 19:09:47 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 2/5] MIPS: BMIPS: Add support GPIO device nodes
Date:   Fri, 12 Aug 2016 11:09:20 +0900
Message-Id: <20160812020923.3299-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812020923.3299-1-jaedon.shin@gmail.com>
References: <20160812020923.3299-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54487
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

Adds GPIO device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi | 12 ++++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi | 12 ++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 37 ++++++++++++++++++++++++++++++++++++
 8 files changed, 246 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 97191f6bca28..746ed06c85de 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -197,6 +197,18 @@
 			status = "disabled";
 		};
 
+		upg_gio: gpio@406700 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406700 0x80>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 18>;
+		};
+
 		ehci0: usb@488300 {
 			compatible = "brcm,bcm7125-ehci", "generic-ehci";
 			reg = <0x488300 0x100>;
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index eb7b19a32e3e..1ef7540238be 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -232,6 +232,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <52>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406700 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406700 0x60>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 16>;
+		};
+
+		upg_gio_aon: gpio@408c00 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x408c00 0x60>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <27 32 2>;
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index b2276b1e12d4..bb099ee046a1 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -216,6 +216,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408240 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408240 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <49>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406500 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406500 0xa0>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 29 4>;
+		};
+
+		upg_gio_aon: gpio@408c00 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x408c00 0x60>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <21 32 2>;
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index e414af1e14ff..0aeb3de7fbc2 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -208,6 +208,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <49>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406500 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406500 0xa0>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 29 4>;
+		};
+
+		upg_gio_aon: gpio@408c00 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x408c00 0x60>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <21 32 2>;
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 3bd1c0111d43..9a1f6ffc343d 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -204,6 +204,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <49>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406500 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406500 0xa0>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 29 4>;
+		};
+
+		upg_gio_aon: gpio@408c00 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x408c00 0x60>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <21 32 2>;
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 27c3d45556b9..0d391d77c780 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -213,6 +213,18 @@
 			status = "disabled";
 		};
 
+		upg_gio: gpio@406700 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406700 0x80>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 27>;
+		};
+
 		enet0: ethernet@468000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 9ab65d64e948..04306a92b8eb 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -231,6 +231,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406700 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406700 0x80>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 21>;
+		};
+
+		upg_gio_aon: gpio@4094c0 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x4094c0 0x40>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <18 4>;
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 7801169416e7..c4883643ab61 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -246,6 +246,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <53>;
+			brcm,irq-can-wake;
+		};
+
+		upg_gio: gpio@406700 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x406700 0x80>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupts = <6>;
+			brcm,gpio-bank-widths = <32 32 32 21>;
+		};
+
+		upg_gio_aon: gpio@4094c0 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x4094c0 0x40>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupts = <6>;
+			interrupts-extended = <&upg_aon_irq0_intc 6>,
+					      <&aon_pm_l2_intc 5>;
+			wakeup-source;
+			brcm,gpio-bank-widths = <18 4>;
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
-- 
2.9.2
