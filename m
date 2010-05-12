Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:25:29 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:34407 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491968Ab0ELNYU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:20 +0200
Received: by pxi1 with SMTP id 1so2779303pxi.36
        for <multiple recipients>; Wed, 12 May 2010 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=fpwf52P9F1kOQXwwErJavg7NkLVsMTo6Keu9v66oxM4=;
        b=i5xe6FFQESgsCvh5YXlbLyjuzV0QWz0+ulJqDsemRnv1j94aKJE6Vg/4zgjXqgzMef
         xqMOBWxbWHrS//S0/QYtkvAr0ziJkYdMFXUsRQMwVgIDUtDr25CvFJhsyoan6yKAcirp
         jT9nD4dH/UjdG0aPEoXlpM/eePQWiStp5iSX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YbEEENzf8IKEBHlAg/krLADT25zVRb4ZFTxy4+AybKOYFJZVXVMGqIMO0wtbVvEgM1
         pYB8wWfJSwyJSmHG1S+2ncihkofIA6p/21yFGuwopPHinG9TsQ/BFlMmPjrkJBJsByVy
         PEua+QfRcrDZ9oIa3/bkG3hYJQDzSGysXX90Y=
Received: by 10.114.189.18 with SMTP id m18mr5843754waf.28.1273670649128;
        Wed, 12 May 2010 06:24:09 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:08 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/9] tracing: MIPS: mcount.S: cleanup the arguments of prepare_ftrace_return
Date:   Wed, 12 May 2010 21:23:11 +0800
Message-Id: <165223875472dd5871309a7a794e286bdb2aba8f.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The old arguments handling for prepare_ftrace_return is awlful, this
patch cleans it up.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 92d1540..991cbdf 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -132,28 +132,34 @@ ftrace_stub:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 NESTED(ftrace_graph_caller, PT_SIZE, ra)
-#ifdef CONFIG_DYNAMIC_FTRACE
-	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
-#ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_L	$12, PT_R12(sp)	/* load the original $12 from the stack */
-#endif
-#else
+#ifndef CONFIG_DYNAMIC_FTRACE
 	MCOUNT_SAVE_REGS
-	move	a1, ra		/* arg2: next ip, selfaddr */
 #endif
 
+	/* arg1: Get the location of the parent's return address */
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	bnez	$12, 1f		/* non-leaf func: $12 saved the location of the return address */
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a0, PT_R12(sp)
+#else
+	move	a0, $12
+#endif
+	bnez	a0, 1f		/* non-leaf func: stored in $12 */
 	 nop
-	PTR_LA	$12, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
-1:	move	a0, $12		/* arg1: the location of the return address */
+#endif
+	PTR_LA	a0, PT_R1(sp)	/* leaf func: the location in current stack */
+1:
+
+	/* arg2: Get self return address */
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a1, PT_R31(sp)
 #else
-	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
+	move	a1, ra
 #endif
-	jal	prepare_ftrace_return
+
+	/* arg3: Get frame pointer of current stack */
 #ifdef CONFIG_FRAME_POINTER
-	 move	a2, fp		/* arg3: frame pointer */
-#else
+	 move	a2, fp
+#else /* ! CONFIG_FRAME_POINTER */
 #ifdef CONFIG_64BIT
 	 PTR_LA	a2, PT_SIZE(sp)
 #else
@@ -161,6 +167,8 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #endif
 #endif
 
+	jal	prepare_ftrace_return
+	 nop
 	MCOUNT_RESTORE_REGS
 	RETURN_BACK
 	END(ftrace_graph_caller)
-- 
1.7.0.4
