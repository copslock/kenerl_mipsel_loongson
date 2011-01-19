Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:31:18 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52567 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491155Ab1AST3D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:29:03 +0100
Received: by mail-pw0-f49.google.com with SMTP id 8so239269pwj.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=I7u8KvFXSu4HHore0p8QXtdx/0A4s5Zi24RIFV79yHI=;
        b=TA4HfVU5cTK464K85Oyg640oE8tfqba06kiQErSD2XVsbWCbMnrJKLL5D/CiVhKalu
         p2oED6j6OB9ydSYV4ODNgVGHOUTOXpvm1MKuzRpE85EWZ+VvS5J4jBKnKM3/kz/0zEuS
         2PvsJRAebb+ThD2x2ni/Hb2As2J7WBG1y3W6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tlkD6IvnCTFX3YqY+YLF6MhoDtyJFpXDc9CDTiha6qmoPWaBwZVETI1/zxPTBnpHVc
         Ouc9jdtfhAt9ZnmfbLv8cCZgWCPs2LgwIdWBfIrugU9vlvTMmDtqESIaSxJwJm0EDtB3
         1CrR/Tgdt19nD8T2ZQIJ1XKXheveYatId+1oY=
Received: by 10.142.201.7 with SMTP id y7mr1124547wff.223.1295465342746;
        Wed, 19 Jan 2011 11:29:02 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:29:01 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 3/5] tracing, MIPS: Clean up prepare_ftrace_return()
Date:   Thu, 20 Jan 2011 03:28:30 +0800
Message-Id: <e3b7d765c00d4c183eda8e5b75dcf2d4de394caf.1295464855.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The old prepare_ftrace_return() for MIPS is confused and have introduced
some problem. This patch cleans up the names of the arguments, variables
and related functions.

For MIPS, the 2nd argument of prepare_ftrace_return() is not really the
'selfpc' described in ftrace-design.txt but instead it is the self
return address. This did break the compatibility of the generic
interface but really reduced one unneeded calculation for to get the
current function name, the parent return address and the self return
address are enough, no need to tranform the self return address to the
self address.

But set_graph_function of function graph tracer is an exception, it does
need the 2nd argument of prepare_ftrace_return() as 'selfpc', for it
will use 'selfpc' to match user's configuration of function graph
entries, but in reality, it doesn't need the 'selfpc' but the recorded
ip address of the mcount calling site in the __mcount_loc section. So,
the 2nd argument of prepare_ftrace_return() is not important, the real
requirement is the right recorded ip address should be calculated and
assign to trace.func, this will be fixed in the next patches.

Reported-by: Zhiping Zhong <xzhong86@163.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   52 +++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 5970286..40ef34c 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -190,21 +190,19 @@ int ftrace_disable_ftrace_graph_caller(void)
 #define S_R_SP	(0xafb0 << 16)  /* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
-unsigned long ftrace_get_parent_addr(unsigned long self_addr,
-				     unsigned long parent,
-				     unsigned long parent_addr,
-				     unsigned long fp)
+unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
+		old_parent_ra, unsigned long parent_ra_addr, unsigned long fp)
 {
-	unsigned long sp, ip, ra;
+	unsigned long sp, ip, tmp;
 	unsigned int code;
 	int faulted;
 
 	/*
-	 * For module, move the ip from calling site of mcount after the
+	 * For module, move the ip from the return address after the
 	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
 	 * kernel, move after the instruction "move ra, at"(offset is 16)
 	 */
-	ip = self_addr - (in_kernel_space(self_addr) ? 16 : 24);
+	ip = self_ra - (in_kernel_space(self_ra) ? 16 : 24);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
@@ -222,7 +220,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 		 * store the ra on the stack
 		 */
 		if ((code & S_R_SP) != S_R_SP)
-			return parent_addr;
+			return parent_ra_addr;
 
 		/* Move to the next instruction */
 		ip -= 4;
@@ -230,12 +228,12 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 
 	sp = fp + (code & OFFSET_MASK);
 
-	/* ra = *(unsigned long *)sp; */
-	safe_load_stack(ra, sp, faulted);
+	/* tmp = *(unsigned long *)sp; */
+	safe_load_stack(tmp, sp, faulted);
 	if (unlikely(faulted))
 		return 0;
 
-	if (ra == parent)
+	if (tmp == old_parent_ra)
 		return sp;
 	return 0;
 }
@@ -246,10 +244,10 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
  */
-void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 			   unsigned long fp)
 {
-	unsigned long old;
+	unsigned long old_parent_ra;
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
@@ -259,8 +257,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		return;
 
 	/*
-	 * "parent" is the stack address saved the return address of the caller
-	 * of _mcount.
+	 * "parent_ra_addr" is the stack address saved the return address of
+	 * the caller of _mcount.
 	 *
 	 * if the gcc < 4.5, a leaf function does not save the return address
 	 * in the stack address, so, we "emulate" one in _mcount's stack space,
@@ -275,37 +273,37 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 * do it in ftrace_graph_caller of mcount.S.
 	 */
 
-	/* old = *parent; */
-	safe_load_stack(old, parent, faulted);
+	/* old_parent_ra = *parent_ra_addr; */
+	safe_load_stack(old_parent_ra, parent_ra_addr, faulted);
 	if (unlikely(faulted))
 		goto out;
 #ifndef KBUILD_MCOUNT_RA_ADDRESS
-	parent = (unsigned long *)ftrace_get_parent_addr(self_addr, old,
-			(unsigned long)parent, fp);
+	parent_ra_addr = (unsigned long *)ftrace_get_parent_ra_addr(self_ra,
+			old_parent_ra, (unsigned long)parent_ra_addr, fp);
 	/*
 	 * If fails when getting the stack address of the non-leaf function's
 	 * ra, stop function graph tracer and return
 	 */
-	if (parent == 0)
+	if (parent_ra_addr == 0)
 		goto out;
 #endif
-	/* *parent = return_hooker; */
-	safe_store_stack(return_hooker, parent, faulted);
+	/* *parent_ra_addr = return_hooker; */
+	safe_store_stack(return_hooker, parent_ra_addr, faulted);
 	if (unlikely(faulted))
 		goto out;
 
-	if (ftrace_push_return_trace(old, self_addr, &trace.depth, fp) ==
-	    -EBUSY) {
-		*parent = old;
+	if (ftrace_push_return_trace(old_parent_ra, self_ra, &trace.depth, fp)
+	    == -EBUSY) {
+		*parent_ra_addr = old_parent_ra;
 		return;
 	}
 
-	trace.func = self_addr;
+	trace.func = self_ra;
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
 		current->curr_ret_stack--;
-		*parent = old;
+		*parent_ra_addr = old_parent_ra;
 	}
 	return;
 out:
-- 
1.7.1
