Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 04:18:36 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33170 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992028AbcHHCRvq05nX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 04:17:51 +0200
Received: by mail-pf0-f194.google.com with SMTP id i6so24081727pfe.0;
        Sun, 07 Aug 2016 19:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMGjlzon6KT/5A14suVAgdhhMeWfPFRX0gNr9K4DV3Y=;
        b=syqCPGSIgMx/qCLNmUm83Pr9SGZkR/PoU2hAI3DGWN/o5e5egGq2f7lKZc3m7NzkuF
         Yhjy8X+fudsGfL9iYnSUPLSD5IHK8pFjgsHheaMAaIWgHJ+AksTczu2oCCvO5sPdr4LD
         b3iyPKjFWotl1okG0YygqrIJI3OQTOjRl85ugY/9iFfN3ceENHOaeBb3rt7bngAklpZJ
         ojbEJVzCBYhOAanspiNYdTel2jb/NiyMB3vP3pfY9a3uYmity8eSKZ8H+OnT4o2JkwXh
         A82f9TLrPPonnKKATCC4v5T6KulFnmviZmsjeMVhr7nHLBK23fNrDyQAQrEfrpA7xcF8
         6GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMGjlzon6KT/5A14suVAgdhhMeWfPFRX0gNr9K4DV3Y=;
        b=FMCNeW04DM78xRLCE1ustCFQ7VQ5L1iw+L+V8TnfcJXp3d9se4HJJKp1XuxUfbqaIX
         0oTwwqjYp5mJgGZUWk12n6GFNQz8uaEQkF9x+1NyGxIsj8cB6sobvXKZU0EpkWhM+FYY
         WnrDhjwejZ/O+GXbkRoMuIErtKNLOBj0/C4IQ94nrMP6v3VziMKQZMdirwrvxT4juxPC
         +cEDiyNPHMsIp6ujD8unaaLyYQJEL/eGkGTQkS2MdYuJMEeUvOnBO0Rs7d0pRlLsvQfB
         jEe7KSk237IcbGnre+W4H1lCrzVVwFon1D6zthYavg6tUIkz1aucmSTxteDh9PkKgrhs
         THxw==
X-Gm-Message-State: AEkoouullD0L+76OLxCqaZzFgFIfjqlhLOw/ZSF6KtOXney0zTV66KIGo+XaWHZRkspZJA==
X-Received: by 10.98.36.15 with SMTP id r15mr159221743pfj.1.1470622665716;
        Sun, 07 Aug 2016 19:17:45 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id r2sm12701468pal.14.2016.08.07.19.17.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 19:17:45 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/4] MIPS: BMIPS: Add support GPIO device nodes
Date:   Mon,  8 Aug 2016 11:17:17 +0900
Message-Id: <20160808021719.4680-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160808021719.4680-1-jaedon.shin@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54420
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
 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 12 ++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 12 ++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 37 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 +++++++
 16 files changed, 302 insertions(+)

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
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index 5c24eacd72dd..91590ff55d52 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -49,6 +49,10 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
 /* FIXME: USB is wonky; disable it for now */
 &ehci0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 2c55ab094a29..e91a21f75a13 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -57,6 +57,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index 757fe9d5f4df..d475a152eb2a 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -53,6 +53,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 496e6ed9fae3..a445a45f51cb 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -49,6 +49,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index b880c018f3d8..22b1b506594f 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -45,6 +45,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index e66271af055e..428c36da91b6 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -59,6 +59,10 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
 /* FIXME: MAC driver comes up but cannot attach to PHY */
 &enet0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index f091e91b11c5..6adfcd505a03 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -59,6 +59,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 9db84f2a6664..dd8b8fb97053 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -59,6 +59,14 @@
 	status = "okay";
 };
 
+&upg_gio {
+	status = "okay";
+};
+
+&upg_gio_aon {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.9.2
