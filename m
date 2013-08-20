Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 19:25:17 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55342 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828766Ab3HTRZO2MhwI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 19:25:14 +0200
Received: by mail-pb0-f44.google.com with SMTP id xa7so664173pbc.17
        for <multiple recipients>; Tue, 20 Aug 2013 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5OnVjNrhgfz1zqExSeNyQTLTDoyvVT1BCGINuDVlopc=;
        b=sgXJ9J1tx07KW2QBUvaeGzBqgobCiQEGfDbMh5SUjCr2k5mEGoFeddLpqby1LhLFQA
         9Snc5976NZ/58CzMOAC/cZqLCjLpPihqAJdJEu/gdxR9sZN5lsbuc6K7L1/uhnqRIesV
         gL0K8GO9QfPnkLHscY2K/pPDD/coLaYsH4K3FeTxOH6sr31/MUM6c5c9ciPlQHWgUOAO
         kNb7aIVOqlcKjlrGYrjTKFviZs1h4XsbbEfPxdwNOF47FYfxBAINDDNi4SSqGCP9JpCh
         P7GchrCXmqX2L9QRprFW5jIQTB7Vyasu0tmlsxAlVYk+qwExSPO3sGtWmJz5RUYeBJik
         KYQQ==
X-Received: by 10.66.150.41 with SMTP id uf9mr5065820pab.108.1377019508025;
 Tue, 20 Aug 2013 10:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.41.193 with HTTP; Tue, 20 Aug 2013 10:24:27 -0700 (PDT)
In-Reply-To: <20130801135505.GA3466@linux-mips.org>
References: <1375350938-16554-1-git-send-email-jogo@openwrt.org> <20130801135505.GA3466@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 20 Aug 2013 18:24:27 +0100
Message-ID: <CAGVrzcb4BS=YFEht72dz27uFsz3eht7yoNX==LYarn5B_A2ZGg@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/8/1 Ralf Baechle <ralf@linux-mips.org>:
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
>
>   Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Better late than never:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

>
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



-- 
Florian
