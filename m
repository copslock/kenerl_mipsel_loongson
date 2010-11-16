Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2010 23:42:37 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7358 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492348Ab0KPWme (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Nov 2010 23:42:34 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ce308fa0000>; Tue, 16 Nov 2010 14:43:06 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 16 Nov 2010 14:43:14 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 16 Nov 2010 14:43:14 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oAGMgKYW014417;
        Tue, 16 Nov 2010 14:42:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oAGMgIa7014416;
        Tue, 16 Nov 2010 14:42:18 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] of: Request module by alias in of_i2c.c
Date:   Tue, 16 Nov 2010 14:42:14 -0800
Message-Id: <1289947334-14375-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 16 Nov 2010 22:43:14.0642 (UTC) FILETIME=[A79C2320:01CB85DF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If we are registering an i2c device that has a device tree node like
this real-world example:

      rtc@68 {
        compatible = "dallas,ds1337";
        reg = <0x68>;
      };

of_i2c_register_devices() will try to load a module called ds1337.ko.
There is no such module, so it will fail.  If we look in modules.alias
we will find entries like these:

.
.
.
alias i2c:ds1339 rtc_ds1307
alias i2c:ds1338 rtc_ds1307
alias i2c:ds1337 rtc_ds1307
alias i2c:ds1307 rtc_ds1307
alias i2c:ds1374 rtc_ds1374
.
.
.

The module we want is really called rtc_ds1307.ko.  If we request a
module called "i2c:ds1337", the userspace module loader will do the
right thing (unless it is busybox) and load rtc_ds1307.ko.  So we add
the I2C_MODULE_PREFIX to the request_module() string.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/of/of_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index c85d3c7..f37fbeb 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -61,7 +61,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 		info.of_node = of_node_get(node);
 		info.archdata = &dev_ad;
 
-		request_module("%s", info.type);
+		request_module("%s%s", I2C_MODULE_PREFIX, info.type);
 
 		result = i2c_new_device(adap, &info);
 		if (result == NULL) {
-- 
1.7.2.3
