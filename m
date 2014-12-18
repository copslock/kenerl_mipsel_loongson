Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 03:39:19 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56262 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008924AbaLRCjSTFKUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 03:39:18 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so386106pad.38;
        Wed, 17 Dec 2014 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=a0FOEhEkK+qF63CnecPj2IRZoFE+tPGA+ukKzx9nlVw=;
        b=Ni6bwJeF2OfqS8qUaRTE989sKqrbGaomEA5D5fuTMUGrXe8VEVTVHL0KQ0O+Yfp2rb
         lb9S6axbDHwCFAeXAyNoysP7PNv04PYv9m6oQYJc91rhvwJO3p9Sktw6dSNASX+52kCM
         PMtBWShdF8vNxw2JtsWiF+Frsmru3oQQc7y5o+4+cR2jlY5YsPaNwfVje6FNRX7dBSWh
         t+vjrKD3wk9m4ijhoBrOHuQBMV1iBxGZbXwGQ20lN2Nu5DC738z3D1NNNpFYKt5y2G3e
         zRJ3Q/9n5f566OKtYp9qGR4m+eHMfmlTJv068cnAwR33QDffY9Tdxj7RbnubQt7ojIBU
         t2Sg==
X-Received: by 10.70.37.202 with SMTP id a10mr74861558pdk.107.1418870352106;
        Wed, 17 Dec 2014 18:39:12 -0800 (PST)
Received: from ld-irv-0074.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ur2sm5145467pbc.51.2014.12.17.18.39.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Dec 2014 18:39:11 -0800 (PST)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
Date:   Wed, 17 Dec 2014 18:39:01 -0800
Message-Id: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44717
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

Fixes sparse warnings:

  arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
  arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?

Also, I've seen some elusive build errors on my automated build test
where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
them manually for some reason. Anyway, mach-jz4740/irq.h should help us
avoid relying on some implicit include.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/mips/jz4740/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 2531da1d3add..97206b3deb97 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -30,6 +30,9 @@
 #include <asm/irq_cpu.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/irq.h>
+
+#include "irq.h"
 
 static void __iomem *jz_intc_base;
 
-- 
1.9.1
