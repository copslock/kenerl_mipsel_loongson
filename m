Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 03:00:48 +0100 (CET)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32883 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994631AbcL0CACTeOW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2016 03:00:02 +0100
Received: by mail-pg0-f68.google.com with SMTP id g1so10794358pgn.0;
        Mon, 26 Dec 2016 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBLXMhKSw+q1HVQGvRpMT7eXDzInZ3oZtJR4+zlYgS8=;
        b=XJWp8m6QdfhCJSRE6yY5ZVrbUw1XMDfnRcuE8vQCoinuikOJNOaujw+swZY5yz4ByK
         dHUK9kD71KxKfIPaHOWNTAK/MKPbLsd3kZ0Z5sJAa6JTQHfdNi/fKC3lmWe00EhajX9R
         WlHua2+zUjA2dYxXL/eUQRxFbGYNeUSBn3V24m3Pc/IIuOM/MSAlMxmgmilY8OHbAhCH
         RwF9xYsLP2oM8NQOwsACuIUm5ZArmanXM2Xo6vSpyNGjFX/otC+vj8xNdRvPl5nF3mD0
         chUSaWHiUdEBUOid1+ssvd8tDG7pzmGXELPNHLPgNjcbeXgAqzWZNh0Z8xqObmklTirw
         sE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iBLXMhKSw+q1HVQGvRpMT7eXDzInZ3oZtJR4+zlYgS8=;
        b=qNS3UXwoEANhfLa+N0zN/0kOYm79+H3hSNAjPwwyEV0zptQgR4+ovpBkMelaJ5Iwib
         Cb5AU9qdaXryMjh434pp/jOfRxLpYHtOMPSOtv/QUo3+col/SdJIcVIHdLkDLoDcZpqy
         hfJo+1QfIg27Y+N9NIBWGcDQvZFzQ11lvh2Q2GZ2gwVlck9MRanV3u5GyR1SuNxoAQdA
         QMYhhAAsyswcS23jkw5uUv1yn8iVx81LkeamVMEO0TnbG6lSYatV1/EQ3xSu8djvXnrq
         hnXZERPwZebOYDeKtDUFXhNPF7Rq6Vvlynq0H9gzr7eg9lifZjztkyrTTvSapW9F3vom
         bSRQ==
X-Gm-Message-State: AIkVDXKi4uCdqFWiiZm0yioF4jRb13RnVIp0KK4NTJPOhZjpGI9zuucrpmUQmCk+EDhJrw==
X-Received: by 10.98.32.151 with SMTP id m23mr28110074pfj.127.1482803995928;
        Mon, 26 Dec 2016 17:59:55 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q5sm9238749pgf.45.2016.12.26.17.59.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 17:59:55 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: Add support SPI device nodes
Date:   Tue, 27 Dec 2016 10:59:23 +0900
Message-Id: <20161227015923.882-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161227015923.882-1-jaedon.shin@gmail.com>
References: <20161227015923.882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56125
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

Adds SPI device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 55 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 55 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
 16 files changed, 526 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index bbd00f65ce39..c1e19e57f64a 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -46,6 +46,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -91,15 +97,15 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>, <0xf000000>;
+			brcm,int-map-mask = <0x44>, <0xf000000>, <0x100000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <18>, <19>;
-			interrupt-names = "upg_main", "upg_bsc";
+			interrupts = <18>, <19>, <20>;
+			interrupt-names = "upg_main", "upg_bsc", "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -226,5 +232,48 @@
 			interrupts = <61>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <79>;
+		};
+
+		qspi: spi@443000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x440920 0x4 0x443200 0x188 0x443000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@406400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x406400 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 4bbcc95f1c15..a9ebc3827199 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -46,6 +46,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -439,5 +445,48 @@
 			interrupts = <85>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <31>;
+		};
+
+		qspi: spi@413000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x410920 0x4 0x413200 0x188 0x413000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@408a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x408a00 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 3e42535c8d29..91d544e79f13 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -318,5 +324,48 @@
 			interrupts = <24>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <31>;
+		};
+
+		qspi: spi@413000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x410920 0x4 0x413200 0x188 0x413000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@408a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x408a00 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 112a5571c596..7aa389583c9a 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -358,5 +364,48 @@
 			interrupts = <82>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <31>;
+		};
+
+		qspi: spi@413000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x410920 0x4 0x413200 0x188 0x413000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@408a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x408a00 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 34abfb0b07e7..23508d8ea121 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -46,6 +46,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -354,5 +360,48 @@
 			interrupts = <82>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <31>;
+		};
+
+		qspi: spi@413000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x410920 0x4 0x413200 0x188 0x413000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@408a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x408a00 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index b143723c674e..73f020624a31 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -46,6 +46,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -92,15 +98,15 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406780 0x8>;
 
-			brcm,int-map-mask = <0x44>, <0x1f000000>;
+			brcm,int-map-mask = <0x44>, <0x1f000000>, <0x100000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <18>, <19>;
-			interrupt-names = "upg_main", "upg_bsc";
+			interrupts = <18>, <19>, <20>;
+			interrupt-names = "upg_main", "upg_bsc", "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -287,5 +293,48 @@
 			interrupts = <62>;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@411d00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411d00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <78>;
+		};
+
+		qspi: spi@443000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x440920 0x4 0x443200 0x188 0x443000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@406400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x406400 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 2488d2f61f60..c956f11e6ba8 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -46,6 +46,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -450,5 +456,48 @@
 			mmc-hs200-1_8v;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@41ad00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x41ad00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <25>;
+		};
+
+		qspi: spi@41c000 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x419920 0x4 0x41c200 0x188 0x41c000 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@409200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x409200 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 19fa259b968b..9f16bf5df709 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -58,6 +58,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
 		};
+
+		spi_clk: spi_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -465,5 +471,48 @@
 			mmc-hs200-1_8v;
 			status = "disabled";
 		};
+
+		spi_l2_intc: interrupt-controller@41bd00 {
+			compatible = "brcm,l2-intc";
+			reg = <0x41bd00 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <25>;
+		};
+
+		qspi: spi@41d200 {
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-qspi";
+			clocks = <&spi_clk>;
+			reg = <0x41a920 0x4 0x41d400 0x188 0x41d200 0x50>;
+			reg-names = "cs_reg", "hif_mspi", "bspi";
+			interrupts = <0x0 0x1 0x2 0x3 0x4 0x5 0x6>;
+			interrupt-parent = <&spi_l2_intc>;
+			interrupt-names = "spi_lr_fullness_reached",
+					  "spi_lr_session_aborted",
+					  "spi_lr_impatient",
+					  "spi_lr_session_done",
+					  "spi_lr_overread",
+					  "mspi_done",
+					  "mspi_halted";
+			status = "disabled";
+		};
+
+		mspi: spi@409200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,spi-bcm-qspi",
+				     "brcm,spi-brcmstb-mspi";
+			clocks = <&upg_clk>;
+			reg = <0x409200 0x180>;
+			reg-names = "mspi";
+			interrupts = <0x14>;
+			interrupt-parent = <&upg_aon_irq0_intc>;
+			interrupt-names = "mspi_done";
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index 5c24eacd72dd..d72bc423ceaa 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -57,3 +57,7 @@
 &ohci0 {
 	status = "disabled";
 };
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index e67eaf30de3d..ea52d7b5772f 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -109,3 +109,7 @@
 &sdhci0 {
 	status = "okay";
 };
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index ee4607fae47a..721cb8b66701 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -69,3 +69,39 @@
 &nand {
 	status = "okay";
 };
+
+&qspi {
+	status = "okay";
+
+	m25p80@0 {
+		compatible = "m25p80";
+		reg = <0>;
+		spi-max-frequency = <0x2625a00>;
+		spi-cpol;
+		spi-cpha;
+		use-bspi;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash0.cfe@0 {
+				reg = <0x0 0x200000>;
+			};
+
+			flash0.mac@200000 {
+				reg = <0x200000 0x40000>;
+			};
+
+			flash0.nvram@240000 {
+				reg = <0x240000 0x10000>;
+			};
+		};
+	};
+};
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index bed821b03013..03e3ad739f16 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -72,3 +72,39 @@
 &sdhci0 {
 	status = "okay";
 };
+
+&qspi {
+	status = "okay";
+
+	m25p80@0 {
+		compatible = "m25p80";
+		reg = <0>;
+		spi-max-frequency = <0x2625a00>;
+		spi-cpol;
+		spi-cpha;
+		use-bspi;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash0.cfe@0 {
+				reg = <0x0 0x200000>;
+			};
+
+			flash0.mac@200000 {
+				reg = <0x200000 0x40000>;
+			};
+
+			flash0.nvram@240000 {
+				reg = <0x240000 0x10000>;
+			};
+		};
+	};
+};
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 68fd823868e0..78bffdf11872 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -73,3 +73,7 @@
 &sdhci0 {
 	status = "okay";
 };
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index e66271af055e..d62b448a152d 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -79,3 +79,7 @@
 &ohci1 {
 	status = "okay";
 };
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index f95ba1bf3e58..32ece2dda046 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -107,3 +107,39 @@
 &sdhci1 {
 	status = "okay";
 };
+
+&qspi {
+	status = "okay";
+
+	m25p80@0 {
+		compatible = "m25p80";
+		reg = <0>;
+		spi-max-frequency = <0x2625a00>;
+		spi-cpol;
+		spi-cpha;
+		use-bspi;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash0.cfe@0 {
+				reg = <0x0 0x200000>;
+			};
+
+			flash0.mac@200000 {
+				reg = <0x200000 0x40000>;
+			};
+
+			flash0.nvram@240000 {
+				reg = <0x240000 0x10000>;
+			};
+		};
+	};
+};
+
+&mspi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index fb37b7111bf4..0a915f3feab6 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -115,3 +115,7 @@
 &sdhci1 {
 	status = "okay";
 };
+
+&mspi {
+	status = "okay";
+};
-- 
2.11.0
