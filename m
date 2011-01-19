Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:32:38 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:36805 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab1ASTa7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jan 2011 20:30:59 +0100
Received: by ewy20 with SMTP id 20so649150ewy.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YVSgHjtCCMcVa15dA/CmrmAmn+fAu3Tf5v9M1iByMhQ=;
        b=ntdf44ZXPOq/r1sPHdQr8SNmyPRGIbEUxsNfpSwVWzd8cz6k+AHcmLwVHOW34rx8XD
         GM035W7UwkC/IG5ltUmiL6CCVIRTknrwVSSPvn+U+DTPAAfaweDPZ9ADYP5/91KHRNLQ
         +hCbzU+4foaDrVa+ZhOnbUK8guQfD9NNSMKO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=URJ9ZFdjz1A81kTUYYKP+rnShYeQi4k/Ptw8KBWVikWJu5JN3CmuTWd64reiwUJn/7
         ZAn/goMZgkHPm4U2wNTDizoTJ8nTT+mnRVwCjs6M17uatHgIt9CPxTlBYqgl8VGXk2wV
         0RWHSVCE9rGJFEk1JjU0hBzf2Zx87GusUeloM=
MIME-Version: 1.0
Received: by 10.227.151.75 with SMTP id b11mr1311321wbw.117.1295465458591;
 Wed, 19 Jan 2011 11:30:58 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Wed, 19 Jan 2011 11:30:58 -0800 (PST)
In-Reply-To: <40f92f8a1acdd1a0afae9a014d38d2cfea5557cf.1295464564.git.wuzhangjin@gmail.com>
References: <cover.1295464564.git.wuzhangjin@gmail.com>
        <cover.1295464855.git.wuzhangjin@gmail.com>
        <40f92f8a1acdd1a0afae9a014d38d2cfea5557cf.1295464564.git.wuzhangjin@gmail.com>
Date:   Thu, 20 Jan 2011 03:30:58 +0800
Message-ID: <AANLkTik9FhiE+JuVpMWgoBsdpqiXCQ+ejR5rCCT5-1A5@mail.gmail.com>
Subject: Re: [PATCH 2/5] tracing, MIPS: replace in_module() with a generic in_kernel_space()
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

And ignore this one too.

On Thu, Jan 20, 2011 at 3:28 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> The old in_module() may not work in some situations(e.g. when module &
> kernel are in the same address space when CONFIG_MAPPED_KERNEL=y), The
> in_kernel_space() is more generic and it is also easy to be implemented
> via cloning the existing core_kernel_text(), so, replace the in_module()
> with in_kernel_space().
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/ftrace.c |   54 ++++++++++++++++++++++----------------------
>  1 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 635c1dc..5970286 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -17,21 +17,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/uasm.h>
>
> -/*
> - * If the Instruction Pointer is in module space (0xc0000000), return true;
> - * otherwise, it is in kernel space (0x80000000), return false.
> - *
> - * FIXME: This will not work when the kernel space and module space are the
> - * same. If they are the same, we need to modify scripts/recordmcount.pl,
> - * ftrace_make_nop/call() and the other related parts to ensure the
> - * enabling/disabling of the calling site to _mcount is right for both kernel
> - * and module.
> - */
> -
> -static inline int in_module(unsigned long ip)
> -{
> -       return ip & 0x40000000;
> -}
> +#include <asm-generic/sections.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
>
> @@ -69,6 +55,20 @@ static inline void ftrace_dyn_arch_init_insns(void)
>  #endif
>  }
>
> +/*
> + * Check if the address is in kernel space
> + *
> + * Clone core_kernel_text() from kernel/extable.c, but doesn't call
> + * init_kernel_text() for Ftrace doesn't trace functions in init sections.
> + */
> +static inline int in_kernel_space(unsigned long ip)
> +{
> +       if (ip >= (unsigned long)_stext &&
> +           ip <= (unsigned long)_etext)
> +               return 1;
> +       return 0;
> +}
> +
>  static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
>  {
>        int faulted;
> @@ -91,10 +91,16 @@ int ftrace_make_nop(struct module *mod,
>        unsigned long ip = rec->ip;
>
>        /*
> -        * We have compiled module with -mlong-calls, but compiled the kernel
> -        * without it, we need to cope with them respectively.
> +        * If ip is in kernel space, no long call, otherwise, long call is
> +        * needed.
>         */
> -       if (in_module(ip)) {
> +       if (in_kernel_space(ip)) {
> +               /*
> +                * move at, ra
> +                * jal _mcount          --> nop
> +                */
> +               new = INSN_NOP;
> +       } else {
>  #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
>                /*
>                 * lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
> @@ -117,12 +123,6 @@ int ftrace_make_nop(struct module *mod,
>                 */
>                new = INSN_B_1F_4;
>  #endif
> -       } else {
> -               /*
> -                * move at, ra
> -                * jal _mcount          --> nop
> -                */
> -               new = INSN_NOP;
>        }
>        return ftrace_modify_code(ip, new);
>  }
> @@ -132,8 +132,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>        unsigned int new;
>        unsigned long ip = rec->ip;
>
> -       /* ip, module: 0xc0000000, kernel: 0x80000000 */
> -       new = in_module(ip) ? insn_lui_v1_hi16_mcount : insn_jal_ftrace_caller;
> +       new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
> +               insn_lui_v1_hi16_mcount;
>
>        return ftrace_modify_code(ip, new);
>  }
> @@ -204,7 +204,7 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
>         * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
>         * kernel, move after the instruction "move ra, at"(offset is 16)
>         */
> -       ip = self_addr - (in_module(self_addr) ? 24 : 16);
> +       ip = self_addr - (in_kernel_space(self_addr) ? 16 : 24);
>
>        /*
>         * search the text until finding the non-store instruction or "s{d,w}
> --
> 1.7.1
>
>
