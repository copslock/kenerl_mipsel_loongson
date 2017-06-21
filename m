Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 09:03:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64524 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990506AbdFUHDhqH1KY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 09:03:37 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D7340C501165F;
        Wed, 21 Jun 2017 08:03:29 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 21 Jun 2017 08:03:31 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Meyer <thomas@m3y3r.de>, Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] kernel/extable.c: mark core_kernel_text notrace
Date:   Wed, 21 Jun 2017 09:03:26 +0200
Message-ID: <1498028607-6765-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

core_kernel_text is used by MIPS in its function graph trace processing,
so having this method traced leads to an infinite set of recursive calls
such as:

[    2.972075] Call Trace:
[    2.972111]
[    2.976731] [<80506584>] ftrace_return_to_handler+0x50/0x128
[    2.983379] [<8045478c>] core_kernel_text+0x10/0x1b8
[    2.989146] [<804119b8>] prepare_ftrace_return+0x6c/0x114
[    2.995402] [<80411b2c>] ftrace_graph_caller+0x20/0x44
[    3.001362] [<80411b60>] return_to_handler+0x10/0x30
[    3.007159] [<80411b50>] return_to_handler+0x0/0x30
[    3.012827] [<80411b50>] return_to_handler+0x0/0x30
[    3.018621] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
[    3.024602] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.030377] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.036140] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.041915] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
[    3.047923] [<8045478c>] core_kernel_text+0x10/0x1b8
[    3.053682] [<804119b8>] prepare_ftrace_return+0x6c/0x114
[    3.059938] [<80411b2c>] ftrace_graph_caller+0x20/0x44
(...)

Mark the function notrace to avoid it being traced.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 kernel/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index 2676d7f..4efaf26 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -70,7 +70,7 @@ static inline int init_kernel_text(unsigned long addr)
 	return 0;
 }
 
-int core_kernel_text(unsigned long addr)
+int notrace core_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext &&
 	    addr < (unsigned long)_etext)
-- 
2.7.4
