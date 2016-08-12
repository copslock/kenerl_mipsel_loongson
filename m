Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 10:54:57 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36399 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992967AbcHLIxEshMn- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 10:53:04 +0200
Received: by mail-pf0-f194.google.com with SMTP id y134so1213552pfg.3;
        Fri, 12 Aug 2016 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bVAZKcesa9fZqt35m7ssRpJv1GBtZ01JRTgA0DXz5sg=;
        b=v9ytpQz2pzgjdF48gKz2q84ol0SgP9BydVWU/nb5G33Oh6Fl8muYssDO+NqLSAqV5U
         9/wsrotjo3uoyNbUr7JjJwY0lrbfQdtuOMUqDEx92/alu1J2qmCC6qezGGShkYS2EIyr
         IpYHZ9u9V2L2RoXSkhQjGGuHU8vMQ4QMqY1i0qfnhnrTw/Mo0RA+SeHbXBVXEGnkiDdp
         ADBSneBQJggeLbMAC/17FIdi5Ky5K2RcMgthMjoNeIsHNOMlh7wKPduytEFh1Er8tu+d
         P7vBEQ1x7XzRgQkpT+Mh7gVukK4uJ319FTNt1w+qiQArv7vS/4yLrGLsJeH167XnMAbF
         CUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bVAZKcesa9fZqt35m7ssRpJv1GBtZ01JRTgA0DXz5sg=;
        b=gRIKds1TfrGuP7pB/J8lEz4abPcRw4jyjiziGrk4y8OMmDLN+jrpxzM410iwhtY4i0
         dSk7y+CPEoHa3jGp3ZvQSPBBIMwpuol5t11bxR7i1CbS71RN5R+0JYCKhkHTWu8dYrxr
         3JTaaYOW3AV1KsO9oYuahFOlSqN/MQlMuoY806yDxeXigtz8fciM4f/6ptiKgbpO4ggh
         ZcVQ/GKp3niM+/DiTDoaT+tWztGwJo13UnAVdq5qaZ2U6AOJnXyzARfDF1gpfs9pl9j1
         eyJelxSYzZL8ine+uex5mSPA8G+g56A8L8PqF2FIoqXgyQBLnhL2a4bKYR0GRPF9jTJP
         WCIw==
X-Gm-Message-State: AEkoouuIzs6hAi0xxeh13gOLHbKoXg1Ekk1UZoBZ0aSdak++vPEQwpgQ+wE1llouUK+THA==
X-Received: by 10.98.35.145 with SMTP id q17mr25369291pfj.42.1470991978777;
        Fri, 12 Aug 2016 01:52:58 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ty6sm11024819pac.18.2016.08.12.01.52.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 01:52:58 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 5/5] MIPS: BMIPS: Use interrupt-controller node name
Date:   Fri, 12 Aug 2016 17:52:31 +0900
Message-Id: <20160812085231.53290-6-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812085231.53290-1-jaedon.shin@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54500
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
index d8ea487f334f..4bbcc95f1c15 100644
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
index 21718d71ba03..3e42535c8d29 100644
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
index 2a9d30ddd7a9..112a5571c596 100644
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
index 57973b082dcc..34abfb0b07e7 100644
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
index 2a64f16c5741..2488d2f61f60 100644
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
index 6863c35bbd11..19fa259b968b 100644
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
