Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 00:28:12 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:44231 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992181AbdFSW024vKqi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 00:26:28 +0200
Received: from hauke-desktop.lan (p4FD9730E.dip0.t-ipconnect.de [79.217.115.14])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 489C61001E2;
        Tue, 20 Jun 2017 00:26:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 05/16] watchdog: lantiq: add device tree binding documentation
Date:   Tue, 20 Jun 2017 00:25:57 +0200
Message-Id: <20170619222608.13344-6-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170619222608.13344-1-hauke@hauke-m.de>
References: <20170619222608.13344-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The binding was not documented before, add the documentation now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
new file mode 100644
index 000000000000..1d41142ca55f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
@@ -0,0 +1,22 @@
+Lantiq WTD watchdog binding
+============================
+
+This describes the binding of the Lantiq watchdog driver.
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible		: Should be one of
+				"lantiq,wdt"
+				"lantiq,xrx100-wdt"
+				"lantiq,falcon-wdt"
+- regmap		: A phandle to the RCU syscon (required for
+			  "lantiq,falcon-wdt" and "lantiq,xrx100-wdt")
+
+-------------------------------------------------------------------------------
+Example for the watchdog on the xRX200 SoCs:
+		watchdog@803f0 {
+			compatible = "lantiq,xrx100-wdt";
+			reg = <0x803f0 0x10>;
+
+			regmap = <&rcu0>;
+		};
-- 
2.11.0
