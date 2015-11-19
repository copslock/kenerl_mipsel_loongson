Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:36:53 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36577 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012500AbbKSCffrUfyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:35 +0100
Received: by pacdm15 with SMTP id dm15so64435488pac.3;
        Wed, 18 Nov 2015 18:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=harJRVoiRbD8EfAXz7zBBkp/Us3VYxM6/lV8hoP2u1Q=;
        b=0BwqFTZprZIxDYxOur21S2uxKBXVsrpXCv+ObGRrqF3J2X2HLu+ho0wO3JFwkdelmv
         MDX3+80FRdDJSkKH/TsxD66cWaQVFxIZSAUdjhrUMoVuk2aBXC1gfvBCA2aWhGkClGPB
         4DWu9fBrFIYwFWCA3WRYdUCJQO+1gfRe3l8nZKFWqnGzzcihSZF147GC1hb1FBUyJQty
         4yUkhyrYnhTHZQm7GKjL+Gyx+Oa6Q5LTWZCxqJytOlTiWo3UGz5hMgEKIuph8U5+rt8s
         /tA9z9b9VUgpOA58TBGXLzCy6GEvDjrQMpWxU0XKjN0Ss/KjE5C+eNP5Fx8NkOp6qkrx
         pOhg==
X-Received: by 10.66.251.226 with SMTP id zn2mr7066437pac.44.1447900529851;
        Wed, 18 Nov 2015 18:35:29 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:29 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 5/7] MIPS: BMIPS: add device tree entry for BCM7xxx UART
Date:   Thu, 19 Nov 2015 11:34:51 +0900
Message-Id: <1447900493-1167-6-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49989
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

Add UART device tree entries for bcm7215, bcm7420, bcm7425 and bcm7435
MIPS-based set-top box platforms. The bcm7346, bcm7358, bcm7360 and
bcm7362 device tree files are already added.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi     | 24 ++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi     | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97420c.dts    |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  8 ++++++++
 8 files changed, 122 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 1a7efa883c5e..50c7f95b0f56 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -118,6 +118,30 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <64>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		ehci0: usb@488300 {
 			compatible = "brcm,bcm7125-ehci", "generic-ehci";
 			reg = <0x488300 0x100>;
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 5f55d0a50a28..34f827b6bb7f 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -118,6 +118,28 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <64>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@468000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index dfadd04d56d1..11bc37c9a2dc 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -119,6 +119,28 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <63>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8b9432cc062b..9c4f8a75435f 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -133,6 +133,28 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406b40 {
+			compatible = "ns16550a";
+			reg = <0x406b40 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <67>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406b80 {
+			compatible = "ns16550a";
+			reg = <0x406b80 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <68>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index e046b1109eab..4d0a306ad41e 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -21,6 +21,14 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
 /* FIXME: USB is wonky; disable it for now */
 &ehci0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index 67fe1f3a3891..6e9fa319d140 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -23,6 +23,14 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
 /* FIXME: MAC driver comes up but cannot attach to PHY */
 &enet0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 689c68a4f9c8..4c47364eece9 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -23,6 +23,14 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 1df088183523..7b5c364bdbd1 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -23,6 +23,14 @@
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.6.3
