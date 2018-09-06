Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 06:19:37 +0200 (CEST)
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:42126 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991923AbeIFETc4Z0Jg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 06:19:32 +0200
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b90aacb150-fd431; Thu, 06 Sep 2018 12:19:23 +0800 (CST)
X-RM-TRANSID: 2ee45b90aacb150-fd431
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95b90aaca608-d0b3f;
        Thu, 06 Sep 2018 12:19:23 +0800 (CST)
X-RM-TRANSID: 2ee95b90aaca608-d0b3f
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH] mips: txx9: fix iounmap related issue
Date:   Thu,  6 Sep 2018 12:19:19 +0800
Message-Id: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <dingxiang@cmss.chinamobile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingxiang@cmss.chinamobile.com
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

if device_register return error, iounmap should be called, also iounmap
need to call before put_device.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/mips/txx9/generic/setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182..70a1ab6 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -960,12 +960,11 @@ void __init txx9_sramc_init(struct resource *r)
 		goto exit_put;
 	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
 	if (err) {
-		device_unregister(&dev->dev);
 		iounmap(dev->base);
-		kfree(dev);
+		device_unregister(&dev->dev);
 	}
 	return;
 exit_put:
+	iounmap(dev->base);
 	put_device(&dev->dev);
-	return;
 }
-- 
1.9.1
