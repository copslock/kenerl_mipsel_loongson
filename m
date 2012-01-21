Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 18:14:40 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:41816 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901171Ab2AURNa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 18:13:30 +0100
Received: by eaak10 with SMTP id k10so321460eaa.36
        for <multiple recipients>; Sat, 21 Jan 2012 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hm4w709c0JsAoNDi6LeDezDZgaoIg87Wgx1H4HE6QGI=;
        b=pLAvwtP0zJzWaMVNdxhlTHA2CEdYYAoPYneuv6Wg7PxTGqcQDuIZuzRI9kSmTpmo3+
         Y1sArhV1vGACURaj4Vr6daJac61cIYwSxdo8laoVN9LwzhEkGFSRnSpERtSnzMrjk/IS
         u19sviwQRY7LEWTJyeFobc4WnZadQhspriy2o=
Received: by 10.213.109.3 with SMTP id h3mr444616ebp.132.1327166004772;
        Sat, 21 Jan 2012 09:13:24 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-10-45.adsl.highway.telekom.at. [188.22.10.45])
        by mx.google.com with ESMTPS id x4sm28076665eeb.4.2012.01.21.09.13.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 09:13:24 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 3/3] MIPS: Alchemy: handle db1200 cpld ints as they come in
Date:   Sat, 21 Jan 2012 18:13:15 +0100
Message-Id: <1327165995-27425-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
References: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 32298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove the loop in the cascade handler and instead unconditionally
handle just the first set interrupt coming from the CPLD.

This gets rid of a lot of spurious interrupts being triggered for
the SMSC91111 ethernet chip especially under high(er) IDE load:
"eth0: spurious interrupt (mask = 0xb3)"

Verified on DB1200 and DB1300.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/bcsr.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 1e83ce2..f2039ef 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -90,10 +90,7 @@ static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
 	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
 
 	disable_irq_nosync(irq);
-
-	for ( ; bisr; bisr &= bisr - 1)
-		generic_handle_irq(bcsr_csc_base + __ffs(bisr));
-
+	generic_handle_irq(bcsr_csc_base + __ffs(bisr));
 	enable_irq(irq);
 }
 
-- 
1.7.8.4
