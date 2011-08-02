Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:54:37 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:34084 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491756Ab1HBRv3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:29 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so73231fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c4E/eW55d0u1Jjyr6jTuGw4wIQJM+hgJ7pWlIhCxmUE=;
        b=BbkwSjB/2PcZxlbnpy8/7BsMjs9YeqMsuLrCpWXkdd9i4dSMvUZJpfyoSdV7ge1QoX
         h5lbg+hKQZ5BEmLXLwliQ/WoOKe4fd7r93XHHTe8QfAisgedhWLqMNiSg8rGa9tUQqqO
         wctk822cud7KdCixWyDKL1rmhCiALBHqNxQ2E=
Received: by 10.223.159.202 with SMTP id k10mr6609995fax.6.1312307489147;
        Tue, 02 Aug 2011 10:51:29 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:28 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 07/15] MIPS: Alchemy: always build power code
Date:   Tue,  2 Aug 2011 19:51:02 +0200
Message-Id: <1312307470-6841-8-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1618

No reason NOT to build it

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/power.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index e53b4ce..bdd6651 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -37,8 +37,6 @@
 #include <asm/uaccess.h>
 #include <asm/mach-au1x00/au1000.h>
 
-#ifdef CONFIG_PM
-
 /*
  * We need to save/restore a bunch of core registers that are
  * either volatile or reset to some state across a processor sleep.
@@ -132,5 +130,3 @@ void au_sleep(void)
 
 	restore_core_regs();
 }
-
-#endif	/* CONFIG_PM */
-- 
1.7.6
