Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 04:11:22 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35763 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990521AbcHLCJ6tIHYx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 04:09:58 +0200
Received: by mail-pf0-f194.google.com with SMTP id h186so656560pfg.2;
        Thu, 11 Aug 2016 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=84iCa0MPHFZcm6ET3Hko4WsCe+ayLcAak8niM6BdNAA=;
        b=c/kma8+uluFZNsu06q7yqpB9MR2sAwVHsi1NFlUO0GrUsR5EZfeaXzhDjzu3kmHDeU
         +E6V1AjzxRR5Tf1oEjtmlz2c4edjcv/0hlZKOd1QhoX99GVGyJ3Fw79WXd7VPCBWG5O8
         RW+w4WTv/Roo7G7MpYbesLqjl45+xavG4U/WQKknkHRTBeD25dSP0JvbFLIEUI342GAB
         l3CRy7pa6l+Yz7dzUtBHYgGCMsbZYjm8m0BU7bsHPRowcW6HLk+Qx/6lYoj2PEpzBvLs
         0R56qETa9upFmS+XElzniJUh/uXWV1JwISs4Okk4Ly6Z0HVn9+s8AO0LihSrXhm85DK3
         efBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=84iCa0MPHFZcm6ET3Hko4WsCe+ayLcAak8niM6BdNAA=;
        b=AHVaQT8NVDUoaU+ijuklfVbi9+I+jvP7zvzls5ot7JspPkOCH11z/L+EgWaYZ9eQ7K
         0QxxYf7dJDEOSkJptRJbx6zXkNYPub5Lrq9oDVQT9PipfUq/79cITaoPvK8equWfzL7W
         rY2FQ75Q1rFeEBEObW3MHRmazfzniH+yRxI6eHiO1RYVPZuWbplHHMHpN0lHqU4W9Nak
         bCq90oMIzPbW8cORpg9Ap0kqiMlamWOJ86Em2SQjIGmK1l54T4NsZ3ktc1zXdPide9GQ
         m8CLSDpTcRQDXfxtgiXGGU729Zah+1meBLFg6WdxLNEuxftdD+0LHwmB9u1fgoYRVILB
         8sug==
X-Gm-Message-State: AEkoouvo/otCtn5XT/cz7NMAjhPyXDht76UQlfsVgxzvRdNIsb37UfpNNhdx3SNPiI+qog==
X-Received: by 10.98.47.132 with SMTP id v126mr23121224pfv.152.1470967792670;
        Thu, 11 Aug 2016 19:09:52 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ao6sm8209846pac.8.2016.08.11.19.09.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 19:09:52 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 4/5] MIPS: BMIPS: Add support NAND device nodes
Date:   Fri, 12 Aug 2016 11:09:22 +0900
Message-Id: <20160812020923.3299-5-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812020923.3299-1-jaedon.shin@gmail.com>
References: <20160812020923.3299-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54489
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

Adds NAND device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  5 +++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  5 +++++
 .../mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi | 24 ++++++++++++++++++++++
 13 files changed, 174 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 30af896ddb60..1e19050825b5 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -372,6 +372,26 @@
 			status = "disabled";
 		};
 
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+		};
+
+		nand: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
 		sata: sata@181000 {
 			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index bb099ee046a1..079163b00994 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -298,5 +298,25 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+		};
+
+		nand: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 05d868cbb5c0..37dc60a3e730 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -291,6 +291,26 @@
 			status = "disabled";
 		};
 
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+		};
+
+		nand: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
 		sata: sata@181000 {
 			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index ff555e52c088..b148acb7e116 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -287,6 +287,26 @@
 			status = "disabled";
 		};
 
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+		};
+
+		nand: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
 		sata: sata@181000 {
 			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 4e387d05bb5b..a80d5d1e31ed 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -371,6 +371,26 @@
 			status = "disabled";
 		};
 
+		hif_l2_intc: hif_l2_intc@41a000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x41a000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <24>;
+		};
+
+		nand: nand@41b800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x41b800 0x400>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
 		sata: sata@181000 {
 			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index d3130f7b7b70..ae5c6311db59 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -386,6 +386,26 @@
 			status = "disabled";
 		};
 
+		hif_l2_intc: hif_l2_intc@41b000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x41b000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <24>;
+		};
+
+		nand: nand@41c800 {
+			compatible = "brcm,brcmnand-v6.2", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand", "flash-dma";
+			reg = <0x41c800 0x600>, <0x41d000 0x100>;
+			interrupt-parent = <&hif_l2_intc>;
+			interrupts = <24>, <4>;
+			status = "disabled";
+		};
+
 		sata: sata@181000 {
 			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
 			reg-names = "ahci", "top-ctrl";
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 27c9f127a7ca..1c3090683e67 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7346.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97346dbsmb", "brcm,bcm7346";
@@ -93,6 +94,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index 757fe9d5f4df..a939ec7af82b 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7358.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97358svmb", "brcm,bcm7358";
@@ -64,3 +65,7 @@
 &ohci0 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index bed821b03013..c216fdf9370e 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7360.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97360svmb", "brcm,bcm7360";
@@ -61,6 +62,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 1b9bc4b2d9ae..cb4406192d44 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7362.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97362svmb", "brcm,bcm7362";
@@ -57,6 +58,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 1c6b74daef56..3b917cac7efe 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7425.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97425svmb", "brcm,bcm7425";
@@ -95,6 +96,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 64bb1988dbc8..54351e54ff68 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7435.dtsi"
+/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97435svmb", "brcm,bcm7435";
@@ -95,6 +96,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi b/arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi
new file mode 100644
index 000000000000..5f17f149fcf7
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi
@@ -0,0 +1,24 @@
+&nand {
+	nandcs@1 {
+		compatible = "brcm,nandcs";
+		reg = <1>;
+
+		nand-ecc-step-size = <512>;
+		nand-ecc-strength = <8>;
+		nand-on-flash-bbt;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1.rootfs@0 {
+				reg = <0x0 0x10000000>;
+			};
+
+			flash1.kernel@10000000 {
+				reg = <0x10000000 0x400000>;
+			};
+		};
+	};
+};
-- 
2.9.2
