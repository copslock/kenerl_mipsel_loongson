Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 04:53:16 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35007 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992211AbcHSCwugADoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 04:52:50 +0200
Received: by mail-pa0-f65.google.com with SMTP id cf3so2668900pad.2;
        Thu, 18 Aug 2016 19:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3huXaJUqbwDdOL/115nP9GiQTMsTEVs6A3u67QvB8Kk=;
        b=kuUPnuAKFPJ1+KiUlp0wUrgvbSqgS1lVhu1B3kPRG4mM5JTgoVB4MLu63HsJsQVOEQ
         78NBj+pFa2VLYqkoQBacrXg2fbG+kQDcMDSQuOnyfVunTr8HTlCZa/blp+PypUGiWgz4
         4B2RTsFtmxmDZCF57zHEj/FciexagxLjIYZXoY0FfkfSZ9NJ1nMgSBnLA3QL0MAmDB/M
         ldp2Y5QPIdZrFSvtA+Iy6ViRyJdDc4U9bEvLjFUZ8eweklJH8JY++ofTcQH/bkdhBJeY
         Zrr6Jr8Xz1YZn6Bu+Oc7vx7LqWJJtmxWWPnSiwKa/8N0cF2DGX+UYxyAmsZe87yGZK0X
         0MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3huXaJUqbwDdOL/115nP9GiQTMsTEVs6A3u67QvB8Kk=;
        b=Tqwsc/NYBpQgPp1FugmJQ217NVJd1tXGoFtXupbcGam6FhoORYAYTsnPWpCX+2VoRH
         0iyhGwowH/yP8Mt4u2E1yEfLpPWPS9Ks7yvXb7nmddqSdgoRbCg1BlQP6hJhvgQ+qLRT
         Rq7Fk0RHJ8IPcz4pFLWKIDjHguYaMLKQFjhECa0DTruuQOjmH0DXHIT3cdFDYiPlVIpx
         z0lsp0IXPiMkFO+KoXlWvtzrCjuZgI/He3bZqDTZU3m/keuOpG/6SPgoWQBI0dzQJ+rU
         hXb2g+kD/vWkH+OWAPW5fgzhSpDGST/By5hCnU2h4gns3VWcQyFxeDXKZ1oL8qrH/0i7
         +nwA==
X-Gm-Message-State: AEkoouvYCmJAsDJgVQbnaY4mviu3GniVaoaHio7NMRSxAwBnHpXO3Y64ex+hu4o7sd0xuw==
X-Received: by 10.66.88.131 with SMTP id bg3mr9520810pab.43.1471575164496;
        Thu, 18 Aug 2016 19:52:44 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 132sm1886744pfu.6.2016.08.18.19.52.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 19:52:44 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 1/5] MIPS: BMIPS: Add support PWM device nodes
Date:   Fri, 19 Aug 2016 11:52:26 +0900
Message-Id: <20160819025230.31882-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819025230.31882-1-jaedon.shin@gmail.com>
References: <20160819025230.31882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54670
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

Adds PWM device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 14 ++++++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 14 ++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 14 ++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 ++++++++
 16 files changed, 204 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 550e1d9e3ee0..97191f6bca28 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -183,6 +189,14 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406580 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406580 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		ehci0: usb@488300 {
 			compatible = "brcm,bcm7125-ehci", "generic-ehci";
 			reg = <0x488300 0x100>;
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index ec959061d52e..eb7b19a32e3e 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -210,6 +216,22 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406580 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406580 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
+		pwmb: pwm@406800 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406800 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index ca57fb5eb122..b2276b1e12d4 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -34,6 +34,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -194,6 +200,22 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406400 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406400 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
+		pwmb: pwm@406700 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406700 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 1c0c3d438c7a..e414af1e14ff 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -34,6 +34,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -194,6 +200,14 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406400 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406400 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 6b4713add4b8..3bd1c0111d43 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -190,6 +196,14 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406400 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406400 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index 0586bf662571..27c3d45556b9 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -191,6 +197,22 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406580 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406580 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
+		pwmb: pwm@406880 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406880 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@468000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index c1c15edaf829..9ab65d64e948 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -40,6 +40,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -209,6 +215,22 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406580 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406580 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
+		pwmb: pwm@406800 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406800 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index a874d3a0e2ee..7801169416e7 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -52,6 +52,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <81000000>;
 		};
+
+		upg_clk: upg_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
 	};
 
 	rdb {
@@ -224,6 +230,22 @@
 		      status = "disabled";
 		};
 
+		pwma: pwm@406580 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406580 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
+		pwmb: pwm@406800 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x406800 0x28>;
+			#pwm-cells = <2>;
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
+
 		enet0: ethernet@b80000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
index f2449d147c6d..5c24eacd72dd 100644
--- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
@@ -45,6 +45,10 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
 /* FIXME: USB is wonky; disable it for now */
 &ehci0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index d3d28816a027..2c55ab094a29 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -49,6 +49,14 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
+&pwmb {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index 02ce6b429dc4..757fe9d5f4df 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -45,6 +45,14 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
+&pwmb {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 73124be9548a..496e6ed9fae3 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -45,6 +45,10 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 3cfcaebe7f79..b880c018f3d8 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -41,6 +41,10 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
index 600d57abee05..e66271af055e 100644
--- a/arch/mips/boot/dts/brcm/bcm97420c.dts
+++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
@@ -51,6 +51,14 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
+&pwmb {
+	status = "okay";
+};
+
 /* FIXME: MAC driver comes up but cannot attach to PHY */
 &enet0 {
 	status = "disabled";
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 119c714805cb..f091e91b11c5 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -51,6 +51,14 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
+&pwmb {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 43e3ba27f07b..9db84f2a6664 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -51,6 +51,14 @@
 	status = "okay";
 };
 
+&pwma {
+	status = "okay";
+};
+
+&pwmb {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.9.3
