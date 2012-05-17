Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:13:26 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903706Ab2EQKMA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:12:00 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0IRlgv01dAknhKBKmA6R21toMapphhEqrBvlfTwAgmg=;
        b=FxQ+4iLaZ0NBIqJC4maFJI5GGb3SOlUtCbOLVVS/vj8BvXrLW1bzDILV/YtrZW6PY1
         N/WwVYahrenz6uG8vdIO8gdOhoFvoV6e6mss4VozXNme9jdKjYrXOFfDQ+0u46ZuKlmu
         XQi94So5CyLGSm38LfC4mLTlk4bilKLlCNlYCdFkgtnT1yrlA4SKc6v5GtyQgPVi0ycZ
         3UGRxtzsVLWj1pCHWXIicfi2JqFgdfwmRtXos76mSptQuGJdtitTGCHJ5wh9ilbfD6or
         NrYXbpLHxxDL79dT3IUUqec6I7cb8SJKRMvK6PvmZ+EN0G18N/0RPw6lAB0pU/cPtDIt
         A92Q==
Received: by 10.68.200.68 with SMTP id jq4mr26644430pbc.42.1337249519168;
        Thu, 17 May 2012 03:11:59 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id nw7sm4181546pbb.73.2012.05.17.03.11.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:11:58 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 7/8] MIPS: smp: Warn on too early irq enable
Date:   Thu, 17 May 2012 18:10:09 +0800
Message-Id: <1337249410-7162-8-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33348
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
---
 arch/mips/kernel/smp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 042145f..0d48598 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -130,6 +130,11 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	synchronise_count_slave();
 
+	/*
+	 * irq will be enabled in ->smp_finish(), enable it too early
+	 * is dangerous.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
 	mp_ops->smp_finish();
 
 	cpu_idle();
-- 
1.7.1
