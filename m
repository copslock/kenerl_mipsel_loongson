Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2012 18:50:41 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64373 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872769Ab2JKQu0pdHJN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2012 18:50:26 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2017489pad.36
        for <multiple recipients>; Thu, 11 Oct 2012 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4yfvNuu3eLDjb6r1Mgsm2GKXDVyUW55XZy91JSgDuYU=;
        b=i8PNhGsrKvbi7BxQlojsCqrVr4bHeM1wLoV8Xu66HjVrJE6aIbdo4FabKJa8NwSgvH
         m7WhgwCJPuVt8UW05DI4ZFAh8u8ig5DpYeyHCivYO6kWjUxFly/+jBvP09hLzLLixLsw
         MmpocIFY1BRgZQudTf8ZlVl71h7UPNjHq4/sWSzVk04TY+luEo9FteXL+Lzg5UeNdaUi
         tRJVapM8hmqB4ycfpY9WEhhkg4COx5th1HUg2pTMaXcl130UsGSTOin1HKLQycrWxNuH
         qHhTsB66xRM1FW/fFcTcQvXrFplW6uBx6l0qxkmHSAwSvfzqaIGq/FXGGClgpRGJLpyK
         +A1A==
Received: by 10.68.116.239 with SMTP id jz15mr5369638pbb.43.1349974219521;
        Thu, 11 Oct 2012 09:50:19 -0700 (PDT)
Received: from localhost.localdomain ([115.111.18.195])
        by mx.google.com with ESMTPS id rz10sm2988095pbc.32.2012.10.11.09.50.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2012 09:50:19 -0700 (PDT)
From:   jerin jacob <jerinjacobk@gmail.com>
To:     ralf@linux-mips.org
Cc:     jerin jacob <jerinjacobk@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS:CMP Fix physical core number calculation logic
Date:   Thu, 11 Oct 2012 22:18:51 +0530
Message-Id: <1349974131-5856-1-git-send-email-jerinjacobk@gmail.com>
X-Mailer: git-send-email 1.7.6.5
X-archive-position: 34687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerinjacobk@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

CPUNum Field in EBase register is 10bit wide, so after 1 bit right shift, mask
value should be 0x1ff

Signed-off-by: jerin jacob <jerinjacobk@gmail.com>
---
 arch/mips/kernel/smp-cmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index afc379c..06cd0c6 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -97,7 +97,7 @@ static void cmp_init_secondary(void)
 
 	/* Enable per-cpu interrupts: platform specific */
 
-	c->core = (read_c0_ebase() >> 1) & 0xff;
+	c->core = (read_c0_ebase() >> 1) & 0x1ff;
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
 	c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE;
 #endif
-- 
1.7.6.5
