Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 04:18:59 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35775 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992149AbcHHCRxzRJOX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 04:17:53 +0200
Received: by mail-pa0-f67.google.com with SMTP id cf3so22997298pad.2;
        Sun, 07 Aug 2016 19:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y4xF0bFy1ZmKLJ4sUhL43DyHyuhi2kdWOruS9oX6H6U=;
        b=aeNXoJiEc6rC6k3BycB+Ig5WtYokpMA0WmdmbuOQho8c6b6pQ9yDOHXcFeXZfr4EDm
         HCbYOwbuuKtu+1WcsR4J1gf8F/pDU+8duEdK+Mu8lMRCeGi7Zi7xR9eejLeBLseWFBXO
         +wLX0oK4jSqbAwCQnoeHMTMeqa600uVgZqa0ymxd8q4baGC2MgITblE1r/DLt3babpIc
         YGjReyIwkF+65KL3XWuuBoSbuiiPCspZK8N8wfVOsQRIYHX87xcz+XNN8W8qvK2wO517
         ThA1Ym/+71I5EfVtBWsg2Q1yVXqzyu3ne28jC/JsLjlI2Nn6vdE0bLBBT5xuYdWrdpPb
         NuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y4xF0bFy1ZmKLJ4sUhL43DyHyuhi2kdWOruS9oX6H6U=;
        b=bFXNIe4mrVoYFpInuEQlIGFs2l0J5OlQqHT/6zXvR5bLiuWghphRbkDqPe/A/eT+mb
         DqsjfrmrxL7MERtKZDyZBm8WGAZK2vfG4bxu80qyCPwwSsEjyVgYuOz44g4WSru/r5xG
         Ryji/2bViU2ggLH6XCcDyxP1I5b5svi276l/FGWqAhow1Ca+pvF2Rm26a1wK6W4foRfO
         x15BWrcZBbOI7D+tZQ43C/eYyKrjJRnfQwa4+vAYAe4HUIAKOvNvdMu2yao1wElsEQ4B
         HTyHwCsTAWvfFwNmugceHkvuZod2wN8mX9KKyQtIq2zGywq8tdIdTrAdny09PfW750aC
         ds3w==
X-Gm-Message-State: AEkoousY2L/3JIWkAmDobDKPVypC6fIUt3l2PpeMWeh3q5aDc92CkvkrQaFbuvmoOJWbQw==
X-Received: by 10.66.135.40 with SMTP id pp8mr159624093pab.113.1470622667935;
        Sun, 07 Aug 2016 19:17:47 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id r2sm12701468pal.14.2016.08.07.19.17.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 19:17:47 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/4] MIPS: BMIPS: Add support SDHCI device nodes
Date:   Mon,  8 Aug 2016 11:17:18 +0900
Message-Id: <20160808021719.4680-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160808021719.4680-1-jaedon.shin@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54421
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

Adds SDHCI device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 20 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 20 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 ++++++++
 10 files changed, 92 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 1ef7540238be..30af896ddb60 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -411,5 +411,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@413500 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x413500 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <85>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 0aeb3de7fbc2..05d868cbb5c0 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -330,5 +330,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@410000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x410000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <82>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 9a1f6ffc343d..ff555e52c088 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -326,5 +326,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@410000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x410000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <82>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 04306a92b8eb..4e387d05bb5b 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -410,5 +410,25 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@419000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x419000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <43>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci@419200 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x419200 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <44>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index c4883643ab61..d3130f7b7b70 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -425,5 +425,25 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@41a000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x41a000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <47>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci@41a200 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x41a200 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index e91a21f75a13..ee4867ec03c4 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -108,3 +108,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index a445a45f51cb..bb1e0474510d 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -76,3 +76,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 22b1b506594f..1c7c15679dff 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -72,3 +72,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 6adfcd505a03..b9222f72d063 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -102,3 +102,11 @@
 &ohci3 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index dd8b8fb97053..6bca6449f86a 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -110,3 +110,11 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+};
-- 
2.9.2
