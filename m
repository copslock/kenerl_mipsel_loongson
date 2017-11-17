Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 03:21:20 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:37102
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbdKQCULwSnrV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 03:20:11 +0100
Received: by mail-pf0-x241.google.com with SMTP id t69so806716pfg.4;
        Thu, 16 Nov 2017 18:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/jx8nJQg54pvkLa4y9XYph1+Lag4XN4pwfRwx+H3dfA=;
        b=CQoBS2dv4FljeZLFSMaRnZ9HqP51ULi9eVxknVkZdxYj40i7RHBwWDTK/dutLXbjho
         FSWjGJ79ZhF7WuFgCi1e5Kl6NKXyluISfvDVkJBOe2f56J1AFnaJ/psFHGfa/HLdLZRw
         isSVzd1jmi/1D/LpRSh9OaCHEZQDianFZ5IGDVpyMCGwfJRRjPEC+xH/iYPFqu3SeLgL
         IwEYJlUqwkII/VGl+nPCdJNQDoF8G8otbmNpILwDeXwhvWVJCLb/wTEqVxR8h+rxgt8W
         nHt+2DWf+9rJWFs17QqkKzVO5VB/J+9LdW5Szp3pki8gOqNpKVb2+5nnwPXb8tSkro/I
         xB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/jx8nJQg54pvkLa4y9XYph1+Lag4XN4pwfRwx+H3dfA=;
        b=PhSUf6WcC6svTFFagao5+ysNV2I7w8z6wHBFsb0gh3pEl29u/PSE4zy3aaryuh1rxF
         /kmAMS0Dc5tBzPtgRUmBltnf31OHLnS7jnPMft4F7zFsKHsjU7HUdWnvh8AMXjhlkQja
         cxWpK9gxHC/YQ6VKyFxBlR9JaDyLenYk5sX85GoA8ab8NA8IgggRp8kWkFwqCTWh4M33
         apGtnfQ+bJFj9LBrF0K8nEtY7KyUHPFPbjeCygpdfJxnTY2slkORZR0ngz8k0ehKYgKo
         3BPM08PW4DJJFFaHs0F/1O3S9jDiHTQ/KS2Y6g6V2LttOOM9d/8gmppfZNIi5QZb9jBR
         QtBQ==
X-Gm-Message-State: AJaThX6KtdUUaczAu6IuMRWkO81cX1JNtjeooZ6gsZfcTTNpL7oXmRFj
        uU9f2GyAgCZcpUX3jGGb917EQnvq
X-Google-Smtp-Source: AGs4zMaqgWSEpPqkz7zhYc52ap4jZ/7Z+v28V1L+s5mfOSYDEU3Dt/cMBzFGgoaFIa3K6meAYjX1WQ==
X-Received: by 10.99.37.69 with SMTP id l66mr3768246pgl.14.1510885205186;
        Thu, 16 Nov 2017 18:20:05 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id s4sm5393280pgp.40.2017.11.16.18.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 18:20:04 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/3] MIPS: BMIPS: Add Broadcom STB watchdog nodes
Date:   Fri, 17 Nov 2017 11:19:44 +0900
Message-Id: <20171117021944.894-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117021944.894-1-jaedon.shin@gmail.com>
References: <20171117021944.894-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60982
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
index 2f9ef565e5d0..5bf77b6fcceb 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -198,6 +198,13 @@
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
index 228184dedada..2afa0dada575 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -233,6 +233,13 @@
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
index 398521c7070f..6375fc77f389 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -217,6 +217,13 @@
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
index 28f5a0c1c149..a57cacea91cf 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -209,6 +209,13 @@
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
index ab2dd57571a0..728b9e9f84b8 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -205,6 +205,13 @@
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
index d262e11bc3f9..9540c27f12e7 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -214,6 +214,13 @@
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
index 23479f988aa5..410e61ebaf9e 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
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
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index af75b0123c06..8398b7f68bf4 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -247,6 +247,13 @@
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
index 7f59ea2ded6c..79e9769f7e00 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -50,6 +50,10 @@
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
index b50dbb3cbeee..28370ff77eeb 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -59,6 +59,10 @@
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
index 2986ce353e57..41c1b510c230 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -55,6 +55,10 @@
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
index 8d48ae317b8c..9f6c6c9b7ea7 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -50,6 +50,10 @@
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
index 4a1d0631e9e6..df8b755c390f 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -47,6 +47,10 @@
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
index f96241e94874..086faeaa384a 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -60,6 +60,10 @@
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
index 488e12a9e4aa..0ed22217bf3a 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -61,6 +61,10 @@
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
index e14337cc51fd..2c145a883aef 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -61,6 +61,10 @@
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
2.15.0
