Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:27:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64901 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993905AbdEWM0xaqljF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:26:53 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 01908254E6806;
        Tue, 23 May 2017 13:26:43 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 23 May
 2017 13:26:45 +0100
Subject: Re: [PATCH] MIPS: ftrace: fix init functions tracing
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1495537003-1013-1-git-send-email-marcin.nowakowski@imgtec.com>
CC:     <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <cbbb5d65-48c3-ad44-a913-ce9ccdea5da9@imgtec.com>
Date:   Tue, 23 May 2017 13:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1495537003-1013-1-git-send-email-marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Marcin,


On 23/05/17 11:56, Marcin Nowakowski wrote:
> Since introduction of tracing for init functions the in_kernel_space()
> check is no longer correct, as it ignores the init sections. As a
> result, when probes are inserted (and disabled) in the init functions,
> a branch instruction is inserted instead of a nop, which is likely to
> result in random crashes during boot.
>
> Remove the MIPS-specific in_kernel_space() method and replace it with a
> generic core_kernel_text() that also checks for init sections during
> system boot stage.
>
> Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

Looks good to me & fixes the panics seen in v4.12-rc* when CONFIG_FTRACE 
is enabled on MIPS.

Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>

> ---
>   arch/mips/kernel/ftrace.c | 24 +++++-------------------
>   1 file changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 30a3b75..9d9b8fba 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -38,20 +38,6 @@ void arch_ftrace_update_code(int command)
>   
>   #endif
>   
> -/*
> - * Check if the address is in kernel space
> - *
> - * Clone core_kernel_text() from kernel/extable.c, but doesn't call
> - * init_kernel_text() for Ftrace doesn't trace functions in init sections.
> - */
> -static inline int in_kernel_space(unsigned long ip)
> -{
> -	if (ip >= (unsigned long)_stext &&
> -	    ip <= (unsigned long)_etext)
> -		return 1;
> -	return 0;
> -}
> -
>   #ifdef CONFIG_DYNAMIC_FTRACE
>   
>   #define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
> @@ -198,7 +184,7 @@ int ftrace_make_nop(struct module *mod,
>   	 * If ip is in kernel space, no long call, otherwise, long call is
>   	 * needed.
>   	 */
> -	new = in_kernel_space(ip) ? INSN_NOP : INSN_B_1F;
> +	new = core_kernel_text(ip) ? INSN_NOP : INSN_B_1F;
>   #ifdef CONFIG_64BIT
>   	return ftrace_modify_code(ip, new);
>   #else
> @@ -218,12 +204,12 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>   	unsigned int new;
>   	unsigned long ip = rec->ip;
>   
> -	new = in_kernel_space(ip) ? insn_jal_ftrace_caller : insn_la_mcount[0];
> +	new = core_kernel_text(ip) ? insn_jal_ftrace_caller : insn_la_mcount[0];
>   
>   #ifdef CONFIG_64BIT
>   	return ftrace_modify_code(ip, new);
>   #else
> -	return ftrace_modify_code_2r(ip, new, in_kernel_space(ip) ?
> +	return ftrace_modify_code_2r(ip, new, core_kernel_text(ip) ?
>   						INSN_NOP : insn_la_mcount[1]);
>   #endif
>   }
> @@ -289,7 +275,7 @@ unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
>   	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
>   	 * kernel, move after the instruction "move ra, at"(offset is 16)
>   	 */
> -	ip = self_ra - (in_kernel_space(self_ra) ? 16 : 24);
> +	ip = self_ra - (core_kernel_text(self_ra) ? 16 : 24);
>   
>   	/*
>   	 * search the text until finding the non-store instruction or "s{d,w}
> @@ -394,7 +380,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
>   	 * entries configured through the tracing/set_graph_function interface.
>   	 */
>   
> -	insns = in_kernel_space(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
> +	insns = core_kernel_text(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
>   	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
>   
>   	/* Only trace if the calling function expects to */
