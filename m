Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:47:05 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60903 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011640AbcAZWrDBLHXl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 23:47:03 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOCNy-0004Jz-Bj; Tue, 26 Jan 2016 22:46:55 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOCNv-0006V6-F9; Tue, 26 Jan 2016 22:46:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Date:   Tue, 26 Jan 2016 22:46:49 +0000
Message-Id: <1453848410-24949-1-git-send-email-broonie@kernel.org>
X-Mailer: git-send-email 2.7.0.rc3
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: [PATCH 1/2] regmap: Add explict native endian flag to DT bindings
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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

Currently the binding document says that if no endianness is configured
we use native endian but this is not in fact true for all binding types
and we do have some devices that really want native endianness such as
Broadcom MIPS SoCs where switching the endianness of the CPU also
switches the endianness of external IPs.

Provide an explicit option for this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regmap/regmap.txt | 11 +++++++----
 drivers/base/regmap/regmap.c                        |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regmap/regmap.txt b/Documentation/devicetree/bindings/regmap/regmap.txt
index b494f8b8ef72..e98a9652ccc8 100644
--- a/Documentation/devicetree/bindings/regmap/regmap.txt
+++ b/Documentation/devicetree/bindings/regmap/regmap.txt
@@ -5,15 +5,18 @@ Index     Device     Endianness properties
 ---------------------------------------------------
 1         BE         'big-endian'
 2         LE         'little-endian'
+3	  Native     'native-endian'
 
 For one device driver, which will run in different scenarios above
 on different SoCs using the devicetree, we need one way to simplify
 this.
 
-Required properties:
-- {big,little}-endian: these are boolean properties, if absent
-  meaning that the CPU and the Device are in the same endianness mode,
-  these properties are for register values and all the buffers only.
+Optional properties:
+- {big,little,native}-endian: these are boolean properties, if absent
+  then the implementation will choose a default based on the device
+  being controlled.  These properties are for register values and all
+  the buffers only.  Native endian means that the CPU and device have
+  the same endianness.
 
 Examples:
 Scenario 1 : CPU in LE mode & device in LE mode.
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4ac63c0e50c7..57a7d144e629 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -500,6 +500,8 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 			endian = REGMAP_ENDIAN_BIG;
 		else if (of_property_read_bool(np, "little-endian"))
 			endian = REGMAP_ENDIAN_LITTLE;
+		else if (of_property_read_bool(np, "native-endian"))
+			endian = REGMAP_ENDIAN_NATIVE;
 
 		/* If the endianness was specified in DT, use that */
 		if (endian != REGMAP_ENDIAN_DEFAULT)
-- 
2.7.0.rc3
