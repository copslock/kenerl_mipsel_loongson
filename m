Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2018 01:34:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993845AbeKVAdfBI9Iq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2018 01:33:35 +0100
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3891C21527;
        Thu, 22 Nov 2018 00:33:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPcw0-0004SE-AD; Wed, 21 Nov 2018 19:33:32 -0500
Message-Id: <20181122003332.209589047@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 19:28:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        stable@kernel.org
Subject: [for-next][PATCH 06/18] MIPS: function_graph: Simplify with function_graph_entry()
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <SRS0=awNW=OB=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have MIPS use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/mips/kernel/ftrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdbc3657..b122cbb4aad1 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -322,7 +322,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 			   unsigned long fp)
 {
 	unsigned long old_parent_ra;
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
 	int faulted, insns;
@@ -369,12 +368,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	if (unlikely(faulted))
 		goto out;
 
-	if (ftrace_push_return_trace(old_parent_ra, self_ra, &trace.depth, fp,
-				     NULL) == -EBUSY) {
-		*parent_ra_addr = old_parent_ra;
-		return;
-	}
-
 	/*
 	 * Get the recorded ip of the current mcount calling site in the
 	 * __mcount_loc section, which will be used to filter the function
@@ -382,13 +375,10 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	 */
 
 	insns = core_kernel_text(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
-	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
+	self_ra -= (MCOUNT_INSN_SIZE * insns);
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
+	if (function_graph_enter(old_parent_ra, self_ra, fp, NULL))
 		*parent_ra_addr = old_parent_ra;
-	}
 	return;
 out:
 	ftrace_graph_stop();
-- 
2.19.1
