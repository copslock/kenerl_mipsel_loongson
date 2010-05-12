Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:27:16 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60015 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492000Ab0ELNYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:39 +0200
Received: by mail-pz0-f194.google.com with SMTP id 32so732pzk.21
        for <multiple recipients>; Wed, 12 May 2010 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=eIMj8NSHeiLDc6/Y4Rg2vSGjT1D/EozanUFoKIS35Dc=;
        b=VAvz0+jIpmP8pPSqJNxPbG6OwHsMnKetdZyWj1a0/YXBBe+v680BD/krTDJaFKAZtw
         n6FBWnIumYK73lTHciP9H5hW5FognPmgt1Q7TgfUChgchWdp3yI2vwhsin3avKYEAdda
         87AtzuFl5yboK7yWucacA9WLNndkIqmugORDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WDAQIQmT0zKH6VwnRNSJqx47B1U7GbNWRJsL2ktSlAcCiZ1apd3QyxM8Pi9LhN0BTa
         LeAQixcv61MKGI8Twddnud5HVANzz0OQ7glO9yKzbovo/zcnmAg0S2lY8rI+Fhnc2+Ut
         ufE0vAknT4Nrv3pq2JZn8DEqCLwHuIij+1Es8=
Received: by 10.115.98.19 with SMTP id a19mr5843261wam.82.1273670678396;
        Wed, 12 May 2010 06:24:38 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:38 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 8/9] tracing: MIPS: cleanup of function graph tracer
Date:   Wed, 12 May 2010 21:23:16 +0800
Message-Id: <68af048a40e348233a16b2ae94abfc1f7557102a.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch cleans up the comments and ftrace_get_parent_addr() of
function graph tracer.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   48 ++++++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index c4042ca..628e90b 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -146,7 +146,7 @@ int __init ftrace_dyn_arch_init(void *data)
 
 	return 0;
 }
-#endif				/* CONFIG_DYNAMIC_FTRACE */
+#endif	/* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -166,9 +166,10 @@ int ftrace_disable_ftrace_graph_caller(void)
 	return ftrace_modify_code(FTRACE_GRAPH_CALL_IP, INSN_NOP);
 }
 
-#endif				/* !CONFIG_DYNAMIC_FTRACE */
+#endif	/* CONFIG_DYNAMIC_FTRACE */
 
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
+
 #define S_RA_SP	(0xafbf << 16)	/* s{d,w} ra, offset(sp) */
 #define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
@@ -182,17 +183,17 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	unsigned int code;
 	int faulted;
 
-	/* in module or kernel? */
-	if (self_addr & 0x40000000) {
-		/* module: move to the instruction "lui v1, HI_16BIT_OF_MCOUNT" */
-		ip = self_addr - 20;
-	} else {
-		/* kernel: move to the instruction "move ra, at" */
-		ip = self_addr - 12;
-	}
+	/*
+	 * For module, move the ip from calling site of mcount to the
+	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
+	 * kernel, move to the instruction "move ra, at"(offset is 12)
+	 */
+	ip = self_addr - ((self_addr & 0x40000000) ? 20 : 12);
 
-	/* search the text until finding the non-store instruction or "s{d,w}
-	 * ra, offset(sp)" instruction */
+	/*
+	 * search the text until finding the non-store instruction or "s{d,w}
+	 * ra, offset(sp)" instruction
+	 */
 	do {
 		ip -= 4;
 
@@ -201,10 +202,11 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 
 		if (unlikely(faulted))
 			return 0;
-
-		/* If we hit the non-store instruction before finding where the
+		/*
+		 * If we hit the non-store instruction before finding where the
 		 * ra is stored, then this is a leaf function and it does not
-		 * store the ra on the stack. */
+		 * store the ra on the stack
+		 */
 		if ((code & S_R_SP) != S_R_SP)
 			return parent_addr;
 
@@ -222,7 +224,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	return 0;
 }
 
-#endif
+#endif	/* !KBUILD_MCOUNT_RA_ADDRESS */
 
 /*
  * Hook the return address and push it in the stack of return addrs
@@ -240,7 +242,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	/* "parent" is the stack address saved the return address of the caller
+	/*
+	 * "parent" is the stack address saved the return address of the caller
 	 * of _mcount.
 	 *
 	 * if the gcc < 4.5, a leaf function does not save the return address
@@ -262,10 +265,11 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		goto out;
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
 	parent = (unsigned long *)ftrace_get_parent_addr(self_addr, old,
-							 (unsigned long)parent,
-							 fp);
-	/* If fails when getting the stack address of the non-leaf function's
-	 * ra, stop function graph tracer and return */
+			(unsigned long)parent, fp);
+	/*
+	 * If fails when getting the stack address of the non-leaf function's
+	 * ra, stop function graph tracer and return
+	 */
 	if (parent == 0)
 		goto out;
 #endif
@@ -292,4 +296,4 @@ out:
 	ftrace_graph_stop();
 	WARN_ON(1);
 }
-#endif				/* CONFIG_FUNCTION_GRAPH_TRACER */
+#endif	/* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
1.7.0.4
