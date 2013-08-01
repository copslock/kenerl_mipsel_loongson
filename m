Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 16:15:18 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:45219 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822678Ab3HAOPIoC0GS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 16:15:08 +0200
Received: from mail-vb0-x22c.google.com (mail-vb0-x22c.google.com [IPv6:2607:f8b0:400c:c02::22c])
        by mail.nanl.de (Postfix) with ESMTPSA id 09D6C402DE;
        Thu,  1 Aug 2013 14:14:32 +0000 (UTC)
Received: by mail-vb0-f44.google.com with SMTP id e13so2144613vbg.17
        for <multiple recipients>; Thu, 01 Aug 2013 07:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ed2GfZFr5bhEYQK+AGL2Tc9yvPBj+Pz+NoeNI+oGmL4=;
        b=nDEV9kS/qhSEvgKcRE7HMdQPU3OW0C48NS1zry1J7WXduGd3wVgNOWnViCVsDR0sBT
         PftEdOwpnMdXsIqN3XAHpLWVu+Ue8v2sWzfdIfjMQ1Z3ofYRN8LCIKzs0AmTt5bAZ+D6
         3i0ZqDa9ttWwuqfvm7l7Nznqwc7oEtbKsrC8X1fpWQbakCqVuGFAELcMhbvMf8vybb3v
         0UtQfdIk9d4EjwPFqmc7ntHWdef3DyRnEcalPFmO+aH+BlNK2NsuKQPGkED563KUVCB9
         ZFU7ORNgajHFb7LYhNex57zYhd/o5MaqioMkBxG6tJnYaJoQFgIg3wkkApqe3enSYtmU
         tctA==
X-Received: by 10.52.116.209 with SMTP id jy17mr409620vdb.113.1375366503507;
 Thu, 01 Aug 2013 07:15:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Thu, 1 Aug 2013 07:14:43 -0700 (PDT)
In-Reply-To: <20130801135505.GA3466@linux-mips.org>
References: <1375350938-16554-1-git-send-email-jogo@openwrt.org> <20130801135505.GA3466@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 1 Aug 2013 16:14:43 +0200
Message-ID: <CAOiHx=kZuzVu=ung9suwuoYr7F5LP-ghNFzwVSM_Zrc3i+=Q-g@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Thu, Aug 1, 2013 at 3:55 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Aug 01, 2013 at 11:55:38AM +0200, Jonas Gorski wrote:
>
>> Commit 02b849f7613003fe5f9e58bf233d49b0ebd4a5e8 ("MIPS: Get rid of the
>> use of .macro in C code.") replaced the macro usage but missed
>> the accessors in bmips.h, causing the following build error:
>>
>>   CC      arch/mips/kernel/smp-bmips.o
>> {standard input}: Assembler messages:
>> {standard input}:951: Error: Unrecognized opcode `_ssnop'
>> {standard input}:952: Error: Unrecognized opcode `_ssnop'
>> (...)
>> make[6]: *** [arch/mips/kernel/smp-bmips.o] Error 1
>>
>> Fix this by also replacing the macros here, fixing the last occurrence
>> in mips.
>
> How about getting rid of the entire inline assembler code by something
> like below patch?

It certainly does look neater. One small issue though ...

>  arch/mips/include/asm/bmips.h | 56 ++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
> index 552a65a..6483d26 100644
> --- a/arch/mips/include/asm/bmips.h
> +++ b/arch/mips/include/asm/bmips.h
> @@ -13,6 +13,7 @@
>  #include <linux/compiler.h>
>  #include <linux/linkage.h>
>  #include <asm/addrspace.h>
> +#include <asm/r4kcache.h>
>  #include <asm/mipsregs.h>
>  #include <asm/hazards.h>
>
> @@ -65,44 +66,33 @@ static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
>  {
>         unsigned long ret;
>
> -       __asm__ __volatile__(
> -               ".set push\n"
> -               ".set noreorder\n"
> -               "cache %1, 0(%2)\n"
> -               "sync\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "mfc0 %0, $28, 3\n"
> -               "_ssnop\n"
> -               ".set pop\n"
> -               : "=&r" (ret)
> -               : "i" (Index_Load_Tag_S), "r" (ZSCM_REG_BASE + offset)
> -               : "memory");
> +       barrier();
> +       cache_op(Index_Load_Tag_S, ZSCM_REG_BASE + offset);
> +       __sync();
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       ret = read_c0_ddatalo();
> +       __ssnop();
> +
>         return ret;
>  }
>
>  static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
>  {
> -       __asm__ __volatile__(
> -               ".set push\n"
> -               ".set noreorder\n"
> -               "mtc0 %0, $28, 3\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "cache %1, 0(%2)\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               "_ssnop\n"
> -               : /* no outputs */
> -               : "r" (data),
> -                 "i" (Index_Store_Tag_S), "r" (ZSCM_REG_BASE + offset)
> -               : "memory");
> +       write_c0_ddatalo(3);

I guess this needs to be write_c0_ddatalo(data);

> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);
> +       __ssnop();
> +       __ssnop();
> +       __ssnop();
> +       barrier();
>  }
>
>  #endif /* !defined(__ASSEMBLY__) */
>

Kevin or Florian, can you comment on this?


Regards
Jonas
