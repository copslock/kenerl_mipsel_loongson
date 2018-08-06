Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 20:54:35 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:45199 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994660AbeHFSyVFXgUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 20:54:21 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 62CED207B7; Mon,  6 Aug 2018 20:54:14 +0200 (CEST)
Received: from localhost (LPuteaux-656-1-243-71.w82-127.abo.wanadoo.fr [82.127.120.71])
        by mail.bootlin.com (Postfix) with ESMTPSA id 217492072D;
        Mon,  6 Aug 2018 20:54:14 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/6] i2c: designware: use generic table matching
Date:   Mon,  6 Aug 2018 20:54:07 +0200
Message-Id: <20180806185412.7210-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Switch to device_get_match_data in probe to match the device specific data
instead of using the acpi specific function.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v3:
 - removed unused variable
 - switched to uintptr_t for the cast

 drivers/i2c/busses/i2c-designware-platdrv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ddf13527aaee..d117c120730d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -86,7 +86,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	struct i2c_timings *t = &dev->timings;
 	u32 ss_ht = 0, fp_ht = 0, hs_ht = 0, fs_ht = 0;
 	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
-	const struct acpi_device_id *id;
 	struct acpi_device *adev;
 	const char *uid;
 
@@ -119,10 +118,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 		break;
 	}
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id && id->driver_data)
-		dev->flags |= (u32)id->driver_data;
-
 	if (acpi_bus_get_device(handle, &adev))
 		return -ENODEV;
 
@@ -291,6 +286,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		t->bus_freq_hz = 400000;
 
+	dev->flags |= (uintptr_t)device_get_match_data(&pdev->dev);
+
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
 
-- 
2.18.0
