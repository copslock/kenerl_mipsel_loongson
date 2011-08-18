Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 01:46:52 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:32768 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492164Ab1HRXqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 01:46:38 +0200
Received: by vws8 with SMTP id 8so2398190vws.36
        for <multiple recipients>; Thu, 18 Aug 2011 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Sja2tKKPkvVZNEHIAl4jnyBxyCHzQnsrnB5lBbP7lpU=;
        b=GNyJAzeccgDk0rXjlgowy0LB6wVE/kUimBeD/Op59zRUTlyw2AeEfsoXi7Yew5Yy4W
         O9cL7oOPZCT890JMb3LE+4qmoF39/5t57oBY42vByr54U1MZiUOuxZ7ZlKcrbvTKbrD9
         Sx//cXfYpN4qtNZJTdivlaVxCGInbcQIlcPak=
Received: by 10.52.67.146 with SMTP id n18mr1386153vdt.464.1313711192224;
        Thu, 18 Aug 2011 16:46:32 -0700 (PDT)
Received: from localhost (cpe-174-109-057-197.nc.res.rr.com [174.109.57.197])
        by mx.google.com with ESMTPS id e1sm1523258vcz.7.2011.08.18.16.46.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:46:31 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, lm-sensors@lm-sensors.org,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] MIPS: register hwmon on SWARM
Date:   Thu, 18 Aug 2011 19:46:25 -0400
Message-Id: <1313711185-3677-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.3.4
X-archive-position: 30908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/mips/sibyte/swarm/swarm-i2c.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sibyte/swarm/swarm-i2c.c b/arch/mips/sibyte/swarm/swarm-i2c.c
index 0625050..a6e417f 100644
--- a/arch/mips/sibyte/swarm/swarm-i2c.c
+++ b/arch/mips/sibyte/swarm/swarm-i2c.c
@@ -13,6 +13,11 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 
+static struct i2c_board_info swarm_i2c_info0[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm90", 0x2a),
+	},
+};
 
 static struct i2c_board_info swarm_i2c_info1[] __initdata = {
 	{
@@ -24,6 +29,8 @@ static int __init swarm_i2c_init(void)
 {
 	int err;
 
+	err = i2c_register_board_info(0, swarm_i2c_info0,
+				      ARRAY_SIZE(swarm_i2c_info0));
 	err = i2c_register_board_info(1, swarm_i2c_info1,
 				      ARRAY_SIZE(swarm_i2c_info1));
 	if (err < 0)
-- 
1.7.3.4
