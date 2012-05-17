Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:13:53 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52330 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903721Ab2EQKM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:12:28 +0200
Received: by pbbrq13 with SMTP id rq13so2662943pbb.36
        for <multiple recipients>; Thu, 17 May 2012 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Oo9L+gxflitZcH1htHyBRVs8kTnhDD+DQlDQWnojuJY=;
        b=DJxssIDqdN5fzvfsHLy2L69JqS/SjOJ6jIRStiLmit+N13KSoBqLRb4aigIZH57Q6Y
         wn/v44vT7HkSGtlTb+WXur89BwF/G3Y26RrTY5K9snMZiRpuwYuv1Cmox+4FovEsouhx
         QsWDzvfHzFuzZJsQRmudEzFgt++ky/OT/fAd2epOXY6POkt7DLr6vzAqd64jiwfsx0Mx
         nzZMxDn4hzu57KLbphCtS9Ebfb9ZbnWf5Bcv+abfgX2Nt/gTSgZjw9Y1rAI7sxLTKCsZ
         d9VXVlpUH5M1FL24d41LXtxfXZtbp/wKc3Fyw09ALYgSMhypcMr28jl2vieCMCANDgmc
         Tk0w==
Received: by 10.68.132.201 with SMTP id ow9mr25879759pbb.160.1337249542217;
        Thu, 17 May 2012 03:12:22 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id vc4sm8661658pbc.8.2012.05.17.03.12.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:12:21 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 8/8] MIPS: sync-r4k: remove redundant irq operation
Date:   Thu, 17 May 2012 18:10:10 +0800
Message-Id: <1337249410-7162-9-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

Since we have delayed irq enable to ->smp_finish()

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/mips/kernel/sync-r4k.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 99f913c..842d55e 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -111,7 +111,6 @@ void __cpuinit synchronise_count_master(void)
 void __cpuinit synchronise_count_slave(void)
 {
 	int i;
-	unsigned long flags;
 	unsigned int initcount;
 	int ncpus;
 
@@ -123,8 +122,6 @@ void __cpuinit synchronise_count_slave(void)
 	return;
 #endif
 
-	local_irq_save(flags);
-
 	/*
 	 * Not every cpu is online at the time this gets called,
 	 * so we first wait for the master to say everyone is ready
@@ -154,7 +151,5 @@ void __cpuinit synchronise_count_slave(void)
 	}
 	/* Arrange for an interrupt in a short while */
 	write_c0_compare(read_c0_count() + COUNTON);
-
-	local_irq_restore(flags);
 }
 #undef NR_LOOPS
-- 
1.7.1
