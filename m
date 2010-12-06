Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 05:17:10 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:37844 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491004Ab0LFEQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 05:16:59 +0100
Received: by ywf7 with SMTP id 7so6213531ywf.36
        for <multiple recipients>; Sun, 05 Dec 2010 20:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jW00FTB7KQRtoofGQ33837FzMXck2ZXCEtwLio5yQ+k=;
        b=pmQ5RlfsLaBW1NC6JO2KGCj0IDfRpz+20ly3qicKxswzFCoC1HuJHwlEHQZvbS5pS8
         GEl3ufCSEKuZt+DNuLy/0v65hYVPgzvBT4mD2m2SCgLpkPwr2EA5eBxyhDYEMaJywDqV
         ccjCdB0W61avyu3FWZ+O7PWhnMcHlIsRtNVPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=csKx51o4+IDLkNTd4RWz9KvCNanPnFrzMwsDTcz5t7qD6zrYOu2VFnkqFKrvRlM8Ii
         IzS32Znlv9veyCOjd/4070zi0+agmErqF1seGljrWcOW/O3y6d0sHSVrJjOzLI3dkoa6
         +pkcXAEXN0fYWlI2PRbKR6Yx8gvRMJrrleEu4=
Received: by 10.151.10.12 with SMTP id n12mr8433085ybi.220.1291609012839;
        Sun, 05 Dec 2010 20:16:52 -0800 (PST)
Received: from localhost (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id v8sm3013239yba.2.2010.12.05.20.16.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 20:16:52 -0800 (PST)
From:   Matt Turner <mattst88@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jean Delvare <khali@linux-fr.org>, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] MIPS: register hwmon on SWARM
Date:   Sun,  5 Dec 2010 23:16:54 -0500
Message-Id: <1291609014-17060-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28608
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
