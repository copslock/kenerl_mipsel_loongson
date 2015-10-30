Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:41:48 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35243 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011853AbbJ3NkA5No60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 14:40:00 +0100
Received: by pasz6 with SMTP id z6so75132638pas.2;
        Fri, 30 Oct 2015 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv88yHDQEy/xsGcT+dFNGS+rMwLmKfdd/JzW6SHhSGk=;
        b=OeDjfAT3VQKme1ohYs2Mn7xkAyjrzK6q4V6rT6UBuHbfN4e8DUUcRM87ZvOLmEDWEA
         G2sO67XiF773IheS5MwIh0AEmFlRLZF8hZ6BgJ3ycHVrtD1YWHZKuoOXdlFDAiPJno/W
         ZGoYOpeH+fqdY2YmxmMGJkeinWwW60trLot4HpQ9EFkR/AjJobvBBZiu/eOv++C12AoL
         gzHdL2B8PaZZa4U4z29I4cu3TCvVP75mq6EAn8+RchqldRI4AJoXydOBfcoIL5bXjnRM
         L6WOl1UzMplYb8pfalfD13F50Nbu6q+yQ82enwgdA0al+iCan52RCFYUCXpnxe0Tscbm
         T9Zg==
X-Received: by 10.69.8.34 with SMTP id dh2mr8962418pbd.122.1446212395340;
        Fri, 30 Oct 2015 06:39:55 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id d13sm8391293pbu.20.2015.10.30.06.39.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 06:39:54 -0700 (PDT)
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
Subject: [v3 08/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
Date:   Fri, 30 Oct 2015 22:38:57 +0900
Message-Id: <1446212339-1210-9-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49783
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

Add AHCI and PHY device nodes to MIPS-based BCM7425 set-top box
platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 5b660b617ead..e24d41ab4e30 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -221,5 +221,47 @@
 			interrupts = <73>;
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
-- 
2.6.2
