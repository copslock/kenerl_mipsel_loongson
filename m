Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 09:41:44 +0200 (CEST)
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:11227 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeIEHlktzOsB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 09:41:40 +0200
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5b8f88aa618-e6827; Wed, 05 Sep 2018 15:41:30 +0800 (CST)
X-RM-TRANSID: 2eea5b8f88aa618-e6827
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35b8f88a8ed6-94b61;
        Wed, 05 Sep 2018 15:41:30 +0800 (CST)
X-RM-TRANSID: 2ee35b8f88a8ed6-94b61
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH] mips: txx9: fix resource leak after register fail
Date:   Wed,  5 Sep 2018 15:41:27 +0800
Message-Id: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <dingxiang@cmss.chinamobile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65936
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

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/mips/txx9/generic/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182..7f4fd2b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -961,11 +961,13 @@ void __init txx9_sramc_init(struct resource *r)
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
+exit_free:
+	iounmap(dev->base);
+	kfree(dev);
 	return;
 }
-- 
1.9.1
