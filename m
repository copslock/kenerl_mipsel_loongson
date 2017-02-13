Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 23:27:27 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:44507 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993543AbdBMW1SDR7A7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Feb 2017 23:27:18 +0100
Received: from localhost.localdomain (unknown [78.54.29.3])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id 92FEF780371;
        Mon, 13 Feb 2017 23:26:55 +0100 (CET)
From:   Alban <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v5 3/3] MIPS: ath79: Fix the USB PHY reset names
Date:   Mon, 13 Feb 2017 23:25:46 +0100
Message-Id: <1487024746-32082-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487024746-32082-1-git-send-email-albeu@free.fr>
References: <1487024746-32082-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56795
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

From: Alban Bedel <albeu@free.fr>

The binding for the USB PHY went thru before the driver. However the
new version of the driver now use the PHY core support for reset, and
this expect the reset to be named "phy". So remove the "usb-" prefix
from the the reset names.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v5: * Also fix the AR9331 dtsi
---
 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
 arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +-
 arch/mips/boot/dts/qca/ar9331.dtsi                      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
index cafe219..c3a29c5 100644
--- a/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
@@ -3,7 +3,7 @@
 Required properties:
 - compatible: "qca,ar7100-usb-phy"
 - #phys-cells: should be 0
-- reset-names: "usb-phy"[, "usb-suspend-override"]
+- reset-names: "phy"[, "suspend-override"]
 - resets: references to the reset controllers
 
 Example:
@@ -11,7 +11,7 @@ Example:
 	usb-phy {
 		compatible = "qca,ar7100-usb-phy";
 
-		reset-names = "usb-phy", "usb-suspend-override";
+		reset-names = "phy", "suspend-override";
 		resets = <&rst 4>, <&rst 3>;
 
 		#phy-cells = <0>;
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 302f0a8..808c2bb 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -160,7 +160,7 @@
 	usb_phy: usb-phy {
 		compatible = "qca,ar7100-usb-phy";
 
-		reset-names = "usb-phy", "usb-suspend-override";
+		reset-names = "phy", "suspend-override";
 		resets = <&rst 4>, <&rst 3>;
 
 		#phy-cells = <0>;
diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index cf47ed4..4ffa3e8 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -145,7 +145,7 @@
 	usb_phy: usb-phy {
 		compatible = "qca,ar7100-usb-phy";
 
-		reset-names = "usb-phy", "usb-suspend-override";
+		reset-names = "phy", "suspend-override";
 		resets = <&rst 4>, <&rst 3>;
 
 		#phy-cells = <0>;
-- 
2.7.4
