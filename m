Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 22:31:40 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:42347 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992263AbcHOUbdyPjuS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 22:31:33 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u7FKVQLW013820
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 15 Aug 2016 13:31:26 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Mon, 15 Aug 2016 13:31:25 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] mips: lantiq: make vmmc explicitly non-modular
Date:   Mon, 15 Aug 2016 16:30:54 -0400
Message-ID: <20160815203055.20541-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160815203055.20541-1-paul.gortmaker@windriver.com>
References: <20160815203055.20541-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54553
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

The Makefile entry controlling compilation of this code is:

arch/mips/lantiq/xway/vmmc.o
   ---> arch/mips/lantiq/xway/Makefile:obj-y += vmmc.o

...meaning that it currently is not being built as a module by anyone.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We replace module.h with export.h since the file does actually use
EXPORT_SYMBOL.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/lantiq/xway/vmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index 4625495f9230..577ec81b557d 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
@@ -55,7 +55,6 @@ static const struct of_device_id vmmc_match[] = {
 	{ .compatible = "lantiq,vmmc-xway" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, vmmc_match);
 
 static struct platform_driver vmmc_driver = {
 	.probe = vmmc_probe,
@@ -64,5 +63,4 @@ static struct platform_driver vmmc_driver = {
 		.of_match_table = vmmc_match,
 	},
 };
-
-module_platform_driver(vmmc_driver);
+builtin_platform_driver(vmmc_driver);
-- 
2.8.4
