Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:32:11 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52567 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1AST3M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:29:12 +0100
Received: by mail-pw0-f49.google.com with SMTP id 8so239269pwj.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=g32QTUwRU4bQ2W/HIW9iYw37APdWvdw9ompzM3SLn9Q=;
        b=YfzJERFYvc2xkW0kPflKCVRySnqrDBFrwjmkFOBop0LaNe8GcAemVB9IfE3OjJw8f/
         bzMukfD+vZTSjIS27vdHnVQaA+BMoxH0KJs3WuP5/tDQ1DsRlM96576YAtKiACxvAjOU
         Uak4ewHeg8su+hJWZb31yVUb7JrGDqKt4Vsgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=niTDMbM5XVymvBoiZ33GoKXtd3x3BGt4AS2U42iJnqtfcouAs6di7Tn3gln94Ff6B3
         MDyIKHnWVM1MjBZjYN2vLXlk/iGiGaJoi7lpPWwn0UvPiP/HACX0x1HH3DcD2ocZYXEn
         8ixuEfDDQLHPafvKEMv578PjZ9pHOTd2yNfzc=
Received: by 10.142.43.12 with SMTP id q12mr1137345wfq.34.1295465350524;
        Wed, 19 Jan 2011 11:29:10 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.29.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:29:09 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 5/5] tracing, MIPS: Fix set_graph_function of function graph tracer
Date:   Thu, 20 Jan 2011 03:28:32 +0800
Message-Id: <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

trace.func should be set to the recorded ip of the mcount calling site
in the __mcount_loc section to filter the function entries configured
through the tracing/set_graph_function interface, but before, this is
set to the self_ra(the return address of mcount), which has made
set_graph_function not work as expects.

This fixes it via calculating the right recorded ip in the __mcount_loc
section and assign it to trace.func.

Reported-by: Zhiping Zhong <xzhong86@163.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index bc91e4a..62775d7 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -257,7 +257,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
-	int faulted;
+	int faulted, insns;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 		return;
 	}
 
-	trace.func = self_ra;
+	/*
+	 * Get the recorded ip of the current mcount calling site in the
+	 * __mcount_loc section, which will be used to filter the function
+	 * entries configured through the tracing/set_graph_function interface.
+	 */
+
+	insns = (in_kernel_space(self_ra)) ? 2 : (MCOUNT_OFFSET_INSNS + 1);
+	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
-- 
1.7.1
