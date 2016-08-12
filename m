Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 04:11:44 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34016 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbcHLCKBPoEbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 04:10:01 +0200
Received: by mail-pf0-f194.google.com with SMTP id g202so664541pfb.1;
        Thu, 11 Aug 2016 19:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JueeCuaCmQyPOdRmMr+AAey4ujx1meRlcuF19PsF94c=;
        b=ysk1BomaSMKLwgJOI7IrIzlTNDyuH73bhGj+o7LsSrM31AV4zcQIkRiDnuMwixM45A
         XMT6YXt2VvzSXvOn/g6zd3edPog8Q9qfFegSgwgGWE+ZxakI9is6E7kQUchz66hfL/QV
         j80QE8BF2JkGiH7ox0LmO1+YPvdxY4T2BwtY49w4yXjtGqyZkRP7E5FpCwMETvW3mvA/
         WRHlOj951U2BfzHDtmBm81QzViMZKkSkwzB7p1QqJaK/j+A8h613rxoV46G2nET+I0xm
         1vI/q5bo6EWHD1hMeSTcZtYJfrSmEZCwNMSXFcQIlckzpFrLgADS2fE+0X5kqNm5cwnr
         YP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JueeCuaCmQyPOdRmMr+AAey4ujx1meRlcuF19PsF94c=;
        b=lGMYPY7WqRtYhADqQ98RisYR/lDtCiqtB1fzaxyGanheTGJvEE654qisYwzYW0WuLK
         MCHEV3Qrx3QOJfvrpqmpk8WmZ9j0VaPnEGwSeh+g+WVpS90/lWtmG3duDkWNbs4HagGF
         YTCz6NeJsM4xi2d91yMEA74gHcgAsiEXszm0sRDSUGgMUFgNZLJMncBu9W9Dyk3v3CRi
         84jikNayhC9Yj8m2SfDWdxMoTsaT72tUL1/dqzpcQFdO/ANp1HTYrnpUu8bredci7dFu
         qb4oBV8k8xN389C+Gny5Rp0LaEW0RPmhfknqZ6/WJIsSlVLmGfiOCFT39aTHbwVvYa76
         +d7A==
X-Gm-Message-State: AEkooutHrTketizzYvI8oH9LLyl8GaKr8mHnrkIDfr5Gf7Ql09mrX+K514EzRJCCFBk2ww==
X-Received: by 10.98.201.2 with SMTP id k2mr22655830pfg.95.1470967795041;
        Thu, 11 Aug 2016 19:09:55 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ao6sm8209846pac.8.2016.08.11.19.09.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 19:09:54 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 5/5] MIPS: BMIPS: Use interrupt-controller node name
Date:   Fri, 12 Aug 2016 11:09:23 +0900
Message-Id: <20160812020923.3299-6-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812020923.3299-1-jaedon.shin@gmail.com>
References: <20160812020923.3299-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54490
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

Changes node names of the interrupt-controller device nodes to
interrupt-controller instead of label strings.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi |  8 ++++----
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 14 +++++++-------
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 14 +++++++-------
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 14 +++++++-------
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 14 +++++++-------
 arch/mips/boot/dts/brcm/bcm7420.dtsi |  8 ++++----
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 14 +++++++-------
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 14 +++++++-------
 8 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 746ed06c85de..bbd00f65ce39 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -26,7 +26,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -55,7 +55,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@441400 {
+		periph_intc: interrupt-controller@441400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x441400 0x30>, <0x441600 0x30>;
 
@@ -66,7 +66,7 @@
 			interrupts = <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@401800 {
+		sun_l2_intc: interrupt-controller@401800 {
 			compatible = "brcm,l2-intc";
 			reg = <0x401800 0x30>;
 			interrupt-controller;
@@ -87,7 +87,7 @@
 						     "avd_0", "jtag_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406780 {
+		upg_irq0_intc: interrupt-controller@406780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 1e19050825b5..487687bd878c 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -26,7 +26,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -55,7 +55,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@411400 {
+		periph_intc: interrupt-controller@411400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x411400 0x30>, <0x411600 0x30>;
 
@@ -66,7 +66,7 @@
 			interrupts = <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -87,7 +87,7 @@
 						     "jtag_0", "svd_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406780 {
+		upg_irq0_intc: interrupt-controller@406780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
@@ -102,7 +102,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+		upg_aon_irq0_intc: interrupt-controller@408b80 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x408b80 0x8>;
 
@@ -232,7 +232,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
 			interrupt-controller;
@@ -372,7 +372,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@411000 {
+		hif_l2_intc: interrupt-controller@411000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x411000 0x30>;
 			interrupt-controller;
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 079163b00994..6f9b8423152a 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -20,7 +20,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -49,7 +49,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@411400 {
+		periph_intc: interrupt-controller@411400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x411400 0x30>;
 
@@ -60,7 +60,7 @@
 			interrupts = <2>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -81,7 +81,7 @@
 						     "avd_0", "jtag_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406600 {
+		upg_irq0_intc: interrupt-controller@406600 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406600 0x8>;
 
@@ -96,7 +96,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+		upg_aon_irq0_intc: interrupt-controller@408b80 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x408b80 0x8>;
 
@@ -216,7 +216,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408240 {
+		aon_pm_l2_intc: interrupt-controller@408240 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408240 0x30>;
 			interrupt-controller;
@@ -299,7 +299,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@411000 {
+		hif_l2_intc: interrupt-controller@411000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x411000 0x30>;
 			interrupt-controller;
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 37dc60a3e730..094d288eace8 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -20,7 +20,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -49,7 +49,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@411400 {
+		periph_intc: interrupt-controller@411400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x411400 0x30>;
 
@@ -60,7 +60,7 @@
 			interrupts = <2>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -81,7 +81,7 @@
 						     "avd_0", "jtag_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406600 {
+		upg_irq0_intc: interrupt-controller@406600 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406600 0x8>;
 
@@ -96,7 +96,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+		upg_aon_irq0_intc: interrupt-controller@408b80 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x408b80 0x8>;
 
@@ -208,7 +208,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
 			interrupt-controller;
@@ -291,7 +291,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@411000 {
+		hif_l2_intc: interrupt-controller@411000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x411000 0x30>;
 			interrupt-controller;
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index b148acb7e116..5a849dbd1b6a 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -26,7 +26,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -55,7 +55,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@411400 {
+		periph_intc: interrupt-controller@411400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x411400 0x30>, <0x411600 0x30>;
 
@@ -66,7 +66,7 @@
 			interrupts = <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -87,7 +87,7 @@
 						     "avd_0", "jtag_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406600 {
+		upg_irq0_intc: interrupt-controller@406600 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406600 0x8>;
 
@@ -102,7 +102,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+		upg_aon_irq0_intc: interrupt-controller@408b80 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x408b80 0x8>;
 
@@ -204,7 +204,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
 			interrupt-controller;
@@ -287,7 +287,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@411000 {
+		hif_l2_intc: interrupt-controller@411000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x411000 0x30>;
 			interrupt-controller;
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 0d391d77c780..b143723c674e 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -26,7 +26,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -55,7 +55,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@441400 {
+		periph_intc: interrupt-controller@441400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x441400 0x30>, <0x441600 0x30>;
 
@@ -66,7 +66,7 @@
 			interrupts = <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@401800 {
+		sun_l2_intc: interrupt-controller@401800 {
 			compatible = "brcm,l2-intc";
 			reg = <0x401800 0x30>;
 			interrupt-controller;
@@ -88,7 +88,7 @@
 						     "jtag_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406780 {
+		upg_irq0_intc: interrupt-controller@406780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index a80d5d1e31ed..0f51a438f42b 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -26,7 +26,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -55,7 +55,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@41a400 {
+		periph_intc: interrupt-controller@41a400 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x41a400 0x30>, <0x41a600 0x30>;
 
@@ -66,7 +66,7 @@
 			interrupts = <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -89,7 +89,7 @@
 						     "vice_0";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406780 {
+		upg_irq0_intc: interrupt-controller@406780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
@@ -104,7 +104,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@409480 {
+		upg_aon_irq0_intc: interrupt-controller@409480 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x409480 0x8>;
 
@@ -231,7 +231,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
 			interrupt-controller;
@@ -371,7 +371,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@41a000 {
+		hif_l2_intc: interrupt-controller@41a000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x41a000 0x30>;
 			interrupt-controller;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index ae5c6311db59..4d57319f3e48 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -38,7 +38,7 @@
 		uart0 = &uart0;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -67,7 +67,7 @@
 		compatible = "simple-bus";
 		ranges = <0 0x10000000 0x01000000>;
 
-		periph_intc: periph_intc@41b500 {
+		periph_intc: interrupt-controller@41b500 {
 			compatible = "brcm,bcm7038-l1-intc";
 			reg = <0x41b500 0x40>, <0x41b600 0x40>,
 				<0x41b700 0x40>, <0x41b800 0x40>;
@@ -79,7 +79,7 @@
 			interrupts = <2>, <3>, <2>, <3>;
 		};
 
-		sun_l2_intc: sun_l2_intc@403000 {
+		sun_l2_intc: interrupt-controller@403000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x403000 0x30>;
 			interrupt-controller;
@@ -104,7 +104,7 @@
 						     "scpu";
 		};
 
-		upg_irq0_intc: upg_irq0_intc@406780 {
+		upg_irq0_intc: interrupt-controller@406780 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
@@ -119,7 +119,7 @@
 			interrupt-names = "upg_main", "upg_bsc";
 		};
 
-		upg_aon_irq0_intc: upg_aon_irq0_intc@409480 {
+		upg_aon_irq0_intc: interrupt-controller@409480 {
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x409480 0x8>;
 
@@ -246,7 +246,7 @@
 			status = "disabled";
 		};
 
-		aon_pm_l2_intc: aon_pm_l2_intc@408440 {
+		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
 			interrupt-controller;
@@ -386,7 +386,7 @@
 			status = "disabled";
 		};
 
-		hif_l2_intc: hif_l2_intc@41b000 {
+		hif_l2_intc: interrupt-controller@41b000 {
 			compatible = "brcm,l2-intc";
 			reg = <0x41b000 0x30>;
 			interrupt-controller;
-- 
2.9.2
