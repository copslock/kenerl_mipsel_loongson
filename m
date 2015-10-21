Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:40:19 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35213 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010519AbbJUCiVSkZ0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:21 +0200
Received: by pasz6 with SMTP id z6so39417117pas.2;
        Tue, 20 Oct 2015 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hkcEJSUh1tqwvGJnLZqeHBRkMYF3VxVNIYMvpkbDLvw=;
        b=vR8hWY+HHp5+zrAENpBWbv6vk3peOUdJpGQYOWFqe7vbfEus5fJsSONBLNGx3LF+Gy
         fruxsgqjDIPVndV3SEW0TVC1gqbiN25BqguyUE3YJX9UwM06UvJ1q3ZGXlQ8a/E+RO8F
         5GoBN6shNahHZmhZkCGijHJlkwlsAhTlf6EntTd/F8LK0muIvgQuJslZZmM55PmIxSXC
         6sJqoNqw0KSbz7I2xhjxIegpYnY43LCQecl1Us8X1GOHHMeMwG3JGnZ4hD6iL/91+rNV
         xLhM8p33ITD0UXUkmFhF1i1K5ORcd7D9NE1gIl0BSEHNt8yJBpHf2mvjYOzgFZ0FFNML
         RHHA==
X-Received: by 10.66.160.34 with SMTP id xh2mr7821485pab.67.1445395093858;
        Tue, 20 Oct 2015 19:38:13 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.38.11
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:38:13 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 8/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7360
Date:   Wed, 21 Oct 2015 11:37:00 +0900
Message-Id: <1445395021-4204-9-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49621
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

Add I2C device nodes to BMIPS based BCM7360 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7360.dtsi     | 62 ++++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm97360svmb.dts | 16 +++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 9e1e571ba346..7e5f76040fb8 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -81,14 +81,32 @@
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
@@ -138,6 +156,46 @@
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
+		bscc: i2c@406300 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406300 0x58>;
+		      interrupts = <26>;
+		      interrupt-names = "upg_bscc";
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
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index eee8b0e32681..d48462e091f1 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -29,6 +29,22 @@
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
+&bscc {
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
