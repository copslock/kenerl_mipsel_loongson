Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 02:57:49 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32793 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993115AbcL0B5mFhh29 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2016 02:57:42 +0100
Received: by mail-pf0-f195.google.com with SMTP id 127so7413562pfg.0;
        Mon, 26 Dec 2016 17:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j3arsAzSBCZRErn2ocxzqtAz8eEhjEgDW32HwTS3htk=;
        b=Lbrkk5Cu/sbQI/ghfLhcu394Pv5z3n3YZHzNm4U99SSjYi3xIX9UZeaQkFuc+1U8Tm
         c8tcBzo73J6/zGPcAjTaNhfe7gFvnP57ac3YltK0l2bnRd5ojaWoUKHwVfuaKzEkvqJx
         s/l9OWpl3wwR5bOBzdlJTj4larnbNJIi6GStcABUMhvm2qk5QQ5Sa7/qLOdnklSq+9I8
         MCCHtLwI6DJX85KHXc7gUnVbap3Gu0OH+bBgZC8c11wOsXjbh6EzeMj3XZAjFs04T38u
         D4Bgbb1BFHtvC7nUBYAWHN1MXA5QVONMyMHpRGB8boxD/qEEy/NZT5V8zORemdDbqu8l
         6h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3arsAzSBCZRErn2ocxzqtAz8eEhjEgDW32HwTS3htk=;
        b=mV/1O451/gzp57LEvAOhH8l0fzrezzCkBWde/zLtwkbFlv56VnKymU6IZTgquh/TNq
         gLMi5bGX2RiHAI+6MOXiLjZ3LzUYEGU9WKefXZ+bIgLjh8Iw5hjVT6bf5n/tSDnvApxz
         rGZpYtTHpq+hhRNbGgy86Ws4bFlutR1TXp01tompLENkRaEBGonQMJdzNze/0Otag4hb
         ++VHx5w1pX6I9t9EJd3A/W7GCBPqA6vilIqHjXxiYbQR50mLO3fNoTVAp+MnH0oJlEWx
         31aD2i/Vc39I07OX+cMu2u7qW7Wni1JGE1dIrAkW3PO87jckcYrhrhD6z2xpA6Tb5nzk
         A1Vg==
X-Gm-Message-State: AIkVDXIWy5UHbMv3gZvyuoJSvaFjQyBTLvjXy3EbXazZnzpU3T4zLjT5dXF7IGpRNsw8dg==
X-Received: by 10.99.173.68 with SMTP id y4mr53960592pgo.54.1482803856003;
        Mon, 26 Dec 2016 17:57:36 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id c128sm84910178pfc.39.2016.12.26.17.57.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 17:57:35 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Add support watchdog device nodes
Date:   Tue, 27 Dec 2016 10:57:23 +0900
Message-Id: <20161227015723.578-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56122
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

Adds watchdog device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 7 +++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  | 4 ++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts | 4 ++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 4 ++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 4 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  | 4 ++++
 arch/mips/boot/dts/brcm/bcm97420c.dts     | 4 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  | 4 ++++
 16 files changed, 88 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index bbd00f65ce39..6a1ca7f2ee0f 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -197,6 +197,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4067e8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4067e8 0x14>;
+			status = "disabled";
+		};
+
 		upg_gio: gpio@406700 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406700 0x80>;
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 4bbcc95f1c15..3fb9f18f0698 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -232,6 +232,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4067e8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4067e8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 3e42535c8d29..ab3d25396b10 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -216,6 +216,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4066a8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4066a8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408240 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408240 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 112a5571c596..31668e85d6c6 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -208,6 +208,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4066a8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4066a8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 34abfb0b07e7..0f4b6adbbe6b 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -204,6 +204,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4066a8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4066a8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index b143723c674e..11a5bc46d42f 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -213,6 +213,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4067e8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4067e8 0x14>;
+			status = "disabled";
+		};
+
 		upg_gio: gpio@406700 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406700 0x80>;
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 2488d2f61f60..c9167f01a42d 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -231,6 +231,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4067e8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4067e8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 19fa259b968b..b337b8b7c3dd 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -246,6 +246,13 @@
 			status = "disabled";
 		};
 
+		watchdog: watchdog@4067e8 {
+			clocks = <&upg_clk>;
+			compatible = "brcm,bcm7038-wdt";
+			reg = <0x4067e8 0x14>;
+			status = "disabled";
+		};
+
 		aon_pm_l2_intc: interrupt-controller@408440 {
 			compatible = "brcm,l2-intc";
 			reg = <0x408440 0x30>;
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index 5c24eacd72dd..6521407c8d45 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -49,6 +49,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 /* FIXME: USB is wonky; disable it for now */
 &ehci0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index e67eaf30de3d..df5f20c8f8aa 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -58,6 +58,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index ee4607fae47a..d9d99e2e5866 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -54,6 +54,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index bed821b03013..4eb6e67ce2fd 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -49,6 +49,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 68fd823868e0..e78ab86b7212 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -46,6 +46,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index e66271af055e..b5c4811a5e2d 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -59,6 +59,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 /* FIXME: MAC driver comes up but cannot attach to PHY */
 &enet0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index f95ba1bf3e58..7b49c9f59839 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -60,6 +60,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index fb37b7111bf4..03c4703e61f4 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -60,6 +60,10 @@
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.11.0
