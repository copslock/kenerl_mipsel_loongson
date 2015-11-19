Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:37:30 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33135 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011975AbbKSCflP6NrC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:41 +0100
Received: by pabfh17 with SMTP id fh17so66577293pab.0;
        Wed, 18 Nov 2015 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCJZEPigcrn6dZ1WnHRCGnoU9nXpNcmlmkTfckUtsjw=;
        b=Rw3SVBkFvB49QP/C21sOHbJ08GygfxcdSy07MhGfuX54D0a/m5FCvnA+qMh7OTUlwY
         KBuGxL5Ze9mmnA+35Poce+G+Tx3VCnmgqWMo9cB0SBMoRLG6TR08Ucq1cmoEUfC3tHe0
         w0yXywVN2SpD4nOvuJ7SNEeIjYA/FMogETcNHkK/TusPONn/1BxEldWw3hD6Q7Kzte25
         hUZd98mfRrMhKI8WEKTfbsBAsofCQuTGXaQa5KT2lVAkiR7NEd+S6XWwpacfW9cn8WI8
         BT82AtfPIRNTm24UE9ZMkO/H6tFaTgzqAlkovlS8laKo8CbF+pJIbZWgt7nv9T8uXqzX
         ASLA==
X-Received: by 10.68.166.99 with SMTP id zf3mr7024743pbb.58.1447900535596;
        Wed, 18 Nov 2015 18:35:35 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:35 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 7/7] MIPS: BMIPS: add device tree entry for BCM7xxx SATA
Date:   Thu, 19 Nov 2015 11:34:53 +0900
Message-Id: <1447900493-1167-8-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49991
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

Add SATA device tree entries for bcm7360 and bcm7435 MIPS-baed set-top
box platforms. The bcm7346, bcm7362 and bcm7425 device tree files are
already added.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7360.dtsi     | 40 ++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 40 ++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  8 +++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 90b1b038a41a..ba52ab10ad3a 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -239,5 +239,45 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <86>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@180100 {
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index bca3989c560b..eb7325546d70 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -325,5 +325,45 @@
 			interrupts = <78>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <45>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@180100 {
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index d48462e091f1..73124be9548a 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -56,3 +56,11 @@
 &ohci0 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 743d796ec70f..13553ab2d0fd 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -86,3 +86,11 @@
 &ohci3 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.6.3
