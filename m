Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 05:54:21 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:49105 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491042Ab0KOExb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Nov 2010 05:53:31 +0100
Received: by gwb11 with SMTP id 11so935908gwb.36
        for <multiple recipients>; Sun, 14 Nov 2010 20:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jW00FTB7KQRtoofGQ33837FzMXck2ZXCEtwLio5yQ+k=;
        b=jE1pjVEAmVMgfzQA0xl8K3MSwbgdVIBEnPevnpbEks4MIhI0wWWbCzyS22jtAD6vRw
         w6H31jkZ/XnB7EemKmRTekyWZu4kQwyAusvu1ksLKHLVFIOFcSghfSnJ3IYPnIT2T4+X
         904IrtZ1zFKwgH980adDxF6M/CwHUXgpIFs90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vb+aKF/3nYS7Iklwl3X7jc0INqpx8Tc+HzCx+uGU1qpJ0bFZJdBdGPvrOqGl5KORZm
         ovPqQXMGTIa3katOW8ws68XzsSOXDxibARTQfeJod5y2Hvxl+Ael9evu5PyQvZFJRi08
         z6S0TECEiLVt8hpd00qvex7vU7Hj28zImuPkY=
Received: by 10.150.182.11 with SMTP id e11mr8699350ybf.210.1289796804292;
        Sun, 14 Nov 2010 20:53:24 -0800 (PST)
Received: from mattst88@gmail.com (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id h68sm4331199yha.15.2010.11.14.20.53.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 20:53:23 -0800 (PST)
Received: by mattst88@gmail.com (sSMTP sendmail emulation); Sun, 14 Nov 2010 23:54:49 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, kaloz@openwrt.org,
        Mark Zhan <rongkai.zhan@windriver.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] MIPS: register hwmon on SWARM
Date:   Sun, 14 Nov 2010 23:53:49 -0500
Message-Id: <1289796829-29222-4-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1289796829-29222-1-git-send-email-mattst88@gmail.com>
References: <1289796829-29222-1-git-send-email-mattst88@gmail.com>
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maciej W. Rozycki <macro@linux-mips.org>

Tested-by: Matt Turner <mattst88@gmail.com>
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
1.7.3.2
