Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 18:15:17 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdD0QPJCHRti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Apr 2017 18:15:09 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 878B420160;
        Thu, 27 Apr 2017 16:15:06 +0000 (UTC)
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F042011B;
        Thu, 27 Apr 2017 16:15:01 +0000 (UTC)
Date:   Thu, 27 Apr 2017 12:14:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in
 NMI
Message-ID: <20170427121458.2be577cc@gandalf.local.home>
In-Reply-To: <20170420131154.GL3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
        <1461239325-22779-2-git-send-email-pmladek@suse.com>
        <20170419131341.76bc7634@gandalf.local.home>
        <20170420033112.GB542@jagdpanzerIV.localdomain>
        <20170420131154.GL3452@pathway.suse.cz>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <SRS0=kAy7=4D=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57802
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

On Thu, 20 Apr 2017 15:11:54 +0200
Petr Mladek <pmladek@suse.com> wrote:



> 
> >From c530d9dee91c74db5e6a198479e2e63b24cb84a2 Mon Sep 17 00:00:00 2001  
> From: Petr Mladek <pmladek@suse.com>
> Date: Thu, 20 Apr 2017 10:52:31 +0200
> Subject: [PATCH] printk: Use the main logbuf in NMI when logbuf_lock is
>  available

I tried this patch. It's better because I get the end of the trace, but
I do lose the beginning of it:

** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path

The way I tested it was by adding this:

Index: linux-trace.git/kernel/trace/trace_functions.c
===================================================================
--- linux-trace.git.orig/kernel/trace/trace_functions.c
+++ linux-trace.git/kernel/trace/trace_functions.c
@@ -469,8 +469,11 @@ ftrace_cpudump_probe(unsigned long ip, u
 		     struct trace_array *tr, struct ftrace_probe_ops *ops,
 		     void *data)
 {
-	if (update_count(ops, ip, data))
-		ftrace_dump(DUMP_ORIG);
+	char *killer = NULL;
+
+	panic_on_oops = 1;	/* force panic */
+	wmb();
+	*killer = 1;
 }
 
 static int


Then doing the following:

# echo 1 > /proc/sys/kernel/ftrace_dump_on_oops 
# trace-cmd start -p function
# echo nmi_handle:cpudump > /debug/tracing/set_ftrace_filter
# perf record -c 100 -a sleep 1

And that triggers the crash.

-- Steve
