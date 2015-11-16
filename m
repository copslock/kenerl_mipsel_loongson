Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 22:23:05 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:55019 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013952AbbKPVWtAYhuF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 22:22:49 +0100
Received: from localhost.localdomain (unknown [78.54.254.43])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 80684A6258;
        Mon, 16 Nov 2015 22:22:33 +0100 (CET)
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
Subject: [PATCH v2 2/5] devicetree: Add bindings for the ATH79 USB phy
Date:   Mon, 16 Nov 2015 22:22:01 +0100
Message-Id: <1447708924-15076-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447708924-15076-1-git-send-email-albeu@free.fr>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49952
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
 .../devicetree/bindings/phy/phy-ath79-usb.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
new file mode 100644
index 0000000..cafe219
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
@@ -0,0 +1,18 @@
+* Atheros AR71XX/9XXX USB PHY
+
+Required properties:
+- compatible: "qca,ar7100-usb-phy"
+- #phys-cells: should be 0
+- reset-names: "usb-phy"[, "usb-suspend-override"]
+- resets: references to the reset controllers
+
+Example:
+
+	usb-phy {
+		compatible = "qca,ar7100-usb-phy";
+
+		reset-names = "usb-phy", "usb-suspend-override";
+		resets = <&rst 4>, <&rst 3>;
+
+		#phy-cells = <0>;
+	};
-- 
2.0.0
