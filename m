Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 10:54:35 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36392 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992914AbcHLIxBpqF7- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 10:53:01 +0200
Received: by mail-pf0-f194.google.com with SMTP id y134so1213498pfg.3;
        Fri, 12 Aug 2016 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdKSJCPFJM3FEQ7idAl+u4kuDBqHl821uHetA0TOY5E=;
        b=e2uuXkq9QNOUNbfjsRoKp1j0DmxEmMjfYgIaNgg3ZJxYIR1GaiFaaJwj/XmKIKGG/9
         JQBak14g/PWudA/3mCrz+bt72A+ElOpKqCZjkoxbEr6C5EVQA1cWKUuQSpUL/3V6MaIc
         RdHr/nKnxvLfZJfVBWcQzcqi7Bcrv5LNa/DYuj6LW+zxgkMi2GeD9Zph3+reo3FNBRHF
         drHpB8QuZzaHQDrDJLvhYPmg9cP716cNDycd9qKuZhT93zMLxDpAzRaH8Y80XprJAiFx
         hyBgh03z8hYNm/DSXswu7ct8rjh30mMjSq8BcD3Tei+pCO0wo78tpWJne52tGX8vunAw
         sgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdKSJCPFJM3FEQ7idAl+u4kuDBqHl821uHetA0TOY5E=;
        b=LuKh4aS7EdaZYA4DThFi1r8VgW80NzUZX+Qjpjn2whuCOAAj9AfBwoi0ID4cmftTZp
         qXu1unwTeF89WeSV2JwdGvw7lEmbbVtZ2otlxsPARX1iPplPhF4QVqqRI6J1DJz6M6Fs
         j6Mrc/0UYYe8vEhJJke2E0WMdw8VmlRomjDZb3UaYvXKK4+aDgE4dU3b9jBR3BFqd2GA
         eEJUnQZXtxic6bGDTQ8C0amCfKr587w12WaywuMZAPI7a0B3mYTnAIZ2sVH3Q3+htcgl
         LSibNCn4jyoigdaLp5bCWDH2UzyNG6NqzIG95wTTIydgmeekm83QO24zg6JVKeYf7HoC
         Ukhw==
X-Gm-Message-State: AEkoouuKHGCn7TAsvZ/kqDEs43OnKkTWCMICtYrA7Aew3YYa4+T9Kn79nhaHEWF4EAkSBQ==
X-Received: by 10.98.84.65 with SMTP id i62mr24977123pfb.72.1470991975774;
        Fri, 12 Aug 2016 01:52:55 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ty6sm11024819pac.18.2016.08.12.01.52.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 01:52:55 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 4/5] MIPS: BMIPS: Add support NAND device nodes
Date:   Fri, 12 Aug 2016 17:52:30 +0900
Message-Id: <20160812085231.53290-5-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812085231.53290-1-jaedon.shin@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54499
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
index 8c0466bd84d0..d8ea487f334f 100644
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
index aa4a75ea8e40..21718d71ba03 100644
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
index bcab913aea36..2a9d30ddd7a9 100644
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
index 9214ec55ffc2..57973b082dcc 100644
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
index de4c7744caab..2a64f16c5741 100644
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
index 7a9c76d59ff3..6863c35bbd11 100644
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
