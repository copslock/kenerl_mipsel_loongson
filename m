Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:40:34 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36607 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007641AbbJUCiWMA9vy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:22 +0200
Received: by pacfv9 with SMTP id fv9so40955416pac.3;
        Tue, 20 Oct 2015 19:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW3DKjhuUtbZe7TUfCEWQZnnqYJRnzp5WkNfrdhv98Y=;
        b=p7CmmWT1Tv3cD3zSr2VyKXiUkUf3y3HSzHU8v44ouR5ZC1mY9wRDEAs2YH6Z6ZxpRP
         bkCKlNKnBr0kc70K/Mk/5bUYKicLOtAkK/P2uW524xA+LnyRm/Tm5mLGijpI/2OfDPhi
         gp24z60FXn/4Ymdo/TSLBdUcLScaiIbTOyulrv3AhRZhxT8TQrcAM2Dcj7lO7cu5bSuL
         s/NewmBml7+Uuybkz+oKN/sLZ1kGQX74q5KgzwKuN5g7FJ74zk0ftl9QyJP3WOi6fTRJ
         pmNuB83JThBeU/NZgsqxz9JvGKMUx1F2RUQo17LDXNByxQ5MC2s8kCbBmrN3tx0PAzap
         cXHQ==
X-Received: by 10.67.30.136 with SMTP id ke8mr7798122pad.16.1445395096582;
        Tue, 20 Oct 2015 19:38:16 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.38.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:38:16 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 9/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7362
Date:   Wed, 21 Oct 2015 11:37:01 +0900
Message-Id: <1445395021-4204-10-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49622
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

Add I2C device nodes to BMIPS based BCM7362 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7362.dtsi     | 52 ++++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm97362svmb.dts | 12 ++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 6e65db86fc61..5f817be2553c 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -87,14 +87,32 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406600 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <56>;
+			interrupts = <56>, <54>;
+			interrupt-names = "upg_main", "upg_bsc";
+		};
+
+		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x408b80 0x8>;
+
+			brcm,int-map-mask = <0x40>, <0x8000000>, <0x100000>;
+			brcm,int-fwd-mask = <0>;
+			brcm,irq-can-wake;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <57>, <55>, <59>;
+			interrupt-names = "upg_main_aon", "upg_bsc_aon",
+					  "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -144,6 +162,36 @@
 			status = "disabled";
 		};
 
+		bsca: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscd: i2c@408980 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x408980 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 739c2ef5663b..9c99bfd1e781 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -29,6 +29,18 @@
 	status = "okay";
 };
 
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.6.1
