Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:48:10 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33750 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011206AbbJWBqD1lumB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:46:03 +0200
Received: by pabrc13 with SMTP id rc13so102334150pab.0;
        Thu, 22 Oct 2015 18:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6G0LtyCQfQ/RuI1d9KTLowM4QjBaxYmLLvzEVU9y3pg=;
        b=xwIivhARfadbhtuFyx4cxRqYUHtjUTIJQ7spdWimxuvRFF6uPsXfMv9L5qNWTzf6e/
         cd3KoJMZSYMbohvc2qL4VDK07FaJY8KXM/y/YJDlogeM1Xj2C8c4cjizwk+uaKMnFrSH
         YqszfmPdj2o2Vy3vVc5HA2ZIf8ZKx0vqtN8EoaWeZg7E83yaJtNgo/WJmgOLg706oEWO
         9e8UtsPWTkTBuwPTQipKEyzQSDxBgZXTaHxBsagzr2bb1/gKoHSH8n3jQBt9gWxNxm4n
         i9vpnikJ6eM+9qGhNd5OxgvoUKyUTRo1j1I7onc0gvwTlv11xhO/FcugPe4u/ceiVOGG
         Xa5w==
X-Received: by 10.68.197.168 with SMTP id iv8mr1838497pbc.129.1445564757848;
        Thu, 22 Oct 2015 18:45:57 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:57 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 10/10] MIPS: BMIPS: brcmstb: add SATA nodes for bcm7362
Date:   Fri, 23 Oct 2015 10:44:23 +0900
Message-Id: <1445564663-66824-11-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49651
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

Add AHCI and PHY device nodes to BMIPS based BCM7362 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7362.dtsi     | 40 ++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts |  8 +++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 6e65db86fc61..51c58a41d2b5 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -189,5 +189,45 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7362-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x8>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <86>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@1800000 {
+			compatible = "brcm,bcm7362-sata-phy", "brcm,phy-sata3";
+			reg = <0x180100 0x0eff>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 739c2ef5663b..ef9a69b79bc4 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -40,3 +40,11 @@
 &ohci0 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.6.2
