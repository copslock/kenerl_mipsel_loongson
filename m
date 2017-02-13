Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 00:11:28 +0100 (CET)
Received: from smtp6-g21.free.fr ([IPv6:2a01:e0c:1:1599::15]:8107 "EHLO
        smtp6-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993876AbdBMXLWRSYD7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 00:11:22 +0100
Received: from localhost.localdomain (unknown [78.54.29.3])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id C8A10780217;
        Tue, 14 Feb 2017 00:11:05 +0100 (CET)
From:   Alban <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ath79: Use the IRQ based GPIO key driver for the buttons
Date:   Tue, 14 Feb 2017 00:10:37 +0100
Message-Id: <1487027453-10194-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

From: Alban Bedel <albeu@free.fr>

Now that the GPIO driver support interrupts we don't need to poll the
buttons.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 3 +--
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts     | 5 ++---
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 5 ++---
 arch/mips/boot/dts/qca/ar9331_omega.dts          | 5 ++---
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 5 ++---
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 3c3b7ce..ed8791a 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -21,11 +21,10 @@
 	};
 
 	gpio-keys {
-		compatible = "gpio-keys-polled";
+		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		poll-interval = <20>;
 		button@0 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index 98e7450..86bf1aa 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -28,11 +28,10 @@
 		};
 	};
 
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
+	gpio-keys {
+		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <100>;
 
 		button@0 {
 			label = "reset";
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 56f8320..7970f6b 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -46,11 +46,10 @@
 		};
 	};
 
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
+	gpio-keys {
+		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <100>;
 
 		button@0 {
 			label = "jumpstart";
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index b2be3b0..6779291 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -28,11 +28,10 @@
 		};
 	};
 
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
+	gpio-keys {
+		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <100>;
 
 		button@0 {
 			label = "reset";
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index 919cf3b..86d55d1 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -46,11 +46,10 @@
 		};
 	};
 
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
+	gpio-keys {
+		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <100>;
 
 		button@0 {
 			label = "wps";
-- 
2.7.4
