Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:10:19 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:46776 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491848Ab0ENLJK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:10 +0200
Received: by pxi1 with SMTP id 1so1300658pxi.36
        for <multiple recipients>; Fri, 14 May 2010 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=PwuS6KbKCUJqUpCTlLCwumX2NC+1vOXggMD35QuPH30=;
        b=HzTSCkrVOds48lI2FCvYRwnE6zvrLDiePKbV3gOjBfg3ou0rvXQo7bkqRYVwsx2NdK
         Bc2hjRqXAsIMTvdw0iT/TyM6BZqe8H4U5z91opt8o/IPrZvVN0VuAaHc4PH+eCuAGZ+4
         lwNBThzSiNBOU7fVtV5VegsFppYPj8PeBvc+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fKJ965bsIh+geCjCnROvimuUyfNES85hXRi9jF6sKH3RVhe2YXtQTmU8Vj0Fs8YRJA
         EQj6zETZxTr/U9xdcWTh0sj234cp5zu1DQYyH0OHBByX3CDopUlVZvyok68fnz04PShj
         6ZGPTemYV+2O88JsN0OwGEIkFPd0ohfmB9Ex0=
Received: by 10.115.85.35 with SMTP id n35mr988155wal.227.1273835343592;
        Fri, 14 May 2010 04:09:03 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:03 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/9] tracing: MIPS: mcount.S: cleanup the arguments of prepare_ftrace_return
Date:   Fri, 14 May 2010 19:08:27 +0800
Message-Id: <fe37f031072a6cfe2c41f2909d6124e5df6de90e.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26712
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
index e256bf9..d4a00d2 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -132,28 +132,34 @@ ftrace_stub:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 NESTED(ftrace_graph_caller, PT_SIZE, ra)
-#ifdef CONFIG_DYNAMIC_FTRACE
-	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
-#ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
-#endif
-#else
+#ifndef CONFIG_DYNAMIC_FTRACE
 	MCOUNT_SAVE_REGS
-	move	a1, ra		/* arg2: next ip, selfaddr */
 #endif
 
+	/* arg1: Get the location of the parent's return address */
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
+#ifdef CONFIG_DYNAMIC_FTRACE
+	PTR_L	a0, PT_R12(sp)
+#else
+	move	a0, t0
+#endif
+	bnez	a0, 1f		/* non-leaf func: stored in t0 */
 	 nop
-	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
-1:	move	a0, t0		/* arg1: the location of the return address */
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
