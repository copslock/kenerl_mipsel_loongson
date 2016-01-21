Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 11:00:12 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33632 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009491AbcAUJ7lgfiVs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 10:59:41 +0100
Received: by mail-lf0-f66.google.com with SMTP id z62so1968862lfd.0
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 01:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPqpPJ/sHMVJfVrJUotta+rKUw82ZhG6ipQ5opgnjZk=;
        b=0H0pRtg+g+vsfGZ+aCw6mcmf6vN1AqpG+fxQp8Yn9KxxB7r3UAYfT8mYyB3MNYGtcA
         XagEHVcYZIC+Hp0RtHKUKgEivMFgmzfhISkGjC6Us36pZCd+bXtamFx9CBN5I/M2yeLC
         qkYSTaL2JERy7HjnQmvo5j8y76SROCRkQSNLSTZ2U7L+wqBKznv5c4Hb+dsxZ8eEhSYm
         r+wNZTFC4ablG/+f3y48XXhuY+PelpPp2zOv4c3XY2uig+PcPIH2pIeDdAAWtAyC8DUI
         KgDgsAq7que5nId3c2P9JJA7iB8i0Gztms3Wt8li1WJ9SJw/pPlt3whBMxD8XdsosZud
         Wn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPqpPJ/sHMVJfVrJUotta+rKUw82ZhG6ipQ5opgnjZk=;
        b=CRxvfphplDl2liXnmiQpJ+BbNXY5D37/umCaeHZ+1ngJ0OC5NosqDCquZpTv1RsysH
         UMPY61sQoWr+ejjyCWU4mPSVF1ecKp+PsgI8IlvYd7IxwU7az+IhpI6cFwur56tfxo5R
         NMGgkxpO3Rcu/kx0+rRhXJv/f2qxdXL2DHeK9HvaJlXM5N4Xjweedi6LgwJgmrhKEuj8
         ad5boEmrjCVPILF5quXG5y2Cwc4A7gwoC5Ux7HJICGHt6HxuSqmGsTPB0pkB10XIybAu
         7F+QguEB2kjtKrRDbUIkluxaz8Io9CmmN6PPkVF+RKFKfs4REB1D13BcV6PfNrIq7hqe
         /2wQ==
X-Gm-Message-State: ALoCoQlWjpybJit01eK3acq1rDf5fM3jjckKkGOOwJMhg3DnBXMQ0WaS30VeuMpF/7o2v+uEZyAPDvLlLR7w1sLhJUPDFTf3MA==
X-Received: by 10.25.3.133 with SMTP id 127mr15522256lfd.50.1453370376279;
        Thu, 21 Jan 2016 01:59:36 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id i127sm86367lfd.3.2016.01.21.01.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 01:59:32 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: dts: qca: ar9132: use short references for uart and spi nodes
Date:   Thu, 21 Jan 2016 12:59:05 +0300
Message-Id: <1453370345-16688-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
References: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51270
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi               |  4 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 70 +++++++++++-------------
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 84787e30..f197815 100644
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
@@ -122,7 +122,7 @@
 			};
 		};
 
-		spi@1f000000 {
+		spi: spi@1f000000 {
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 10905f6..533d6e8 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -14,43 +14,6 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	ahb {
-		apb {
-			uart@18020000 {
-				status = "okay";
-			};
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
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -96,3 +59,36 @@
 		};
 	};
 };
+
+&uart {
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
2.6.2
