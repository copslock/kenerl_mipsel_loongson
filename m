Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 02:10:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50081 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009931AbaJXAK0K70bb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Oct 2014 02:10:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9O0APE7012630;
        Fri, 24 Oct 2014 02:10:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9O0AOZe012629;
        Fri, 24 Oct 2014 02:10:24 +0200
Message-Id: <094cb31b3dafa8c614db1e03a0049e566008a2e0.1414108953.git.ralf@linux-mips.org>
In-Reply-To: <20141023235416.GA7529@linux-mips.org>
References: <20141023235416.GA7529@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 24 Oct 2014 00:41:45 +0200
Subject: [PATCH 1/3] MIPS: SEAD3: Fix LED device registration.
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

This isn't a module and shouldn't be one.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mti-sead3/sead3-leds.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-leds.c b/arch/mips/mti-sead3/sead3-leds.c
index 20102a6..c427c57 100644
--- a/arch/mips/mti-sead3/sead3-leds.c
+++ b/arch/mips/mti-sead3/sead3-leds.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
@@ -76,8 +76,4 @@ static int __init led_init(void)
 	return platform_device_register(&fled_device);
 }
 
-module_init(led_init);
-
-MODULE_AUTHOR("Chris Dearman <chris@mips.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("LED probe driver for SEAD-3");
+device_initcall(led_init);
-- 
1.9.3
