Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 04:53:40 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33912 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbcHSCwxfwjRi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 04:52:53 +0200
Received: by mail-pa0-f66.google.com with SMTP id hh10so2692866pac.1;
        Thu, 18 Aug 2016 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fE48bxTCj7r7V5VDAPsC8j4ZhQ94Cn7/3g3JrlrM/o0=;
        b=JXOhTl+dcawTWd1T3yJjiDU4cGL9U/aWM4o9WlW6lt4UaPxI55utsIUAoV8E6qsxSs
         shEx+0BTnp3TVTTYqhNvH1VTW/+eDmt+SmyirYqPLte07bRvOO9Gz8uu/iI1+IRltsh6
         t2ffMdwkZXHqyy0UtnRttx/8w1+3tRO6rFPh0WiXA6lta9MKvdJomWdYrCSN8EhDlpgM
         ldTqSUrnB1phcl8xxdmuOoGNId3knJbxLXO3o2mqv23n8FRb5cvIp/mjEReBndPE/CBT
         4sF65Rv9jlGZZImgJohiwy8q/VOE+Zf2Of7qPrXFP7UddHbovyvZzEUFPmWfm7AU5bLY
         L+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fE48bxTCj7r7V5VDAPsC8j4ZhQ94Cn7/3g3JrlrM/o0=;
        b=YU5QuNCPCue3mZbNvowNUxQiQtkWIsoBtMkXWcLiQ8An9y2oykhKxyJ3hd6TbP2l3I
         GGoar/mb2W9+5mklRwYjim7MV0vHLO8lbuXSGrAzMKVRiqg7xXIJ6F9tps2Od/rYiy7w
         TklzvkX3AW0N6QIjiQZESvM3UjLvX3KXPQka+X/EAPu6+cSbkgBtVVZVltyg42GT/poK
         PN7GKj44iXZodJaRBMipOIj6+9jPWIx4wFfh7G7g9H6bkDu7mnRpBttf1y/Y1qR5O1Oc
         WC0/u3l9snhcnX0P1SXFNyAaxc2zHmilZSHbjLgkwVx7iaEjfvwKtccmFRpj4jG1yiEX
         biXQ==
X-Gm-Message-State: AEkooutrtIikWxVuf6NY3CxnnOgTGF6iSZSR/sc00gVwBGGOGVldMPObopKj3oLm6kHD+Q==
X-Received: by 10.66.43.234 with SMTP id z10mr9351992pal.137.1471575167075;
        Thu, 18 Aug 2016 19:52:47 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 132sm1886744pfu.6.2016.08.18.19.52.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 19:52:46 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 2/5] MIPS: BMIPS: Add support GPIO device nodes
Date:   Fri, 19 Aug 2016 11:52:27 +0900
Message-Id: <20160819025230.31882-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819025230.31882-1-jaedon.shin@gmail.com>
References: <20160819025230.31882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54671
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
index eb7b19a32e3e..0105e4e5130b 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -232,6 +232,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408440 {
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
index b2276b1e12d4..aec1b2e7e2ab 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -216,6 +216,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408240 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408240 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <50>;
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
index e414af1e14ff..f0f63cb2bd2b 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -208,6 +208,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <50>;
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
index 3bd1c0111d43..ac42b98e31bb 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -204,6 +204,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <50>;
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
index 9ab65d64e948..8b05b98f2a9c 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -231,6 +231,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <49>;
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
index 7801169416e7..b7bb1024089c 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -246,6 +246,43 @@
 			status = "disabled";
 		};
 
+		aon_pm_l2_intc: interrupt-controller@408440 {
+			compatible = "brcm,l2-intc";
+			reg = <0x408440 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <54>;
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
2.9.3
