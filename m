Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2011 11:20:24 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40422 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1GHJSy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2011 11:18:54 +0200
Received: by fxd20 with SMTP id 20so1399570fxd.36
        for <multiple recipients>; Fri, 08 Jul 2011 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3efbWbcTLeLW9rfV0SCWe038k+uCJfOGEYTyw/HDp/Q=;
        b=BZhKfaMCaHSgvVp0N8b2p8FnZ9lKDWvbKMWaoMWgI24icuNQzZmOPXjJPdzYbVlPyZ
         cYtSUxYFWM2niuN+ephN3iPTNFOFoHCOKPQa32fwKN1XxZk/OkqSYO5tm1sXAw9xOh+V
         HgfDW4lnS6sl9AIjQzPT73UoeOt56JQGLsV0g=
Received: by 10.223.68.22 with SMTP id t22mr2736829fai.145.1310116729618;
        Fri, 08 Jul 2011 02:18:49 -0700 (PDT)
Received: from localhost.localdomain (188-22-147-55.adsl.highway.telekom.at [188.22.147.55])
        by mx.google.com with ESMTPS id k26sm7260413fak.24.2011.07.08.02.18.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jul 2011 02:18:49 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/5] MIPS: Alchemy: include Au1100 in PM code.
Date:   Fri,  8 Jul 2011 11:18:40 +0200
Message-Id: <1310116723-8632-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1310116723-8632-1-git-send-email-manuel.lauss@googlemail.com>
References: <1310116723-8632-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5981

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
