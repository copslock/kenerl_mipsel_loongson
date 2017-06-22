Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 12:24:58 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990686AbdFVKYuakaFq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 12:24:50 +0200
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F2822B4B;
        Thu, 22 Jun 2017 10:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F2822B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date:   Thu, 22 Jun 2017 19:24:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Meyer <thomas@m3y3r.de>, Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kernel/extable.c: mark core_kernel_text notrace
Message-Id: <20170622192445.c53a738717cb031c55680ce9@kernel.org>
In-Reply-To: <1498028607-6765-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1498028607-6765-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mhiramat@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhiramat@kernel.org
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

On Wed, 21 Jun 2017 09:03:26 +0200
Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:

> core_kernel_text is used by MIPS in its function graph trace processing,
> so having this method traced leads to an infinite set of recursive calls
> such as:
> 
> [    2.972075] Call Trace:
> [    2.972111]
> [    2.976731] [<80506584>] ftrace_return_to_handler+0x50/0x128
> [    2.983379] [<8045478c>] core_kernel_text+0x10/0x1b8
> [    2.989146] [<804119b8>] prepare_ftrace_return+0x6c/0x114
> [    2.995402] [<80411b2c>] ftrace_graph_caller+0x20/0x44
> [    3.001362] [<80411b60>] return_to_handler+0x10/0x30
> [    3.007159] [<80411b50>] return_to_handler+0x0/0x30
> [    3.012827] [<80411b50>] return_to_handler+0x0/0x30
> [    3.018621] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
> [    3.024602] [<8045478c>] core_kernel_text+0x10/0x1b8
> [    3.030377] [<8045478c>] core_kernel_text+0x10/0x1b8
> [    3.036140] [<8045478c>] core_kernel_text+0x10/0x1b8
> [    3.041915] [<804e589c>] ftrace_ops_no_ops+0x114/0x1bc
> [    3.047923] [<8045478c>] core_kernel_text+0x10/0x1b8
> [    3.053682] [<804119b8>] prepare_ftrace_return+0x6c/0x114
> [    3.059938] [<80411b2c>] ftrace_graph_caller+0x20/0x44
> (...)
> 
> Mark the function notrace to avoid it being traced.
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

Looks correct to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/extable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/extable.c b/kernel/extable.c
> index 2676d7f..4efaf26 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -70,7 +70,7 @@ static inline int init_kernel_text(unsigned long addr)
>  	return 0;
>  }
>  
> -int core_kernel_text(unsigned long addr)
> +int notrace core_kernel_text(unsigned long addr)
>  {
>  	if (addr >= (unsigned long)_stext &&
>  	    addr < (unsigned long)_etext)
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
