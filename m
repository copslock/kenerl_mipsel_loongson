Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 19:39:32 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40352 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904272Ab1KISjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 19:39:20 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so2552054faa.36
        for <multiple recipients>; Wed, 09 Nov 2011 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+vkfPZ56LgbPqlSWQSReWw/cyMEVMqHvn1P4lT9vEFA=;
        b=V2KATtbPyPR/Pp9e6hBOa9EVQV2V10KcXRXNWU2WDSHAv0V6nj04IiyO8hICU4AfC5
         53YPhiguT0M95wPA2ukv1vU+isyr93cCZltbrpwpHufkNx0WCC3hMzn2W68FGK7ELoYD
         p+lUL/DvF9E791PlWDOnVo6O3KvB+ihe+mjro=
Received: by 10.152.162.10 with SMTP id xw10mr2358328lab.12.1320863960013;
        Wed, 09 Nov 2011 10:39:20 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-4-90.adsl.highway.telekom.at. [178.191.4.90])
        by mx.google.com with ESMTPS id hh9sm4935970lab.1.2011.11.09.10.39.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 10:39:19 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: db1100: fix build: missing module.h
Date:   Wed,  9 Nov 2011 19:39:15 +0100
Message-Id: <1320863955-14609-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <20111109145325.GL19187@linux-mips.org>
References: <20111109145325.GL19187@linux-mips.org>
X-archive-position: 31477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8039

fix build against 3.2-rc1, add a missing module.h (symbol_get/symbol_put).

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please fold into "[PATCH 12/18] MIPS: Alchemy: MMC for DB1100".

 arch/mips/alchemy/devboards/db1000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index e110f6d..1b81dbf 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
-- 
1.7.7.2
