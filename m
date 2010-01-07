Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 20:55:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18942 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492673Ab0AGTzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 20:55:12 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b463c220000>; Thu, 07 Jan 2010 11:55:14 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:54:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:54:29 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o07JsQ2l032646;
        Thu, 7 Jan 2010 11:54:26 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o07JsQ3s032645;
        Thu, 7 Jan 2010 11:54:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org
Cc:     rade.bozic.ext@nsn.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Octeon: Register some devices on the I2C bus.
Date:   Thu,  7 Jan 2010 11:54:21 -0800
Message-Id: <1262894061-32613-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B463B1F.6000404@caviumnetworks.com>
References: <4B463B1F.6000404@caviumnetworks.com>
X-OriginalArrivalTime: 07 Jan 2010 19:54:29.0287 (UTC) FILETIME=[3921D370:01CA8FD3]
X-archive-position: 25538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5184

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Rade Bozic <rade.bozic.ext@nsn.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index f2c0602..d8f8129 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -165,6 +166,18 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
+static struct i2c_board_info __initdata octeon_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68),
+	},
+};
+
+static int __init octeon_i2c_devices_init(void)
+{
+	return i2c_register_board_info(0, octeon_i2c_devices,
+				       ARRAY_SIZE(octeon_i2c_devices));
+}
+arch_initcall(octeon_i2c_devices_init);
 
 #define OCTEON_I2C_IO_BASE 0x1180000001000ull
 #define OCTEON_I2C_IO_UNIT_OFFSET 0x200
-- 
1.6.0.6
