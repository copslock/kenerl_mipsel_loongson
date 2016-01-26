Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:47:21 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60905 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011649AbcAZWrDMjeXl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 23:47:03 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOCNz-0004K0-Lu; Tue, 26 Jan 2016 22:46:56 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOCNw-0006VB-SD; Tue, 26 Jan 2016 22:46:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Date:   Tue, 26 Jan 2016 22:46:50 +0000
Message-Id: <1453848410-24949-2-git-send-email-broonie@kernel.org>
X-Mailer: git-send-email 2.7.0.rc3
In-Reply-To: <1453848410-24949-1-git-send-email-broonie@kernel.org>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian behaviour for syscon
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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

On many MIPS systems the endianness of IP blocks is kept the same as
that of the CPU by the hardware.  This includes the system controllers
on these systems which are controlled via syscon which uses the regmap
API which used readl() and writel() to interact with the hardware,
meaning that all writes are converted to little endian when writing to
the hardware.  This caused a bad interaction with the regmap core in big
endian mode since it was not aware of the byte swapping and so ended up
performing little endian writes.

Unfortunately when this issue was noticed it was addressed by updating
the DT for the affected devices to specify them as little endian.  This
happened to work since it resulted in two endianness swaps which
cancelled each other out and gave little endian behaviour but meant that
the DT was clearly not accurately describing the hardware.

The intention of commit 29bb45f25ff305 (regmap-mmio: Use native
endianness for read/write) was to fix this by making regmap default to
native endianness but this breaks most other MMIO users where the
hardware has a fixed endianness and the implementation uses the __raw
accessors which are not intended to be used outside of architecture
code.  Instead use the newly added native-endian DT property to say
exactly what we want for these systems.

Fixes: 29bb45f25ff305 (regmap-mmio: Use native endianness for read/write)
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

Posted for review only, this will interact with some other patches
fixing the implementation of regmap-mmio and will probably need to be
merged along with them.

 arch/mips/boot/dts/brcm/bcm6328.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7125.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7420.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 1 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index d52ce3d07f16..04867035ea0e 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -73,6 +73,7 @@
 		timer: timer@10000040 {
 			compatible = "syscon";
 			reg = <0x10000040 0x2c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
index 4fc7ecee273c..3ae16053a0c9 100644
--- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
@@ -98,6 +98,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7125-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x60c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index a3039bb53477..be7991917d29 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -118,6 +118,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7346-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 4274ff41ec21..060805be619a 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -112,6 +112,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7358-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 0dcc9163c27b..bcdb09bfe07b 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -112,6 +112,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7360-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 2f3f9fc2c478..d3b1b762e6c3 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -118,6 +118,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7362-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
index bee221b3b568..3302a1b8a5c9 100644
--- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
@@ -99,6 +99,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7420-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x60c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 571f30f52e3f..15b27aae15a9 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -100,6 +100,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 614ee211f71a..adb33e355043 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -114,6 +114,7 @@
 		sun_top_ctrl: syscon@404000 {
 			compatible = "brcm,bcm7425-sun-top-ctrl", "syscon";
 			reg = <0x404000 0x51c>;
+			native-endian;
 		};
 
 		reboot {
-- 
2.7.0.rc3
