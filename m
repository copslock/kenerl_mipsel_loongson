Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:36:06 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36390 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006999AbcCQDepCZ6Sp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:45 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so2226343lfh.3;
        Wed, 16 Mar 2016 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcyy47SnSPEPq7E03HHfSoaJ5DfVFZuBvoSFqLJ6dXo=;
        b=xMhncBoW99bZvQKGI+eVUrWZeB1zeofMrFpzQ5Cg8xoR2Whn7/3oftanUmdfr9rqFe
         ASUuJJ3ZJmpO9QIeLUaK2oP4lJr+nRDmfdpKYNMH3k10YoqoxiVJI7dyBLoSZxHNOqmA
         MGthOkY2GRy7CqdxX0iTGyV3IdmRVPBscMDCxoaFVBg9tGKlSNKvuw7zrqCrzR18N/0H
         Uvurbg3/i4y1+mOtqcdedZMXCKfH7STMXNZfiBcBUhLFvKs3F+weQ7+OcrR+5eDP8pAu
         DnFQHjVNtEUR1RmxSOpaQpLnbvY68m45w5HSI/6npaxv1rjegeIaF0FEwYnJxmnemmZI
         L/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcyy47SnSPEPq7E03HHfSoaJ5DfVFZuBvoSFqLJ6dXo=;
        b=UGmGMEBeio2m+2fGxrv0TnU396V/qp146Wb4DOUwypQagYqs7+yWHAhk8ynXI/hjz6
         zd1iPj9WJV10ATTU0PvhZwDH7SrBOOALbNahH16Mw8yaUop6IPm8cLYlVfk3/JwAlivh
         rsxwhLmNT3MzriR5Y2V152vv36WtGqbzv2kMowM7uP1XuYb6iynyqRHNIRT9+iiUiaI6
         LmCEYi8+Ks5Tyz/rAK20ohJysi8oTSexsxyZVGO0zsCpqWXFV02ONKpjI1P3cfnj1Hmf
         itdXLUbcigdf4lzy4cSRJfuI4DVw7IV6aB1RNJjq4fCnQTYjz8TYfl8A+UfXG+dbrDk4
         sYdw==
X-Gm-Message-State: AD7BkJKHkC+jB7jILLht6cS61XVUm7Sl+pHPQcWzHXkJIRB9xH9x4+cN5nxppChtGBh/+A==
X-Received: by 10.25.207.76 with SMTP id f73mr2853249lfg.11.1458185679770;
        Wed, 16 Mar 2016 20:34:39 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:39 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 05/18] MIPS: dts: qca: ar9132: use short references for dt nodes
Date:   Thu, 17 Mar 2016 06:34:12 +0300
Message-Id: <1458185665-4521-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52619
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
 arch/mips/boot/dts/qca/ar9132.dtsi               |  8 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 94 ++++++++++++------------
 2 files changed, 49 insertions(+), 53 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 3c2ed9e..3bff63b 100644
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
@@ -94,7 +94,7 @@
 				clock-output-names = "cpu", "ddr", "ahb";
 			};
 
-			wdt@18060008 {
+			wdt: wdt@18060008 {
 				compatible = "qca,ar7130-wdt";
 				reg = <0x18060008 0x8>;
 
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
index c3069c3..eb632a2 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -20,55 +20,6 @@
 		clock-frequency = <40000000>;
 	};
 
-	ahb {
-		apb {
-			uart@18020000 {
-				status = "okay";
-			};
-
-			pll-controller@18050000 {
-				clocks = <&extosc>;
-			};
-		};
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
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -114,3 +65,48 @@
 		};
 	};
 };
+
+&uart {
+	status = "okay";
+};
+
+&pll {
+	clocks = <&extosc>;
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
