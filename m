Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:03:56 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39403 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009498AbaLYR5lf4pr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:41 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so12034345pac.11;
        Thu, 25 Dec 2014 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nn3Sq+haKiJOaCTEV6mFOKEnhGle7ohhxawN8dAVgco=;
        b=KNzfyifUDcpMqMRHPxFvR19JyFFWpooxCynD+ttNfNyFubi3OnE/0HgQA56wpRVNBl
         Y0lmR9i8nY1VLiH1a6mBHZfpQonqd2XM1pa4KR4TIsTic5Zw7nSIXH3sgD0vCzli1du9
         XVWv5OxiOhQoVIwubysiDf8kT6Mh21s1Bo+rT7KDdIhr+YAR69fRKfk01ZVwbxnk+HYi
         Gnhdxc5gCllZ3qKDvmywFNkoDVSpUWGb0pdbS4v2F4HqPhg/ZWQ8v5MIY1JkL7bZCOnS
         LvPqk8S8LCI8OsmFT/fuThZf8NBOjtB6LEdy6T1NNSx+BmqeQwIX2D0Rk7SoI/XPO6YY
         kqWQ==
X-Received: by 10.70.14.130 with SMTP id p2mr61886597pdc.101.1419530255946;
        Thu, 25 Dec 2014 09:57:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:35 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 23/25] MIPS: BMIPS: Refresh BCM3384 DTS files
Date:   Thu, 25 Dec 2014 09:49:18 -0800
Message-Id: <1419529760-9520-24-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

The DT bindings for this platform have changed as the bootloader and
product requirements evolved.  In particular, there are both
Linux-on-Zephyr and Linux-on-Viper configurations.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm3384.dtsi        | 109 ------------------------
 arch/mips/boot/dts/brcm/bcm3384_zephyr.dtsi | 126 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm93384wvg.dts     |   9 +-
 3 files changed, 127 insertions(+), 117 deletions(-)
 delete mode 100644 arch/mips/boot/dts/brcm/bcm3384.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm3384_zephyr.dtsi

diff --git a/arch/mips/boot/dts/brcm/bcm3384.dtsi b/arch/mips/boot/dts/brcm/bcm3384.dtsi
deleted file mode 100644
index 21b074a..0000000
diff --git a/arch/mips/boot/dts/brcm/bcm3384_zephyr.dtsi b/arch/mips/boot/dts/brcm/bcm3384_zephyr.dtsi
new file mode 100644
index 0000000..a7bd856
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm3384_zephyr.dtsi
@@ -0,0 +1,126 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm3384", "brcm,bcm33843";
+
+	memory@0 {
+		device_type = "memory";
+
+		/* Typical range.  The bootloader should fill this in. */
+		reg = <0x0 0x08000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* On BMIPS5000 this is 1/8th of the CPU core clock */
+		mips-hpt-frequency = <100000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	ubus {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "brcm,ubus", "simple-bus";
+		ranges;
+		dma-ranges = <0x00000000 0x08000000 0x08000000>,
+			     <0x08000000 0x00000000 0x08000000>;
+
+		periph_intc: periph_intc@14e00038 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x14e00038 0x4 0x14e0003c 0x4>,
+			      <0x14e00340 0x4 0x14e00344 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		zmips_intc: zmips_intc@104b0060 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x104b0060 0x4 0x104b0064 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <29>;
+			brcm,int-map-mask = <0xffffffff>;
+		};
+
+		iop_intc: iop_intc@14e00058 {
+			compatible = "brcm,bcm3380-l2-intc";
+			reg = <0x14e00058 0x4 0x14e0005c 0x4>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <6>;
+			brcm,int-map-mask = <0xffffffff>;
+		};
+
+		uart0: serial@14e00520 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x14e00520 0x18>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <2>;
+			clocks = <&periph_clk>;
+			status = "disabled";
+		};
+
+		ehci0: usb@15400300 {
+			compatible = "brcm,bcm3384-ehci", "generic-ehci";
+			reg = <0x15400300 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <41>;
+			status = "disabled";
+		};
+
+		ohci0: usb@15400400 {
+			compatible = "brcm,bcm3384-ohci", "generic-ohci";
+			reg = <0x15400400 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <40>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/brcm/bcm93384wvg.dts b/arch/mips/boot/dts/brcm/bcm93384wvg.dts
index 8317411..d1e44a1 100644
--- a/arch/mips/boot/dts/brcm/bcm93384wvg.dts
+++ b/arch/mips/boot/dts/brcm/bcm93384wvg.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "bcm3384.dtsi"
+/include/ "bcm3384_zephyr.dtsi"
 
 / {
 	compatible = "brcm,bcm93384wvg", "brcm,bcm3384";
@@ -10,13 +10,6 @@
 		bootargs = "console=ttyS0,115200";
 		stdout-path = &uart0;
 	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x04000000>;
-		dma-xor-mask = <0x08000000>;
-		dma-xor-limit = <0x0fffffff>;
-	};
 };
 
 &uart0 {
-- 
2.1.1
