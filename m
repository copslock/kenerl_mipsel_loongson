Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:51:57 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64857 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826605Ab2KKMumzO7ba (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:42 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053456bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xmz1O2QVIuQOmJSmnius7L22W+kcHImXAJeV+wtsVWc=;
        b=j1S8IeMibYe/7FHeGEA8IlZCtXXeDkuWKRbCpBuc9cqr5OchEITr+w2hihJFBce/B3
         FcNZkSYX/qGlPFzUktqibZJpg24lVPlwutwqddOLeop4h+T0JoF3K0CgPYULD10vfjAK
         9GL6/3m+x2yh+ViAcKrKbHnEG5GI4fx5OfY+BPM1Hhr5nfSCGbFzh/oQU1tjVLK613k2
         8jwH3P73wWDexFrbK5sv/83KqgcPrEpQQNCc+5JOeJ2SwsiZmSdwIe2Bmw6Q7Rz9hYuH
         tO+21Hg/RqRt0J/sW+ntYrCBviOOj4qyjnZsIyj1AME4CtnqzVWwAYLMvxLguEFgeitN
         JU5g==
Received: by 10.204.11.141 with SMTP id t13mr5897803bkt.65.1352638237585;
        Sun, 11 Nov 2012 04:50:37 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.35
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:36 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: add simple Device Tree includes for all SoCs
Date:   Sun, 11 Nov 2012 13:50:36 +0100
Message-Id: <1352638249-29298-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add simple Device Tree include files for all currently supported SoCs.
These will be populated with device definitions as driver support
gets added.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dts/bcm6328.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6338.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6345.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6348.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6358.dtsi |   33 +++++++++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6368.dtsi |   33 +++++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dts/bcm6328.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6338.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6345.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6348.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6358.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6368.dtsi

diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
new file mode 100644
index 0000000..a0e1835
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6328.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Device Tree Include file for Broadcom BCM6328 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6328";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips4350", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@10000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10000000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/mips/bcm63xx/dts/bcm6338.dtsi b/arch/mips/bcm63xx/dts/bcm6338.dtsi
new file mode 100644
index 0000000..21772d9
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6338.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Device Tree Include file for Broadcom BCM6338 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6338";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips3300", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@fffe0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe0000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/mips/bcm63xx/dts/bcm6345.dtsi b/arch/mips/bcm63xx/dts/bcm6345.dtsi
new file mode 100644
index 0000000..f1e7153
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6345.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Device Tree Include file for Broadcom BCM6345 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6345";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips3300", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@fffe0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe0000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/mips/bcm63xx/dts/bcm6348.dtsi b/arch/mips/bcm63xx/dts/bcm6348.dtsi
new file mode 100644
index 0000000..8a5a2dc
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6348.dtsi
@@ -0,0 +1,30 @@
+/*
+ * Device Tree Include file for Broadcom BCM6348 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6348";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips3300", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@fffe0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe0000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/mips/bcm63xx/dts/bcm6358.dtsi b/arch/mips/bcm63xx/dts/bcm6358.dtsi
new file mode 100644
index 0000000..1d3f20f
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6358.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Device Tree Include file for Broadcom BCM6358 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6358";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips4350", "mips,mips4Kc";
+		};
+		cpu@1 {
+			compatible = "brcm,bmips4350", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@fffe0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xfffe0000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/mips/bcm63xx/dts/bcm6368.dtsi b/arch/mips/bcm63xx/dts/bcm6368.dtsi
new file mode 100644
index 0000000..a7624b9
--- /dev/null
+++ b/arch/mips/bcm63xx/dts/bcm6368.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Device Tree Include file for Broadcom BCM6368 SoC
+ *
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm6368";
+
+	cpus {
+		cpu@0 {
+			compatible = "brcm,bmips4350", "mips,mips4Kc";
+		};
+		cpu@1 {
+			compatible = "brcm,bmips4350", "mips,mips4Kc";
+		};
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
+	ubus@10000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10000000 0x20000>;
+		compatible = "simple-bus";
+	};
+};
-- 
1.7.2.5
