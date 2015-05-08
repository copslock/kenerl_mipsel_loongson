Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 15:01:05 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33624 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026555AbbEHNAfQmOEe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 15:00:35 +0200
Received: by pdbnk13 with SMTP id nk13so81666873pdb.0;
        Fri, 08 May 2015 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7BsfCIwMjeqB0ocf+KCtvSFyclloHhm4YbdbdnTvVg=;
        b=g4k3fEKESbhatjfEBPESozUxOZm/3PV/f96i+DIWooqO5dJl//RjMb90O2My8VfXTC
         k6O8u1v/laiqwT9ftq/N9RcACEp0lf6EU8Upk8R31hpdKP99LDypAN8amQrnvhtIKIR/
         2EKHxxVv7RrndfSto8GC9bHCYS3E/UuLd8K+2/ouqGsK4i4nKLAbgTr5vgB8rO/XI2tw
         a35a/9qGaLyAL2s4bvI2hmecF2tH1qeMm3/aScu+ZOyzMDzRF8VI3AnZDIy37zTLNtqF
         JAOBAkh2/ICyt7koe+BG4enL5Wq74PEc/Lybdv4vTqh4q6znLsFVi1v9SlvlAjtOs78b
         zKpQ==
X-Received: by 10.70.133.66 with SMTP id pa2mr6397115pdb.164.1431089970162;
        Fri, 08 May 2015 05:59:30 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by mx.google.com with ESMTPSA id i16sm5182237pbq.79.2015.05.08.05.59.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 05:59:29 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: dts: add uart device nodes to bcm7xxx platforms
Date:   Fri,  8 May 2015 21:59:18 +0900
Message-Id: <1431089958-2626-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47278
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

Add two uart device nodes known as the uart1 and uart2 for the bcm7xxx
platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 ++++++++
 8 files changed, 136 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 1f30728a3177..d817bb46b934 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -24,6 +24,8 @@
 
 	aliases {
 		uart0 = &uart0;
+		uart1 = &uart1;
+		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
@@ -118,6 +120,30 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406940 {
+			compatible = "ns16550a";
+			reg = <0x406940 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <65>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406980 {
+			compatible = "ns16550a";
+			reg = <0x406980 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <66>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 2c2aa9368f76..277a90adc1a7 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -18,6 +18,8 @@
 
 	aliases {
 		uart0 = &uart0;
+		uart1 = &uart1;
+		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
@@ -112,6 +114,30 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406840 {
+			compatible = "ns16550a";
+			reg = <0x406840 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406880 {
+			compatible = "ns16550a";
+			reg = <0x406880 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <63>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index f23b0aed276f..9e1e571ba346 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -18,6 +18,8 @@
 
 	aliases {
 		uart0 = &uart0;
+		uart1 = &uart1;
+		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
@@ -112,6 +114,30 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406840 {
+			compatible = "ns16550a";
+			reg = <0x406840 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406880 {
+			compatible = "ns16550a";
+			reg = <0x406880 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <63>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index da99db665bbc..6e65db86fc61 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -24,6 +24,8 @@
 
 	aliases {
 		uart0 = &uart0;
+		uart1 = &uart1;
+		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
@@ -118,6 +120,30 @@
 			status = "disabled";
 		};
 
+		uart1: serial@406840 {
+			compatible = "ns16550a";
+			reg = <0x406840 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <62>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@406880 {
+			compatible = "ns16550a";
+			reg = <0x406880 0x20>;
+			reg-io-width = <0x4>;
+			reg-shift = <0x2>;
+			native-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <63>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 70f196d89d26..3fe0445b9d37 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
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
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index d18e6d947739..a8dc01e30313 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
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
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 4fe515500102..eee8b0e32681 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
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
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index ab8b01fa7dcf..dd408413e922 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
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
 &enet0 {
 	status = "okay";
 };
-- 
2.4.0
