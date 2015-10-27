Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:51:32 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36442 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011548AbbJ0GtTmVvI9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:49:19 +0100
Received: by pacfv9 with SMTP id fv9so222596442pac.3;
        Mon, 26 Oct 2015 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2IGmW7k6IuPWGFKv0tnyWHtXiids3OYCL+m5WK/QNc=;
        b=WoB9i2uFShh8tEqr3eJ7rJByvqivEWfucZ3LqZaX12/KI0yvVEMcbK/lHDlQxtNLQ3
         TOnFuIhTal2HiHB4iwpU1rL78ntvEJnQEdUYu/orsHSRS4RDGFTHN0lxG96aPc8BG/aw
         juy8bh7n7c1hp+BTvt/vCLh5jpTX0B911kbSJYYkkygTflzOeZOmnbUh5i3N+hOHc2jg
         COEoYtotccy6Ephk6P7QD5BKYVC6tyk+T9+rQy6VqOP0ZLRIbGj0uvGosm7AN9JO1j8Y
         56aYIwsMUHwP+RwLpcMeqdz57TU8fyyGxXH4ff8HuuSXyO6ggLNUR6ZleCJ6nbQWw5Gn
         TD4w==
X-Received: by 10.66.189.68 with SMTP id gg4mr25162609pac.6.1445928554067;
        Mon, 26 Oct 2015 23:49:14 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.49.10
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:49:13 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 10/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
Date:   Tue, 27 Oct 2015 15:48:11 +0900
Message-Id: <1445928491-7320-11-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49714
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

Add AHCI and PHY device nodes to MIPS-based BCM7362 set-top box
platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7362.dtsi     | 42 ++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts |  8 ++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 6e65db86fc61..53b73de9066c 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -189,5 +189,47 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		sata: sata@181000 {
+			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <86>;
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
