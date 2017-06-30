Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 17:16:43 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993893AbdF3PQfzs1kX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jun 2017 17:16:35 +0200
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C134B22B60;
        Fri, 30 Jun 2017 15:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134B22B60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date:   Fri, 30 Jun 2017 11:16:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: ftrace: fix init functions tracing
Message-ID: <20170630111632.2dbf4f69@gandalf.local.home>
In-Reply-To: <19a41533-d203-f87b-603a-fcb311c2060f@imgtec.com>
References: <1495537003-1013-1-git-send-email-marcin.nowakowski@imgtec.com>
        <20170523153240.72a8ecd5@vmware.local.home>
        <19a41533-d203-f87b-603a-fcb311c2060f@imgtec.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=aia5=6D=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58941
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

On Mon, 5 Jun 2017 13:16:18 +0200
Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:

> Hi Steven,
> 
> On 23.05.2017 21:32, Steven Rostedt wrote:
> > On Tue, 23 May 2017 12:56:43 +0200
> > Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> >   
> >> Since introduction of tracing for init functions the in_kernel_space()
> >> check is no longer correct, as it ignores the init sections. As a
> >> result, when probes are inserted (and disabled) in the init functions,
> >> a branch instruction is inserted instead of a nop, which is likely to
> >> result in random crashes during boot.
> >>
> >> Remove the MIPS-specific in_kernel_space() method and replace it with
> >> a generic core_kernel_text() that also checks for init sections during
> >> system boot stage.
> >>
> >> Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record
> >> init functions on boot up") Signed-off-by: Marcin Nowakowski
> >> <marcin.nowakowski@imgtec.com> ---
> >>   arch/mips/kernel/ftrace.c | 24 +++++-------------------
> >>   1 file changed, 5 insertions(+), 19 deletions(-)
> >>
> >>  
> > 
> > Thanks for doing this.  
> 
> There's one issue with this patch that I haven't noticed initially - 
> while this fixes the MIPS boot issue, it introduces a problem due to use 
> of core_kernel_text in the function graph trace path ... as the 
> core_kernel_text function is traced as well, we end up with a recursive 
> call to core_kernel_text from its function graph handler, something that 
> shows up in a backtrace as:
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
> (and many many more repetitions before we run out of stack)
> 
> Would a simple patch like:
> 
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -69,7 +69,7 @@ static inline int init_kernel_text(unsigned long addr)
>          return 0;
>   }
> 
> -int core_kernel_text(unsigned long addr)
> +int notrace core_kernel_text(unsigned long addr)
>   {
>          if (addr >= (unsigned long)_stext &&
>              addr < (unsigned long)_etext)
> 
> 
> be acceptable here to solve this problem? It needs to modify the generic 
> kernel code due to a dependency that is specific to MIPS only, so it 
> might not be the best solution, but an alternative is to add restore a 
> copy of that method in arch/mips - which doesn't seem very nice either.
> The core_kernel_text function is not something that is extremely 
> valuable to be traced IMO anyway, so it shouldn't be a big loss.
> 
> What's your opinion?
> If this change is OK I'll send out a patch
>

I somehow missed this email :-/

Anyway, I already replied to the patch that made the change.

-- Steve
