Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:42:04 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33079 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011854AbbJ3NkEbdgT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 14:40:04 +0100
Received: by padhy1 with SMTP id hy1so69143089pad.0;
        Fri, 30 Oct 2015 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9FVGTedCg58hLMyU68oUYJdGiQUKPgYoyo+Fr8Xrgo=;
        b=ILPgkbAXn7xoGEG5pOVK0/EcsPmX8YxMgCIhfDbsLW5EOjBxkb6wyHi67dw5Ndh0Zp
         j31Vs5kPOz44RN2P8P6mock7RBkyNNSa3GO/j/yLOu4Tya/IhcyC1zVFlHLF7RxgoCBS
         NCX+bG2xN+hpgek3UWq7mwWSJdNUEDAGncqHIcGzlAmrF9hAcajDYY38H/XRviKDWMa0
         CH/5tJumAOdX+bJZXiugq2IHt+lz6bdXILgPqtHflXcbO0GCh3kUvzJb+Er78UX16PLQ
         5N/FMHdTpnNAmoAKlpS5HR6Nga10kjyLvIa3zaKvdqnaI8HzDT9bQNbBqOzHN95RnbHS
         RMXQ==
X-Received: by 10.68.139.100 with SMTP id qx4mr9008648pbb.145.1446212398919;
        Fri, 30 Oct 2015 06:39:58 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id d13sm8391293pbu.20.2015.10.30.06.39.55
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 06:39:58 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 09/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
Date:   Fri, 30 Oct 2015 22:38:58 +0900
Message-Id: <1446212339-1210-10-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49784
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

Add AHCI and PHY device nodes to MIPS-based BCM7346 set-top box
platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 42 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 ++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index d817bb46b934..8535a5676d48 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -246,5 +246,47 @@
 			interrupts = <76>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			brcm,broken-ncq;
+			brcm,broken-phy;
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
+			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
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
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 3fe0445b9d37..e147c61178cc 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -64,3 +64,11 @@
 &ohci3 {
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
