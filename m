Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2016 12:57:55 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35466 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025904AbcDIK5yRfj2n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Apr 2016 12:57:54 +0200
Received: by mail-wm0-f67.google.com with SMTP id a140so9827557wma.2;
        Sat, 09 Apr 2016 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cySCB40Le8JQGs/KDjAvL6u71a4d/kNxd+idshSQvdk=;
        b=AvCZI2aKhkviA/jEJ1/P1xoAxYV/ifclS2Y8ZFl5Zc+gUjwTeSnZDCOBii4FVnjIfH
         YIyc+cvlHA9wak/nhkKwVuW+xeQyll8jrpSn0NW3Gaw0Qr7mY604QxWsbuDXZt8ehSb5
         41A/I2oCGkSXRaptS4ybqkoqzqtlOQVZ3inbueF+rkzGi2Hz88jW6K29g/2wyplP+GCy
         /xCbnzdC13F1Js5GgRfKPj6skxp88sqQ577LHJIVabiab4TPP0cMloKQXH/8Afk1NEow
         BxuOhz100Y1t2W8skz1mEimT3OO2LfRALt1RPQitS6Z43YDXvGoQOcnehSzvjAfsCTYQ
         1ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cySCB40Le8JQGs/KDjAvL6u71a4d/kNxd+idshSQvdk=;
        b=R67MNhXW6wrQP4FVLbKtYMsoWl/4oYhknIE7Q3DGrBBlQmpx9O0PfZso/UKoVk3grH
         dRyh2HXZjLWpWrtTaPuMQPTC9qqN7O4hG/cfERz3MxhWPTa97nC44m8lA3xS0T+Sb0w9
         70MobdAeV54Imo6VC7zGYl3AGLr8Q0rW9nrKB39Vq18SdY0XQEL7+Fp0CjJuoRgFGPEY
         ePo5BA4bYdbBLZleZ59RiIVBVFL7w6H8LXqH11sFTxYTvKcvLKT8B8M4VgA636M6wjph
         kEk8kWZJKCVrrYWlrCVEGXvxxrAzlgSRSH3Q2WgB0d/OB5C+keJajI7PEd8HZpHC4tKk
         bcmA==
X-Gm-Message-State: AD7BkJKiRvOXMOhh4EtTZCAnRhFmisnlJ1sKD4w0sakpnwSdTPY2jQJa+yYSCiZrDyXkXA==
X-Received: by 10.194.236.198 with SMTP id uw6mr14370985wjc.42.1460199469046;
        Sat, 09 Apr 2016 03:57:49 -0700 (PDT)
Received: from localhost.localdomain (228.Red-83-55-41.dynamicIP.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id m134sm7233980wmd.14.2016.04.09.03.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 03:57:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: improve BCM6328 device tree
Date:   Sat,  9 Apr 2016 12:57:48 +0200
Message-Id: <1460199469-18880-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459685585-11747-1-git-send-email-noltari@gmail.com>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

- Remove unneeded leds0 alias.
- Switch to bcm6345-l1-intc interrupt controller.
- Use interrupt-controller instead of periph_intc and cpu_intc.
- Add uart1, ehci and ohci nodes.
- Refactor syscon and syscon-reboot.
- Avoid using underscores in node names.
- Rename uart aliases to serial.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: more device tree improvements
  - There is just ohci/ehci node.
  - Avoid using underscores in node names.
  - Use interrupt-controller for cpu_intc.
  - Rename uart aliases to serial.

 arch/mips/boot/dts/brcm/bcm6328.dtsi | 50 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index 9d19236..5633b9d 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -23,7 +23,7 @@
 	};
 
 	clocks {
-		periph_clk: periph_clk {
+		periph_clk: periph-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <50000000>;
@@ -31,11 +31,11 @@
 	};
 
 	aliases {
-		leds0 = &leds0;
-		uart0 = &uart0;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
-	cpu_intc: cpu_intc {
+	cpu_intc: interrupt-controller {
 		#address-cells = <0>;
 		compatible = "mti,cpu-interrupt-controller";
 
@@ -50,16 +50,16 @@
 		compatible = "simple-bus";
 		ranges;
 
-		periph_intc: periph_intc@10000020 {
-			compatible = "brcm,bcm3380-l2-intc";
-			reg = <0x10000024 0x4 0x1000002c 0x4>,
-			      <0x10000020 0x4 0x10000028 0x4>;
+		periph_intc: interrupt-controller@10000020 {
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0x10000020 0x10>,
+			      <0x10000030 0x10>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&cpu_intc>;
-			interrupts = <2>;
+			interrupts = <2>, <3>;
 		};
 
 		uart0: serial@10000100 {
@@ -71,13 +71,22 @@
 			status = "disabled";
 		};
 
-		timer: timer@10000040 {
+		uart1: serial@10000120 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x10000120 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <39>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		timer: syscon@10000040 {
 			compatible = "syscon";
 			reg = <0x10000040 0x2c>;
 			native-endian;
 		};
 
-		reboot {
+		reboot: syscon-reboot@10000068 {
 			compatible = "syscon-reboot";
 			regmap = <&timer>;
 			offset = <0x28>;
@@ -91,5 +100,24 @@
 			reg = <0x10000800 0x24>;
 			status = "disabled";
 		};
+
+		ehci: usb@10002500 {
+			compatible = "brcm,bcm6328-ehci", "generic-ehci";
+			reg = <0x10002500 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <42>;
+			status = "disabled";
+		};
+
+		ohci: usb@10002600 {
+			compatible = "brcm,bcm6328-ohci", "generic-ohci";
+			reg = <0x10002600 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <41>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
