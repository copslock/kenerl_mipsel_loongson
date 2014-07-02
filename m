Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 16:32:33 +0200 (CEST)
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:55745 "EHLO
        cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6861101AbaGBOc3en0B9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2014 16:32:29 +0200
Received: from [67.246.153.56] ([67.246.153.56:52598] helo=gandalf.local.home)
        by cdptpa-oedge03 (envelope-from <rostedt@goodmis.org>)
        (ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
        id 4B/C0-02848-5F714B35; Wed, 02 Jul 2014 14:32:22 +0000
Date:   Wed, 2 Jul 2014 10:32:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <notifications@github.com>
Subject: Re: [RFA][PATCH 21/27] MIPS: ftrace: Remove check of obsolete
 variable function_trace_stop
Message-ID: <20140702103221.52fe1869@gandalf.local.home>
In-Reply-To: <20140626165852.665644919@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
        <20140626165852.665644919@goodmis.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40987
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


Adding linux-mips@linux-mips.org.

-- Steve

On Thu, 26 Jun 2014 12:52:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> Nothing sets function_trace_stop to disable function tracing anymore.
> Remove the check for it in the arch code.
> 
> [ Please test this on your arch ]
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/mips/Kconfig         | 1 -
>  arch/mips/kernel/mcount.S | 7 -------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 7a469acee33c..9ca52987fcd5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -15,7 +15,6 @@ config MIPS
>  	select HAVE_BPF_JIT if !CPU_MICROMIPS
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_C_RECORDMCOUNT
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index 539b6294b613..00940d1d5c4f 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -74,10 +74,6 @@ _mcount:
>  #endif
>  
>  	/* When tracing is activated, it calls ftrace_caller+8 (aka here) */
> -	lw	t1, function_trace_stop
> -	bnez	t1, ftrace_stub
> -	 nop
> -
>  	MCOUNT_SAVE_REGS
>  #ifdef KBUILD_MCOUNT_RA_ADDRESS
>  	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
> @@ -105,9 +101,6 @@ ftrace_stub:
>  #else	/* ! CONFIG_DYNAMIC_FTRACE */
>  
>  NESTED(_mcount, PT_SIZE, ra)
> -	lw	t1, function_trace_stop
> -	bnez	t1, ftrace_stub
> -	 nop
>  	PTR_LA	t1, ftrace_stub
>  	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
>  	bne	t1, t2, static_trace
