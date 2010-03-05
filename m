Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 08:09:08 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:54870 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491051Ab0CEHJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 08:09:00 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o2578GrL004033;
        Thu, 4 Mar 2010 23:08:17 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-i2c@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date:   Fri,  5 Mar 2010 15:08:15 +0800
Message-Id: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

An EEPROM resides on 0x50 of I2C bus on CN56xx/57xx board,
register this device.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 62ac30e..5bfa513 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -164,6 +164,9 @@ static struct i2c_board_info __initdata octeon_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
 	},
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
+	},
 };
 
 static int __init octeon_i2c_devices_init(void)
-- 
1.6.3.3
