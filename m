Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2017 03:01:05 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:36026
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdAJCA5TxTfL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2017 03:00:57 +0100
Received: by mail-pf0-x241.google.com with SMTP id b22so9828189pfd.3;
        Mon, 09 Jan 2017 18:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jx9rGDLzo9GVCvwk802u3fpxQp70SXG4QJQnza68yBQ=;
        b=KPkKx0DQb0sva0zV6ZKprt51JxBgI5mOEdlBUlyFvNgTKJ7X3fnDpazvHvR68VSl3L
         cJsI5sTUNso+CzDsFCgYSAARAadNJTiFyol1Lcivwv85a8i05+wqIUUhg3VB8Om3r+4j
         scImtqW45JOGM9Z+6m7MmZ4iiIebP3XMCq+oEVdR15tyOAUiWU6ounrawuwvl9MDIRh3
         yd6Qn2h4DNzHtY08sSJl4+R0KX2H0WjuLR5m6Fj3v58bmcwvgcsr6wueeQlZzRqI9Eb2
         1wXOXTyXXc2kQlJSCQ5dCFt3kHYi75Fbx/JiOSXv6YSfny14ocZhoWIkipI+V28WeIZq
         JBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jx9rGDLzo9GVCvwk802u3fpxQp70SXG4QJQnza68yBQ=;
        b=gISGnuHdH7qjQXWXJNjBn0qVHi93cAIS7eRttZNrIpzDWqZ69FGv/oELldK3N65Eyu
         6b3uU0AaNcoYmv0QHRt/8ZPdjwdHFAKGVoYfXaQfoHTkXuoe+klthTs5nYQ9vuCFahN9
         v5nOZ3wpAMXXP+NZWAG/o6FWg0ReRHo4jKBkGMDIHc9quAxlsGqTqTHpInWPoc3n3mf2
         cTY0rCKx8eok4MQewJRkOAp9LfJRJmHW2YgKQ/+WMD34c5OIiZI70X+ElvBLYnxPfOO7
         0RZ70toaz8M8EN+83hQTvb54wmQcyJlrmeU8h62ydnsVCrjsOeA27/G1ewzNUKByENDn
         6g+w==
X-Gm-Message-State: AIkVDXK1hHzNAFNvNFo6BoLXsz28aqz06WXVnP8g5sTUP5sLTNqMSSlI08Ke4TYELjZi4A==
X-Received: by 10.98.217.88 with SMTP id s85mr844079pfg.167.1484013649312;
        Mon, 09 Jan 2017 18:00:49 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 195sm450682pfa.6.2017.01.09.18.00.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 18:00:48 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3] MIPS: BMIPS: Add support SPI device nodes
Date:   Tue, 10 Jan 2017 11:00:31 +0900
Message-Id: <20170110020031.5473-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56246
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Hi all,

This series adds dependency with BMIPS_GENERIC for Broadcom MIPS based SoCs
and device nodes.

As far as I know the boards are booting from NAND by default except BCM97358,
BCM97360 and BCM97425, and therefore the SPI nodes for boot (qspi) of the boards
are disabled.

Changes in v3:
- Use decimal property instead of hexadecimal.

Changes in v2:
- Use upg_clk instead of new spi_clk.

 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
 16 files changed, 478 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index bbd00f65ce39..79f838ed96c5 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -91,15 +91,15 @@
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
@@ -226,5 +226,48 @@
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
+			clocks = <&upg_clk>;
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
index 4bbcc95f1c15..da7bfa45a57d 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -439,5 +439,48 @@
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
+			clocks = <&upg_clk>;
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
index 3e42535c8d29..9b05760453f0 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -318,5 +318,48 @@
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
+			clocks = <&upg_clk>;
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
index 112a5571c596..57b613c6acf2 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -358,5 +358,48 @@
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
+			clocks = <&upg_clk>;
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
index 34abfb0b07e7..c2a2843aaa9a 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -354,5 +354,48 @@
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
+			clocks = <&upg_clk>;
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
index b143723c674e..532fc8a15796 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -92,15 +92,15 @@
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
@@ -287,5 +287,48 @@
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
+			clocks = <&upg_clk>;
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
index 2488d2f61f60..f56fb25f2e6b 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -450,5 +450,48 @@
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
+			clocks = <&upg_clk>;
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
index 19fa259b968b..f2cead2eae5c 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -465,5 +465,48 @@
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
+			clocks = <&upg_clk>;
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
index ee4607fae47a..71357fdc19af 100644
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
+		spi-max-frequency = <40000000>;
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
index bed821b03013..e2fed406c6ee 100644
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
+		spi-max-frequency = <40000000>;
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
index f95ba1bf3e58..73aa006bd9ce 100644
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
+		spi-max-frequency = <40000000>;
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
