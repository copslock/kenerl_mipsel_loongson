Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 20:54:27 +0100 (CET)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:42822 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991532AbdBETyPcn9sB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Feb 2017 20:54:15 +0100
Received: from localhost.localdomain (unknown [78.50.169.77])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id C0F5513F8D8;
        Sun,  5 Feb 2017 20:53:57 +0100 (CET)
From:   Alban <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v4 3/3] MIPS: ath79: Fix the USB PHY reset names
Date:   Sun,  5 Feb 2017 20:52:32 +0100
Message-Id: <1486324352-15188-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486324352-15188-1-git-send-email-albeu@free.fr>
References: <1486324352-15188-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56644
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
 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
 arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.7.4
