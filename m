Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 13:22:41 +0200 (CEST)
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:31689 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeIELWhd0hAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 13:22:37 +0200
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15b8fbc73027-edecd; Wed, 05 Sep 2018 19:22:27 +0800 (CST)
X-RM-TRANSID: 2ee15b8fbc73027-edecd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25b8fbc72daa-a4a19;
        Wed, 05 Sep 2018 19:22:27 +0800 (CST)
X-RM-TRANSID: 2ee25b8fbc72daa-a4a19
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH V2] mips: txx9: fix resource leak after register fail
Date:   Wed,  5 Sep 2018 19:22:19 +0800
Message-Id: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <dingxiang@cmss.chinamobile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65950
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

the memory allocated and ioremap address need free after
device_register return error.

v2: remove redundant "return"

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/mips/txx9/generic/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182..e116a55 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -961,11 +961,12 @@ void __init txx9_sramc_init(struct resource *r)
 	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
 	if (err) {
 		device_unregister(&dev->dev);
-		iounmap(dev->base);
-		kfree(dev);
+		goto exit_free;
 	}
 	return;
 exit_put:
 	put_device(&dev->dev);
-	return;
+exit_free:
+	iounmap(dev->base);
+	kfree(dev);
 }
-- 
1.9.1
