Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 22:23:43 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:56800 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013953AbbKPVXNIGVHA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 22:23:13 +0100
Received: from localhost.localdomain (unknown [78.54.254.43])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id A65FEA6229;
        Mon, 16 Nov 2015 22:22:57 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 4/5] MIPS: ath79: Add the EHCI controller and USB phy to the AR9132 dtsi
Date:   Mon, 16 Nov 2015 22:22:03 +0100
Message-Id: <1447708924-15076-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447708924-15076-1-git-send-email-albeu@free.fr>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Fix the USB controller node name to follow ePAPR
    * Set the USB phy as disabled like the USB controller
---
 arch/mips/boot/dts/qca/ar9132.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index fb7734e..857ca48 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -125,6 +125,21 @@
 			};
 		};
 
+		usb@1b000100 {
+			compatible = "qca,ar7100-ehci", "generic-ehci";
+			reg = <0x1b000100 0x100>;
+
+			interrupts = <3>;
+			resets = <&rst 5>;
+
+			has-transaction-translator;
+
+			phy-names = "usb";
+			phys = <&usb_phy>;
+
+			status = "disabled";
+		};
+
 		spi@1f000000 {
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
@@ -138,4 +153,15 @@
 			#size-cells = <0>;
 		};
 	};
+
+	usb_phy: usb-phy {
+		compatible = "qca,ar7100-usb-phy";
+
+		reset-names = "usb-phy", "usb-suspend-override";
+		resets = <&rst 4>, <&rst 3>;
+
+		#phy-cells = <0>;
+
+		status = "disabled";
+	};
 };
-- 
2.0.0
