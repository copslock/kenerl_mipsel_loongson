Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 04:54:46 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35167 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992247AbcHSCxBStjDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 04:53:01 +0200
Received: by mail-pf0-f193.google.com with SMTP id h186so682103pfg.2;
        Thu, 18 Aug 2016 19:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwyp4vFfr2LAiF80/meP6764SXZ3wb/HihAz1zFmjMc=;
        b=xscR9qyTaV0gDbe0lvvycY+0VmJzbFRLbQjPG45bjrpVJqJIC/8pKnCp9iNv1O3lx0
         FxaqLmp09hIs2XKICkrkr4gx9ApSrbYyFMFAqMKovuJHV+y9Pnci8H3fzUu9gCuiSb5B
         Nrk8f4APNfSmyxTxgH4jiUdvE75e4Ca5q4XvQP49vaNSfZtBs/pzDthTUasAazC2G/Sd
         XDQYBML1zkhyeP+YwWd/j2mcOktqgxdEASmdsBy4WKXHrZtAGPeBNXGZ3YHCCsASAo8v
         in39ZrBBnLQJ6W+B501SHFYjEVR4/87lJknZVr9+DGjQ3g21GXhIQWc3WnKuJQYAXm6d
         /vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwyp4vFfr2LAiF80/meP6764SXZ3wb/HihAz1zFmjMc=;
        b=h3gA0nGxTTdcTClpDzdkZerDXIgrq7Szo3RXbSWoxqU1J3lvWqmXT5MOS7xtcMaRBg
         Y0RqvNuqadWcBmvrk4fglAfqB3c/QQulcmVp1FK1kDAtzfrKSV6amRekBWOHIaCVxlmZ
         q/aMyBfKLo2+vePOzI6eY8GKzc5D3rK/ddDAfnvkykOe+WxDJDNkQP3jRNq7Nmy2UcDS
         TqWnWoVeUgXy0+CaGJ8Cp9DIf3jqmwmQNPbHoz10NI6X3iuqEWUnC/t5F/W9icBS5GG/
         m/r0PtezrKTZcV3cwnrZ8GyfrJMBlvshG6pyqbvueFdwgANZl0hqmkluBkCUi1NZEcCt
         6WRQ==
X-Gm-Message-State: AEkoouuF3ZorG86m4lT/3KYWeWaYohbxRKaE02wqIB+RBBOck/xr15i6Nlqw4Jg1l6UhOw==
X-Received: by 10.98.71.91 with SMTP id u88mr9928457pfa.145.1471575175311;
        Thu, 18 Aug 2016 19:52:55 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 132sm1886744pfu.6.2016.08.18.19.52.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 19:52:55 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 5/5] MIPS: BMIPS: Use interrupt-controller node name
Date:   Fri, 19 Aug 2016 11:52:30 +0900
Message-Id: <20160819025230.31882-6-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819025230.31882-1-jaedon.shin@gmail.com>
References: <20160819025230.31882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54674
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
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 10 +++++-----
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 10 +++++-----
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 10 +++++-----
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 10 +++++-----
 arch/mips/boot/dts/brcm/bcm7420.dtsi |  8 ++++----
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 10 +++++-----
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 10 +++++-----
 8 files changed, 38 insertions(+), 38 deletions(-)

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
index 72d9cffa8927..4bbcc95f1c15 100644
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
 
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 7f78bfab164b..3e42535c8d29 100644
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
 
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 64b9fd90941d..112a5571c596 100644
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
 
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 784d58725227..34abfb0b07e7 100644
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
index 7124c9822479..2488d2f61f60 100644
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
 
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index a3648964be3a..19fa259b968b 100644
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
 
-- 
2.9.3
