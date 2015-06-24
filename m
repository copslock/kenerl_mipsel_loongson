Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 08:09:48 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36369 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008367AbbFXGJARv0es (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 08:09:00 +0200
Received: by paceq1 with SMTP id eq1so22269215pac.3;
        Tue, 23 Jun 2015 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yXpVQmpGGarrHeWHyiwFiSl0HjIiF7Sfzp+fiNc2GJY=;
        b=ONiB0lHnUnm4Se2zMk3nhPntPN2ukoPWZrTwORaxHb5+TOZ6YBCRiD+eBLqqZBWsqR
         PRowhzjA+sAGRhrf5wAeYwtgHFK/OnmxFtyVvd3EY6AIX1gBMzz/X/wQEnqjOTlLopSK
         0UGvYsH6xGm83uzoF8LnO/kvYnulTW5kUqQ+Ig7M6pFX01lygM3F4kVAOXAfr3e3yRW+
         xPsn9mNWyA4MqY0dZT5nV/WdzLJD9PLlhiSlDb3of7l7uArDrwTDDYZymEJi4T0QE2Pb
         N5h2gQzE3fpKjMr1NbOLymHGcxaHF8WYgJDTS6601xwwPdYaXwza59WOiVr85Zv1X4ez
         lytg==
X-Received: by 10.66.150.169 with SMTP id uj9mr75649022pab.125.1435126134439;
        Tue, 23 Jun 2015 23:08:54 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by mx.google.com with ESMTPSA id cd10sm25396180pac.7.2015.06.23.23.08.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jun 2015 23:08:53 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/4] MIPS: BMIPS: bcm7360: add nodes for NAND
Date:   Wed, 24 Jun 2015 15:08:33 +0900
Message-Id: <72f9d919f140dcab72b7e3b6f1432430b1d4c441.1435124524.git.jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48014
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

Add NAND device nodes to BMIPS based BCM7360 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7360.dtsi     | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index f23b0aed276f..cfa1830a411c 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -157,5 +157,27 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		hif_intr2_intc: interrupt-controller@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+			interrupt-names = "hif";
+		};
+
+		nand0: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_intr2_intc>;
+			interrupt-names = "nand_ctlrdy";
+			interrupts = <24>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 4fe515500102..e45f1d519667 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -32,3 +32,26 @@
 &ohci0 {
 	status = "okay";
 };
+
+&nand0 {
+	status = "okay";
+
+	nandcs@1 {
+		compatible = "brcm,nandcs";
+		reg = <1>;
+		nand-ecc-step-size = <512>;
+		nand-ecc-strength = <8>;
+		nand-on-flash-bbt;
+
+		#size-cells = <2>;
+		#address-cells = <2>;
+
+		flash1.rootfs0@0 {
+			reg = <0x0 0x0 0x0 0x80000000>;
+		};
+
+		flash1.rootfs1@80000000 {
+			reg = <0x0 0x80000000 0x0 0x80000000>;
+		};
+	};
+};
-- 
2.4.4
