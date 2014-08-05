Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 18:41:19 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48291 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859954AbaHEQlNct4Jc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2014 18:41:13 +0200
Received: by mail-lb0-f173.google.com with SMTP id p9so948405lbv.18
        for <multiple recipients>; Tue, 05 Aug 2014 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u4/sgrWPIKU0htpbT/OwnRbA2YYyJZNiVEqSiAN9Z/g=;
        b=zsQG4iyJ+z9IC1AlCqsR1TPxyAe6kVpSK5LpTJNsI1AjWJrFcgOSOcz9jg6gX2K+zV
         jk3SYCxlf18hlVIjEAv2dyhtE/+H08GVb+aDYGwWqWvndQ6ghmE/8ZuxijOkN/GIKo16
         w1NwgKFhCJ0A5AMIWn8Bp/kh7jCez0+2WGiJjZW+zBayQWdBreku4pZMHlWVDPy1sFb4
         wD21UkIyzmb5SybWNR9/UPT1FgI4eJsQQq9OMSbP1v2tCq4rSULYnO14xwzedLJg+7TO
         TPT59ueohf1Dr0/kT33px4efQJgilq7Jcq+leK8EYMSUMZhUDv4mRUoaB6HthdSGQ7XD
         iXTg==
MIME-Version: 1.0
X-Received: by 10.112.167.67 with SMTP id zm3mr5225854lbb.27.1407256866453;
 Tue, 05 Aug 2014 09:41:06 -0700 (PDT)
Received: by 10.112.50.84 with HTTP; Tue, 5 Aug 2014 09:41:06 -0700 (PDT)
In-Reply-To: <20140724055502.301F710077A@puck.mtv.corp.google.com>
References: <20140724055502.301F710077A@puck.mtv.corp.google.com>
Date:   Tue, 5 Aug 2014 12:41:06 -0400
Message-ID: <CAOGqxeXY4x7gyhpsSwm6dohG8rJschsR4yyd2YXdeAarsLp1WQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Ftrace: Fix dynamic tracing of kernel modules
From:   Alan Cooper <alcooperx@gmail.com>
To:     Petri Gynther <pgynther@google.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Steven Rostedt <rostedt@goodmis.org>, cminyard@mvista.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <alcooperx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

Petri,

>However, when ftrace is later enabled for a call site, ftrace_make_call()
>does not currently restore the _mcount call correctly for module call sites

I just did some testing on a BMIPS5000 system with a 3.3 kernel and
module tracing worked correctly without these changes. I see that the call
site is being restored correctly by writing a single 0x3c038001 which is what
the compiler originally generated. What are the first 2 instructions of your
modules call site and what version kernel and toolchain are you using?

Al

On Thu, Jul 24, 2014 at 1:55 AM, Petri Gynther <pgynther@google.com> wrote:
> Dynamic tracing of kernel modules is broken on 32-bit MIPS. When modules
> are loaded, the kernel crashes when dynamic tracing is enabled with:
>  cd /sys/kernel/debug/tracing
>  echo > set_ftrace_filter
>  echo function > current_tracer
>
> 1) arch/mips/kernel/ftrace.c
> When the kernel boots, or when a module is initialized, ftrace_make_nop()
> modifies every _mcount call site to eliminate the ftrace overhead.
> However, when ftrace is later enabled for a call site, ftrace_make_call()
> does not currently restore the _mcount call correctly for module call sites.
> Added ftrace_modify_code_2r() and modified ftrace_make_call() to fix this.
>
> 2) arch/mips/kernel/mcount.S
> _mcount assembly routine is supposed to have the caller's _mcount call site
> address in register a0. However, a0 is currently not calculated correctly for
> module call sites. a0 should be (ra - 20) or (ra - 24), depending on whether
> the kernel was built with KBUILD_MCOUNT_RA_ADDRESS or not.
>
> This fix has been tested on Broadcom BMIPS5000 processor. Dynamic tracing
> now works for both built-in functions and module functions.
>
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  arch/mips/kernel/ftrace.c | 56 +++++++++++++++++++++++++++++++++++++++--------
>  arch/mips/kernel/mcount.S | 13 +++++++++++
>  2 files changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 60e7e5e..2a72208 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -63,7 +63,7 @@ static inline int in_kernel_space(unsigned long ip)
>         ((unsigned int)(JAL | (((addr) >> 2) & ADDR_MASK)))
>
>  static unsigned int insn_jal_ftrace_caller __read_mostly;
> -static unsigned int insn_lui_v1_hi16_mcount __read_mostly;
> +static unsigned int insn_la_mcount[2] __read_mostly;
>  static unsigned int insn_j_ftrace_graph_caller __maybe_unused __read_mostly;
>
>  static inline void ftrace_dyn_arch_init_insns(void)
> @@ -71,10 +71,10 @@ static inline void ftrace_dyn_arch_init_insns(void)
>         u32 *buf;
>         unsigned int v1;
>
> -       /* lui v1, hi16_mcount */
> +       /* la v1, _mcount */
>         v1 = 3;
> -       buf = (u32 *)&insn_lui_v1_hi16_mcount;
> -       UASM_i_LA_mostly(&buf, v1, MCOUNT_ADDR);
> +       buf = (u32 *)&insn_la_mcount[0];
> +       UASM_i_LA(&buf, v1, MCOUNT_ADDR);
>
>         /* jal (ftrace_caller + 8), jump over the first two instruction */
>         buf = (u32 *)&insn_jal_ftrace_caller;
> @@ -111,14 +111,47 @@ static int ftrace_modify_code_2(unsigned long ip, unsigned int new_code1,
>                                 unsigned int new_code2)
>  {
>         int faulted;
> +       mm_segment_t old_fs;
>
>         safe_store_code(new_code1, ip, faulted);
>         if (unlikely(faulted))
>                 return -EFAULT;
> -       safe_store_code(new_code2, ip + 4, faulted);
> +
> +       ip += 4;
> +       safe_store_code(new_code2, ip, faulted);
>         if (unlikely(faulted))
>                 return -EFAULT;
> +
> +       ip -= 4;
> +       old_fs = get_fs();
> +       set_fs(get_ds());
>         flush_icache_range(ip, ip + 8);
> +       set_fs(old_fs);
> +
> +       return 0;
> +}
> +
> +static int ftrace_modify_code_2r(unsigned long ip, unsigned int new_code1,
> +                                unsigned int new_code2)
> +{
> +       int faulted;
> +       mm_segment_t old_fs;
> +
> +       ip += 4;
> +       safe_store_code(new_code2, ip, faulted);
> +       if (unlikely(faulted))
> +               return -EFAULT;
> +
> +       ip -= 4;
> +       safe_store_code(new_code1, ip, faulted);
> +       if (unlikely(faulted))
> +               return -EFAULT;
> +
> +       old_fs = get_fs();
> +       set_fs(get_ds());
> +       flush_icache_range(ip, ip + 8);
> +       set_fs(old_fs);
> +
>         return 0;
>  }
>  #endif
> @@ -130,13 +163,14 @@ static int ftrace_modify_code_2(unsigned long ip, unsigned int new_code1,
>   *
>   * move at, ra
>   * jal _mcount         --> nop
> + *  sub sp, sp, 8      --> nop  (CONFIG_32BIT)
>   *
>   * 2. For modules:
>   *
>   * 2.1 For KBUILD_MCOUNT_RA_ADDRESS and CONFIG_32BIT
>   *
>   * lui v1, hi_16bit_of_mcount       --> b 1f (0x10000005)
> - * addiu v1, v1, low_16bit_of_mcount
> + * addiu v1, v1, low_16bit_of_mcount --> nop  (CONFIG_32BIT)
>   * move at, ra
>   * move $12, ra_address
>   * jalr v1
> @@ -145,7 +179,7 @@ static int ftrace_modify_code_2(unsigned long ip, unsigned int new_code1,
>   * 2.2 For the Other situations
>   *
>   * lui v1, hi_16bit_of_mcount       --> b 1f (0x10000004)
> - * addiu v1, v1, low_16bit_of_mcount
> + * addiu v1, v1, low_16bit_of_mcount --> nop  (CONFIG_32BIT)
>   * move at, ra
>   * jalr v1
>   *  nop | move $12, ra_address | sub sp, sp, 8
> @@ -184,10 +218,14 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>         unsigned int new;
>         unsigned long ip = rec->ip;
>
> -       new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
> -               insn_lui_v1_hi16_mcount;
> +       new = in_kernel_space(ip) ? insn_jal_ftrace_caller : insn_la_mcount[0];
>
> +#ifdef CONFIG_64BIT
>         return ftrace_modify_code(ip, new);
> +#else
> +       return ftrace_modify_code_2r(ip, new, in_kernel_space(ip) ?
> +                                               INSN_NOP : insn_la_mcount[1]);
> +#endif
>  }
>
>  #define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index 539b629..26ceb3c 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -84,6 +84,19 @@ _mcount:
>  #endif
>
>         PTR_SUBU a0, ra, 8      /* arg1: self address */
> +       PTR_LA   t1, _stext
> +       sltu     t2, a0, t1     /* t2 = (a0 < _stext) */
> +       PTR_LA   t1, _etext
> +       sltu     t3, t1, a0     /* t3 = (a0 > _etext) */
> +       or       t1, t2, t3
> +       beqz     t1, ftrace_call
> +        nop
> +#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
> +       PTR_SUBU a0, a0, 16     /* arg1: adjust to module's recorded callsite */
> +#else
> +       PTR_SUBU a0, a0, 12
> +#endif
> +
>         .globl ftrace_call
>  ftrace_call:
>         nop     /* a placeholder for the call to a real tracing function */
> --
> 2.0.0.526.g5318336
>
