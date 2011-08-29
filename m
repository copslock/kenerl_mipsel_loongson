Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 01:20:44 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:53018 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491753Ab1H2XUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 01:20:38 +0200
Received: by fxd20 with SMTP id 20so6177666fxd.36
        for <multiple recipients>; Mon, 29 Aug 2011 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=KcQJ6rUkwow3RDjg8/tXZ7dEwZxNySJTv1wEdC+muVQ=;
        b=q4MuUZCK8HrRpkmgdbC4m5rlY/uPjx0AXrPz7onEjmftmmWR4WEBjVKiY66sF1EKHn
         ezZOJehpgo3S2r3kDLLlddmj7lvIAzk7Jg3YNv12HH2MEp7HwZ8FKef1QFhRvCOTqoca
         OpF+hPH/P33D498RDjMnt9Viw9VyyZb1V5woc=
Received: by 10.223.7.7 with SMTP id b7mr7895692fab.9.1314660032347;
        Mon, 29 Aug 2011 16:20:32 -0700 (PDT)
Received: from localhost (h59ec324b.selukar.dyn.perspektivbredband.net [89.236.50.75])
        by mx.google.com with ESMTPS id t1sm3307970faa.8.2011.08.29.16.20.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 16:20:31 -0700 (PDT)
Date:   Tue, 30 Aug 2011 01:20:29 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110829232029.GA15763@zapo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21919

Hi,

Commit 362e696428590f7d0a5d0971a2d04b0372a761b8
reorders a bunch of insns to improve the flow of the pipeline but
for MT_SMTC kernels, AFAICT, the saving of CP0_STATUS seems wrong.

Am I missing something?

If not here is a patch, tested with qemu.

Cheers

commit 1a72dd0ed0a238007d3d67c1e3a634d477527ce2
Author: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Date:   Tue Aug 30 01:07:15 2011 +0200

    MIPS: SMTC: Correct saving of CP0_STATUS
    
    Signed-off-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index b4ba244..1b8d9a0 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -189,6 +189,9 @@
 		LONG_S	$0, PT_R0(sp)
 		mfc0	v1, CP0_STATUS
 		LONG_S	$2, PT_R2(sp)
+		LONG_S	$4, PT_R4(sp)
+		LONG_S	$5, PT_R5(sp)
+		LONG_S	v1, PT_STATUS(sp)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -199,9 +202,6 @@
 		.set	mips0
 		LONG_S	v1, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
-		LONG_S	$4, PT_R4(sp)
-		LONG_S	$5, PT_R5(sp)
-		LONG_S	v1, PT_STATUS(sp)
 		mfc0	v1, CP0_CAUSE
 		LONG_S	$6, PT_R6(sp)
 		LONG_S	$7, PT_R7(sp)
