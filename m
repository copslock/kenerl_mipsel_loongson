Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 23:00:18 +0100 (CET)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33490 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbcBMV6hVczdi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:37 +0100
Received: by mail-lb0-f195.google.com with SMTP id bc4so4977554lbc.0;
        Sat, 13 Feb 2016 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qm9W0hj59wlYnXNykoJwIOmAIf4DkF+Pf8JTpO9Mxo8=;
        b=M0yD2+BGwKtSere+kQtz6pNn4QwqOeVLgZoFaiaVgNK4JI6aWY18Z9zw6111yvatGT
         SEMMqGiArh/bGjeR8QkWEP5i6ECnjT2O2jLHRbGqWKZMOej+GAFayAwje47rW1DjBjXz
         hXLCxGh/a8Wsw6+zfKbYHeJdyYk+mS/Ng2hdsSovMVD/uwIZUSA2Lw45LTA3oLiAyd3i
         Y/afvtXpl7JNvzwsBxxLErM95zYajJDzWzo9cyAXekowdafzve9TnghY50VC1jmcX5Kp
         opBzeWdnoWnAglsOThCIH2pn4Kz5BWruSTiYa1GCiRcQVCk7qYL4JNs6NsKhH902ipuU
         6lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qm9W0hj59wlYnXNykoJwIOmAIf4DkF+Pf8JTpO9Mxo8=;
        b=VLkIsv057TVTUBvP0cpuG6X13gLwLbYyUtrxXR21tZHW+iXZz4VKJyKFDlHL0xEthl
         ecq3Qy6XJhingd9v1DOVwUEqUPtkcWVQn1XQ55tDDEixH/I18SYpsYSt/UNXo/+pR2ht
         2FlnHRM5QjBxpyE/3jzvGm50PWZJZEzucELZ5XS+Zj+0xFariR1t0LpE8v33lh4gLmAS
         w6Lf4nnD2goYxIY0jVq9L5RUbe4fKIMHmBbkHaxc5hhL8Z3+IEHiFkI3sRaXZ1oA7fq/
         2Bnt5pno2ma6uwLpuKMS+sU+sps246RNpkSo/yYucTTM1u55HK7TlLwIbIpk37a/hhQK
         0bMw==
X-Gm-Message-State: AG10YOTqNDcG6TfwRmvmFpwo7e2nSA6viyBLCFjxvH1NDMqdPgSfq6+1ARl/dLZg/BtkkA==
X-Received: by 10.112.64.42 with SMTP id l10mr3563794lbs.137.1455400711996;
        Sat, 13 Feb 2016 13:58:31 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:31 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 06/10] MIPS: dts: qca: ar9132: use short references for uart, usb and spi nodes
Date:   Sun, 14 Feb 2016 00:58:13 +0300
Message-Id: <1455400697-29898-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Here are some Sascha Hauer's arguments for using aliases in the dts
files:

 - using aliases reduces the number of indentations in dts files;

 - dts files become independent of the layout of the dtsi files
   (it becomes possible to introduce another bus {} hierarchy between
   a toplevel bus and the devices when you have to);

 - less chances for typos. if &i2c2 does not exist you get an error.
   If instead you duplicate the whole path in the dts file a typo
   in the path will just create another node.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi               |  6 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 82 ++++++++++++------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 3c2ed9e..511cb4d 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -52,7 +52,7 @@
 				#qca,ddr-wb-channel-cells = <1>;
 			};
 
-			uart@18020000 {
+			uart: uart@18020000 {
 				compatible = "ns8250";
 				reg = <0x18020000 0x20>;
 				interrupts = <3>;
@@ -125,7 +125,7 @@
 			};
 		};
 
-		usb@1b000100 {
+		usb: usb@1b000100 {
 			compatible = "qca,ar7100-ehci", "generic-ehci";
 			reg = <0x1b000100 0x100>;
 
@@ -140,7 +140,7 @@
 			status = "disabled";
 		};
 
-		spi@1f000000 {
+		spi: spi@1f000000 {
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index c3069c3..9528ebd 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -22,51 +22,10 @@
 
 	ahb {
 		apb {
-			uart@18020000 {
-				status = "okay";
-			};
-
 			pll-controller@18050000 {
 				clocks = <&extosc>;
 			};
 		};
-
-		usb@1b000100 {
-			status = "okay";
-		};
-
-		spi@1f000000 {
-			status = "okay";
-			num-cs = <1>;
-
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "s25sl064a";
-				reg = <0>;
-				spi-max-frequency = <25000000>;
-
-				partition@0 {
-					label = "u-boot";
-					reg = <0x000000 0x020000>;
-				};
-
-				partition@1 {
-					label = "firmware";
-					reg = <0x020000 0x7D0000>;
-				};
-
-				partition@2 {
-					label = "art";
-					reg = <0x7F0000 0x010000>;
-					read-only;
-				};
-			};
-		};
-	};
-
-	usb-phy {
-		status = "okay";
 	};
 
 	gpio-keys {
@@ -114,3 +73,44 @@
 		};
 	};
 };
+
+&uart {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&spi {
+	status = "okay";
+	num-cs = <1>;
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "s25sl064a";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x000000 0x020000>;
+		};
+
+		partition@1 {
+			label = "firmware";
+			reg = <0x020000 0x7D0000>;
+		};
+
+		partition@2 {
+			label = "art";
+			reg = <0x7F0000 0x010000>;
+			read-only;
+		};
+	};
+};
-- 
2.7.0
