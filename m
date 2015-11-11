Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 00:36:34 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33638 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006528AbbKKXgct3Wp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 00:36:32 +0100
Received: by pabfh17 with SMTP id fh17so44714206pab.0;
        Wed, 11 Nov 2015 15:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TWakMenygO/PDbFijlQIgy+LT8Wx/XpHyvg3DiMshno=;
        b=A08eCHLGOuLgJMzQqfirrh5Q5cig1GdNaN7+UzBq6/TSXLc/e4lshUmLB1q2eYMRax
         TBrQzUZbQ5Ql41TLdb8AZjTExC67UREvDo2ONzsqnnviwIFJELcqwFG6xpLREOH82I3A
         7jp8Ad+5MZcy3e4cect9V6pjI7jS2LmaTnkh3/KMTw0GOQGhk6KDz2wo2wh+WRM8pnBj
         Ia4SOZwMu51SM3TKQA/kBW3E6gWqp9fu02kSjbuCKRrmm8tAnSIRLABm/4BqtUI/+WS7
         W2vNOhVsA+kIew/h1ITZa395/Ui4pNdHKwuzTav19++t6PcId3GC5CguerlAO8PPUS90
         U+uA==
X-Received: by 10.66.153.166 with SMTP id vh6mr18653381pab.83.1447284986810;
        Wed, 11 Nov 2015 15:36:26 -0800 (PST)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id lo9sm11333136pab.19.2015.11.11.15.36.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 15:36:26 -0800 (PST)
From:   Brian Norris <computersforpeace@gmail.com>
To:     <linux-mtd@lists.infradead.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mtd: jz4740_nand: fix build on jz4740 after removing gpio.h
Date:   Wed, 11 Nov 2015 15:36:16 -0800
Message-Id: <1447284976-96693-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Fallout from commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")

We see errors like this:

drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_detect_bank':
drivers/mtd/nand/jz4740_nand.c:340:9: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
drivers/mtd/nand/jz4740_nand.c:340:9: note: each undeclared identifier is reported only once for each function it appears in
drivers/mtd/nand/jz4740_nand.c:359:2: error: implicit declaration of function 'jz_gpio_set_function' [-Werror=implicit-function-declaration]
drivers/mtd/nand/jz4740_nand.c:359:29: error: 'JZ_GPIO_FUNC_MEM_CS0' undeclared (first use in this function)
drivers/mtd/nand/jz4740_nand.c:399:29: error: 'JZ_GPIO_FUNC_NONE' undeclared (first use in this function)
drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_probe':
drivers/mtd/nand/jz4740_nand.c:528:13: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_remove':
drivers/mtd/nand/jz4740_nand.c:555:14: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)

Patched similarly to:

https://patchwork.linux-mips.org/patch/11089/

Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/jz4740_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index dc4e8446f1ff..5a99a93ed025 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -25,6 +25,7 @@
 
 #include <linux/gpio.h>
 
+#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_nand.h>
 
 #define JZ_REG_NAND_CTRL	0x50
-- 
2.6.0.rc2.230.g3dd15c0
