Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 23:23:19 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:56880 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab1LNWXM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2011 23:23:12 +0100
Received: by yenl2 with SMTP id l2so1082656yen.36
        for <multiple recipients>; Wed, 14 Dec 2011 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=q5cZrpvPooLWtWy6axJ23sticwLHgS0zcqefS/zs1DE=;
        b=kjb6xbG9a1FGDf9rxt9CSYDCGuH45dSmrkiCYQIlIHuHNPeEXhatlIgqHBP7JD0JwL
         lXKoZrILLsyczWyMsRtjGw84A3zJwwtUb46n24wMJbUnW7X5ha00viuPvqtdv9GZkD+e
         86cOmwtSnpVgpyRHSIbsCIcWPt1ytf/PN+L7U=
Received: by 10.236.201.200 with SMTP id b48mr732110yho.76.1323901386403;
        Wed, 14 Dec 2011 14:23:06 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id q52sm5717864yhh.3.2011.12.14.14.23.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 14:23:05 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBEMN3lU021128;
        Wed, 14 Dec 2011 14:23:03 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBEMN2gG021127;
        Wed, 14 Dec 2011 14:23:02 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Get rid of arch specific irq_dispose_mapping.
Date:   Wed, 14 Dec 2011 14:23:00 -0800
Message-Id: <1323901380-21094-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11823

From: David Daney <david.daney@cavium.com>

It is now defined in kernel/irq/irqdomain.c

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/irq.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 2354c87..dc650ae 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -16,10 +16,6 @@
 
 #include <irq.h>
 
-static inline void irq_dispose_mapping(unsigned int virq)
-{
-}
-
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
-- 
1.7.2.3
