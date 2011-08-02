Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:53:13 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45013 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491192Ab1HBRvZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:25 +0200
Received: by fxd20 with SMTP id 20so73262fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3efbWbcTLeLW9rfV0SCWe038k+uCJfOGEYTyw/HDp/Q=;
        b=frRbHVGTNOfGrRmTmg66o0Na+vouZPHkI7EGpZx5Yn4JqOv3ButoXWCs3XmncGG+oY
         sTEcvFvG67JY+YS/2f2yxLGkl8nq+8jn78uKytbLeHWPG0bGDbvSu9br8HY4esWk/gpi
         2O+sBRD1HBfqxThnmtpZ6wIFjBk03kKglYYfM=
Received: by 10.223.24.92 with SMTP id u28mr8457996fab.148.1312307480167;
        Tue, 02 Aug 2011 10:51:20 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:19 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 03/15] MIPS: Alchemy: include Au1100 in PM code.
Date:   Tue,  2 Aug 2011 19:50:58 +0200
Message-Id: <1312307470-6841-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1615

The current code forgets the Au1100 when looking for the
correct method to suspend the chip.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/power.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 647e518..b86324a 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -158,15 +158,21 @@ static void restore_core_regs(void)
 
 void au_sleep(void)
 {
-	int cpuid = alchemy_get_cputype();
-	if (cpuid != ALCHEMY_CPU_UNKNOWN) {
-		save_core_regs();
-		if (cpuid <= ALCHEMY_CPU_AU1500)
-			alchemy_sleep_au1000();
-		else if (cpuid <= ALCHEMY_CPU_AU1200)
-			alchemy_sleep_au1550();
-		restore_core_regs();
+	save_core_regs();
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		alchemy_sleep_au1000();
+		break;
+	case ALCHEMY_CPU_AU1550:
+	case ALCHEMY_CPU_AU1200:
+		alchemy_sleep_au1550();
+		break;
 	}
+
+	restore_core_regs();
 }
 
 #endif	/* CONFIG_PM */
-- 
1.7.6
