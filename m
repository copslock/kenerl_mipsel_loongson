Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2011 20:11:08 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:46498 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491765Ab1FWSLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2011 20:11:04 +0200
Received: by wyf23 with SMTP id 23so1829157wyf.36
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2011 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=K8zqxuGHz95ODiADsAp76bf9YD8/tfeC3OhAD61+ovg=;
        b=GlBVIZNxbwwqzMH9pIg5ftLDaBErY11sm+8SPpTJOhJ0SG9uzFWdPNj0K70XkPf2mF
         Gl1LwDjubF7Uo3RGZ8j4R+I20pZ1pGI0p7iwg+iXFVSos4vZBLm2b2Nio3DM9p7B2W40
         S9Afw7SyxbFLRQeOORgW/XcO5yv73Dr0fUNuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OZEWJ/jQc8rtq5TYLxCEgEKhiXmf8FPYOTHu9lTgmS8+dho2soEENddwrhf3TAS9Au
         ciUN+aCq5z31gTkpYcOfTlh4ZNvHdYPOdm9ROfpw5MO1wT5MN2MFNrfrI6ZYBwCyvomJ
         J1twuTUFnn6aL6Xu3zESrzoXoiuZKz21I3SX8=
Received: by 10.227.5.210 with SMTP id 18mr2257589wbw.18.1308852658447;
        Thu, 23 Jun 2011 11:10:58 -0700 (PDT)
Received: from localhost.localdomain (178-191-3-111.adsl.highway.telekom.at [178.191.3.111])
        by mx.google.com with ESMTPS id ej7sm1416388wbb.36.2011.06.23.11.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 11:10:57 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: include Au1100 in PM code.
Date:   Thu, 23 Jun 2011 20:10:54 +0200
Message-Id: <1308852654-26720-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.3
X-archive-position: 30496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19609

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
1.7.5.3
