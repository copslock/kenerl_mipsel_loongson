Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 14:42:46 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34203 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009499AbbJEMmoimNz8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 14:42:44 +0200
Received: by wicfx3 with SMTP id fx3so117864414wic.1;
        Mon, 05 Oct 2015 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gZRVMdKtO5qDmVfms+jBfUs8UlEMcQpWFRSDTrDHXes=;
        b=fJAyOdveYlBs4nKCWIUhjPhWWTDGZsyCQjEvNca5KaV1QKfQ/qPazHqdCGGpjYKOt7
         LHzvZG05EYBTbc81SpxEcwPIjdGucUL9BnI487lZNlxkBwgqGDFt/zlIfr+7/4xfq9yi
         8LTJ/hZGJv6YJNPYf4E+4zSSqkuEft9rImRPm1v2cqKxl4PtPZIkEqzfYn8uls7/VDEP
         gv1X7GqveWHKccraqa6LrDh1Y8K4+CdiCwG6mrDMCdAKmlqf2qSZ/YRcvNvI53WM3ypY
         eAyw+hd8Sj4qMT4dGWl1UfwYB7pDp9pSCfYMMGYvnEtTU4FdOz+TUZTBVjW1Pc/lfoIj
         PgaQ==
X-Received: by 10.180.39.139 with SMTP id p11mr10487484wik.44.1444048959350;
        Mon, 05 Oct 2015 05:42:39 -0700 (PDT)
Received: from localhost (port-54044.pppoe.wtnet.de. [46.59.211.200])
        by smtp.gmail.com with ESMTPSA id hd1sm14478391wib.5.2015.10.05.05.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 05:42:38 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] MIPS: jz4740: qi_lb60: Remove unused linux/leds_pwm.h include
Date:   Mon,  5 Oct 2015 14:42:37 +0200
Message-Id: <1444048957-29486-1-git-send-email-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

The board code never sets up a leds-pwm device, so including the header
is not necessary.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/mips/jz4740/board-qi_lb60.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 0e6ad22d265c..79f37c2aa298 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -34,8 +34,6 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
-#include <linux/leds_pwm.h>
-
 #include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/platform.h>
 
-- 
2.5.0
