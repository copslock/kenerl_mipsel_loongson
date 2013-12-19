Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2013 16:05:25 +0100 (CET)
Received: from mail-ea0-f175.google.com ([209.85.215.175]:40249 "EHLO
        mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867268Ab3LSPEpyQE1W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Dec 2013 16:04:45 +0100
Received: by mail-ea0-f175.google.com with SMTP id z10so536155ead.6
        for <multiple recipients>; Thu, 19 Dec 2013 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1AEIJDg1JZuqVd3qoJDzkAbN1Bsi/o94choHT3vcLQ=;
        b=sAfJhJkcKdJuw4Z093XwrHMuy7e5Y+Gbc9cURiPwXFh7y2/LhBxSGeha+9MagYoM8U
         JEzeryoCuNRkbHjOmysi1au+tjW2GFSLrX7aQOi9Ju3wx4NzITlgKFjMIKtI9LBKQoTi
         DtTMyyGYtz/1Qkb7diL0M+kCeiN0E5hnz7OvHr2DxxuC8Gd8yl1FWa9Sv7nFp4ECde7W
         P/dr7Ve8iPS3W0KA6KqWQI2ZvzWRKeWBAHNBmS4E/h3y86bnkHBPe0pOdXTfFw/wJfcm
         6FRfK8HecjRlRgYVbo2PPcRy4QGC8yqUankLInj4nmIuuA1gYBawlu71+30CUy3XmXvg
         2Kxw==
X-Received: by 10.15.34.197 with SMTP id e45mr27361eev.61.1387465480623;
        Thu, 19 Dec 2013 07:04:40 -0800 (PST)
Received: from localhost.tiszanet.hu (mail.mediaweb.hu. [62.201.96.214])
        by mx.google.com with ESMTPSA id h48sm10102799eev.3.2013.12.19.07.04.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2013 07:04:40 -0800 (PST)
From:   Levente Kurusa <levex@linux.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Levente Kurusa <levex@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 16/38] mips: sgi-ip22: add missing put_device call
Date:   Thu, 19 Dec 2013 16:03:27 +0100
Message-Id: <1387465429-3568-17-git-send-email-levex@linux.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Return-Path: <ilevex.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levex@linux.com
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

This is required so that we give up the last reference to the device.

Also, create a gio_bus_release() that calls kfree on the device argument to
properly kfree() the memory allocated for the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index ab0e379..931da33 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -24,8 +24,13 @@ static struct {
 	{ .name = "SGI GR2/GR3", .id = 0x7f },
 };
 
+void gio_bus_release(struct device *dev) {
+	kfree(dev);
+}
+
 static struct device gio_bus = {
 	.init_name = "gio",
+	.release = &gio_bus_release,
 };
 
 /**
@@ -400,8 +405,10 @@ int __init ip22_gio_init(void)
 	int ret;
 
 	ret = device_register(&gio_bus);
-	if (ret)
+	if (ret) {
+		put_device(&gio_bus);
 		return ret;
+	}
 
 	ret = bus_register(&gio_bus_type);
 	if (!ret) {
-- 
1.8.3.1
