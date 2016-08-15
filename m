Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 22:32:04 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:50102 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992439AbcHOUbeGcDJS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 22:31:34 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u7FKVOS7026441
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 15 Aug 2016 13:31:24 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Mon, 15 Aug 2016 13:31:24 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/4] mips: ralink: make timer explicitly non-modular
Date:   Mon, 15 Aug 2016 16:30:53 -0400
Message-ID: <20160815203055.20541-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160815203055.20541-1-paul.gortmaker@windriver.com>
References: <20160815203055.20541-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

The Makefile entry controlling compilation of this code is "obj-y"
meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We don't replace module.h with init.h since the file already has that.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/ralink/timer.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index b0343ff336c5..8077ff39bdea 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -1,4 +1,7 @@
 /*
+ * Ralink RT2880 timer
+ * Author: John Crispin
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
@@ -6,7 +9,6 @@
  * Copyright (C) 2013 John Crispin <john@phrozen.org>
 */
 
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
@@ -152,33 +154,17 @@ static int rt_timer_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rt_timer_remove(struct platform_device *pdev)
-{
-	struct rt_timer *rt = platform_get_drvdata(pdev);
-
-	rt_timer_disable(rt);
-	rt_timer_free(rt);
-
-	return 0;
-}
-
 static const struct of_device_id rt_timer_match[] = {
 	{ .compatible = "ralink,rt2880-timer" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, rt_timer_match);
 
 static struct platform_driver rt_timer_driver = {
 	.probe = rt_timer_probe,
-	.remove = rt_timer_remove,
 	.driver = {
-		.name		= "rt-timer",
-		.of_match_table	= rt_timer_match
+		.name			= "rt-timer",
+		.of_match_table		= rt_timer_match,
+		.suppress_bind_attrs	= true,
 	},
 };
-
-module_platform_driver(rt_timer_driver);
-
-MODULE_DESCRIPTION("Ralink RT2880 timer");
-MODULE_AUTHOR("John Crispin <john@phrozen.org");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(rt_timer_driver);
-- 
2.8.4
