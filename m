Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:04:23 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60427 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2EUGCP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:02:15 +0200
Received: by mail-wg0-f43.google.com with SMTP id dr1so3995385wgb.24
        for <multiple recipients>; Sun, 20 May 2012 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CmDeuBOUT3p8nrzrJm+4uWaeeD6onOicPLscm+V9ZsM=;
        b=YXpZ7t/jTdzx58rs0eQdNAmbz673fNXuwOkJNoSIeDpUmKbYAMNMUHQn0cUbSUHLEO
         AYvfXTLrZwRtTE+mu6NTYdxkQWtog2580q3STNaa7GTyJlV0WzUo9t7AYSvweStNt6Cy
         1o9Kt7wN90pMZvv65pPO+rq3+1Wd/lkWq3D1S8ROBSpVevqBW8QdlnQAlf9FW20aAHA6
         ksK/IAn7cPDwGTRwA1f3DGSoEP5gK6xYDGJjcN+NBMQvxF23g+YO19kLdW2SLJGyl6Ts
         f7CDyUFTFdgL8uUbCVLCAgvPiXk7IEaL4OubRYFRgRrsEu0xjiQjJ3mL35yv+k2id2j/
         i8Tg==
Received: by 10.180.100.230 with SMTP id fb6mr21493370wib.3.1337580135285;
        Sun, 20 May 2012 23:02:15 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id g10sm23594119wiw.0.2012.05.20.23.02.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:02:14 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 7/8] MIPS: smp: Warn on too early irq enable
Date:   Mon, 21 May 2012 14:00:07 +0800
Message-Id: <1337580008-7280-8-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

Just to catch a potential issue.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/smp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 042145f..4fbafa8 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -130,6 +130,11 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	synchronise_count_slave();
 
+	/*
+	 * irq will be enabled in ->smp_finish(), enabling it too early
+	 * is dangerous.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
 	mp_ops->smp_finish();
 
 	cpu_idle();
-- 
1.7.5.4
