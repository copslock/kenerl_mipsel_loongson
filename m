Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2011 15:04:29 +0100 (CET)
Received: from mail-qw0-f42.google.com ([209.85.216.42]:61473 "EHLO
        mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903708Ab1LAOEY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Dec 2011 15:04:24 +0100
Received: by qabg40 with SMTP id g40so4026679qab.15
        for <multiple recipients>; Thu, 01 Dec 2011 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:cc:date:content-type:x-mailer
         :content-transfer-encoding:mime-version;
        bh=sFQWSnBEzG5MYOVg2yV3FugcyoDTXl/YnxixIx5iKAY=;
        b=TsxK2jBDt7D+cBSdk/TWjwgIcl/oEgYxdmjJjUqwOwuozo5XnnXjAP9sJgRFEa4j/y
         GMtSQqSvpEymoPk8eO3ONClNxhYBosFxvZBuTeYyMDd3MrbRqzk0Wh8ujXRhXM7sNYvb
         3N9fEmNuRCnrVXCIsvYKADzH5rNqvu5WYAoMo=
Received: by 10.229.62.227 with SMTP id y35mr1315325qch.54.1322748257607;
        Thu, 01 Dec 2011 06:04:17 -0800 (PST)
Received: from [218.172.233.210] (218-172-233-210.dynamic.hinet.net. [218.172.233.210])
        by mx.google.com with ESMTPS id cd3sm5741784qab.5.2011.12.01.06.04.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 06:04:16 -0800 (PST)
Message-ID: <1322748247.31743.1.camel@phoenix>
Subject: [PATCH] MTD: nand: Convert au1550nd to use module_platform_driver()
From:   Axel Lin <axel.lin@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mtd@lists.infradead.org
Date:   Thu, 01 Dec 2011 22:04:07 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.1- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 32016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: axel.lin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 574

Cc: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi Ralf,
This patch converts au1550nd to use module_platform_driver().
You have committed a5bd32fd "MTD: nand: make au1550nd.c a platform_driver".
Currently this patch can only apply to either your tree or linux-next.
Could you help to take it.
( committed a5bd32fd does not exist in l2-mtd-2.6.git,
so Artem cannot apply it.)

Thanks,
Axel

 drivers/mtd/nand/au1550nd.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 77fb4e6..73abbc3 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -560,17 +560,7 @@ static struct platform_driver au1550nd_driver = {
 	.remove		= __devexit_p(au1550nd_remove),
 };
 
-static int __init au1550nd_load(void)
-{
-	return platform_driver_register(&au1550nd_driver);
-};
-
-static void __exit au1550nd_exit(void)
-{
-	platform_driver_unregister(&au1550nd_driver);
-};
-module_init(au1550nd_load);
-module_exit(au1550nd_exit);
+module_platform_driver(au1550nd_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Embedded Edge, LLC");
-- 
1.7.5.4
