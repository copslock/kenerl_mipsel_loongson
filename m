Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 04:19:22 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33371 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992161AbcHHCR4U74OX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 04:17:56 +0200
Received: by mail-pa0-f68.google.com with SMTP id vy10so4550124pac.0;
        Sun, 07 Aug 2016 19:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94IDTK8h+XLbOhIoHJeCLsXPPfKcX8t/X1vEvvNr1aw=;
        b=tiDKOzb7uzxb5eZ98OW4SD0wEB/VAkGQS3B1RBGwcsm5gjpKWC03E30ub7TLAHpvZ3
         lVohZTXI33K7/YNpYRXMvUIf65pCJ43X2hfbdpcqsL+/Ge4ozwbqA7KIsoq7JwMJjbEu
         ebI1vq0aarK4U/j46/XfGm896KWpBA/MZlan5sGSCHQgZrHZaJX9kTSLti/aYMQ7n1k1
         0a88DWJ0XdTli6vtGcrM/WNXzni3LnqbwmsGSAW4vjdP0JpXJ4qF5DL0uV/IV4hAnf1S
         aVjxcbCo0c1JC3QHYTpNXwWx1YzRAwCnKP7k+QnDHAVpw0pzdmi7HV2CnJP4y5JaCN2t
         O7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94IDTK8h+XLbOhIoHJeCLsXPPfKcX8t/X1vEvvNr1aw=;
        b=BY0j1ynQjebrlwVPzWbqSPEUNiyPKLg2qhR49+dCxTIMwwdgOWCKC4z8Jq69Hyrchs
         S46tWu/riwcN5vhWp9WoJe7VEBP5k2hC+EXRU1CX1GrtRxFfajM/cAj+14xGGsimH6jC
         +qzC68PWpv0uFwIxjPh3Di6FwyvfmmyivcfWbiXD2Tjk5EJIqnG8SYiyH9YrJI9+pBBA
         EsI2dpWoT4IQWFN1DY60USNISgfMd+NSX49kE1h4rWratFXTEGt0kqgrTLv7bR0H44q/
         u+CnGopRhJwc/TlsquSliRl+scQc2nSix+5QYJesQQicCJywXA/yzuehtCVevcwARPBq
         M8Gg==
X-Gm-Message-State: AEkoout3GYQLFG9Ob871mW5ZwnfwbFME4cJTTyzG7USJwsIKXkYJ1u2XT+ek8DkEd02zwA==
X-Received: by 10.66.32.131 with SMTP id j3mr5505917pai.58.1470622670166;
        Sun, 07 Aug 2016 19:17:50 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id r2sm12701468pal.14.2016.08.07.19.17.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 19:17:49 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 4/4] MIPS: BMIPS: Add support NAND device nodes
Date:   Mon,  8 Aug 2016 11:17:19 +0900
Message-Id: <20160808021719.4680-5-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160808021719.4680-1-jaedon.shin@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54422
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
 arch/mips/boot/dts/brcm/bcm7125.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi               | 20 ++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi | 24 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  5 +++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97420c.dts              |  5 +++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  5 +++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  5 +++++
 17 files changed, 224 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 746ed06c85de..8642631a8451 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -226,5 +226,25 @@
 			interrupts = <61>;
 			status = "disabled";
 		};
+
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <0>;
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
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 0d391d77c780..6f42ae70ffff 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -287,5 +287,25 @@
 			interrupts = <62>;
 			status = "disabled";
 		};
+
+		hif_l2_intc: hif_l2_intc@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <0>;
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
diff --git a/arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi b/arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi
new file mode 100644
index 000000000000..5f17f149fcf7
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi
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
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index 91590ff55d52..391d0ce642bc 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7125.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97125cbmb", "brcm,bcm7125";
@@ -61,3 +62,7 @@
 &ohci0 {
 	status = "disabled";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index ee4867ec03c4..dc6b5a0b548c 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7346.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97346dbsmb", "brcm,bcm7346";
@@ -101,6 +102,10 @@
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
index d475a152eb2a..3390dac81fff 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7358.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97358svmb", "brcm,bcm7358";
@@ -72,3 +73,7 @@
 &ohci0 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index bb1e0474510d..82d7ffe6769e 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7360.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97360svmb", "brcm,bcm7360";
@@ -69,6 +70,10 @@
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
index 1c7c15679dff..aa1a92ab678e 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7362.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97362svmb", "brcm,bcm7362";
@@ -65,6 +66,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index 428c36da91b6..25dcf0955ca0 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7420.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97420c", "brcm,bcm7420";
@@ -76,6 +77,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index b9222f72d063..2cfe9088e508 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7425.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97425svmb", "brcm,bcm7425";
@@ -103,6 +104,10 @@
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
index 6bca6449f86a..2693f707d113 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "bcm7435.dtsi"
+/include/ "bcm7xxx-nand-cs1-bch8.dtsi"
 
 / {
 	compatible = "brcm,bcm97435svmb", "brcm,bcm7435";
@@ -103,6 +104,10 @@
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.9.2
