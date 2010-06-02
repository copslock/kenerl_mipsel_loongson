Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 11:35:20 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:60733 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491135Ab0FBJfN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 11:35:13 +0200
Received: by pvb32 with SMTP id 32so847876pvb.36
        for <multiple recipients>; Wed, 02 Jun 2010 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SQHEZc864lRCuokvgRSoyHwWopJG/DJJqLyBSk0aj90=;
        b=lSlDo3Po0I7/VyZDVnzVR3tNpxK6NGO364ktHO6EW0k+ybkzUpyuPMGRaaHC0yvjGN
         QMUBWh93PFJgoSYJtSzjFjSil/DkkcvbYnpYYScJlupuhv7q6FonKUHllHX6E7q+LMhl
         m7WA00nARm6WAe0r9upGAIMWg4ZuuDbQVWlqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Nc9bpxHv0ICBIC/ZDdC7gx43nB/RACT6Ic7gDiI7BNu7Rg/i0t8T7eUyPijiThKFMe
         mKYK70Y6G1hi5FgOVes898ZAoul6QOxge6Kzk+W+5FnI55vPuPmlq4wXlzvBrnUWt1OQ
         Q9xFop8zD2AiG71bQMIJfOYe7GsMA81iaA+h8=
MIME-Version: 1.0
Received: by 10.115.103.40 with SMTP id f40mr6703857wam.38.1275471306171; Wed, 
        02 Jun 2010 02:35:06 -0700 (PDT)
Received: by 10.142.179.7 with HTTP; Wed, 2 Jun 2010 02:35:06 -0700 (PDT)
In-Reply-To: <AANLkTik2DShzlr47Ce7UiS-FIAb6samirpcsjSCvjf97@mail.gmail.com>
References: <AANLkTilcSFUBHXHHttcXFVToL8waTmlxmts-elClSJar@mail.gmail.com>
        <AANLkTik2DShzlr47Ce7UiS-FIAb6samirpcsjSCvjf97@mail.gmail.com>
Date:   Wed, 2 Jun 2010 17:35:06 +0800
Message-ID: <AANLkTilYtBmSBw2ram0sZ1QblEbTiy3IzspNiokKCfj7@mail.gmail.com>
Subject: Re: [loongson2-PATCH] modification of the cpufreq module
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Gang Liang <randomizedthinking@gmail.com>
Cc:     loongson-dev@googlegroups.com, Hua Yan <yanh@lemote.com>,
        linux-mips <linux-mips@linux-mips.org>, cpufreq@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Dave Jones <davej@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1163

Hi, Gang

>
>
> This patch updates some aspects of the current implementation of
> cpufreq driver for Loongson2.
>
> 1) A default cpu_wait handler is installed such that the cpu will be
> alive at the lowest possible power level when a cpu_wait call is made;
>
> 2) The number of frequency levels is reduced to 3, and the lowest
> frequency is capped as a half of the full cpu speed. The "nowait" option
> is removed.
>
> Thanks!

Herein, You need to add a more line:

Signed-off-by: Gang Liang <randomizedthinking@gmail.com>

You can generate it automatically with:

$ git commit -s

or

$ git commit --amend -s

If you have configured your name and email address with:

$ git config --global user.name "Gang Liang"
$ git config --global user.email "randomizedthinking@gmail.com"

>
> ---
>  arch/mips/include/asm/mach-loongson/loongson.h |    4 +-
>  arch/mips/kernel/cpu-probe.c                   |   21 +++++++++
>  arch/mips/kernel/cpufreq/loongson2_clock.c     |   52 +++--------------------
>  arch/mips/kernel/cpufreq/loongson2_cpufreq.c   |   54 +++++++++---------------
>  4 files changed, 50 insertions(+), 81 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
> b/arch/mips/include/asm/mach-loongson/loongson.h
> index 53d0bef..33164b9 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -242,8 +242,8 @@ extern int mach_i8259_irq(void);
>
>  #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
>  #include <linux/cpufreq.h>
> -extern void loongson2_cpu_wait(void);
> -extern struct cpufreq_frequency_table loongson2_clockmod_table[];
> +/* extern void loongson2_cpu_wait(void); */
> +/* extern struct cpufreq_frequency_table loongson2_clockmod_table[]; */

Why not remove them directly?

>
>  /* Chip Config */
>  #define LOONGSON_CHIPCFG0              LOONGSON_REG(LOONGSON_REGBASE + 0x80)
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index be5bb16..5b3072c 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -25,6 +25,9 @@
>  #include <asm/system.h>
>  #include <asm/watch.h>
>  #include <asm/spram.h>
> +
> +#include <loongson.h>
> +

This may fail when building on non-Loongson platform.

Perhaps we need to add:

#ifdef CONFIG_CPU_LOONGSON2
#include <loongson.h>
#endif

>  /*
>  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
>  * the implementation of the "wait" feature differs between CPU families. This
> @@ -51,6 +54,21 @@ static void r39xx_wait(void)
>
>  extern void r4k_wait(void);
>
> +DEFINE_SPINLOCK(loongson2_wait_lock);

Perhaps we'd better use the RAW spinlock here:

DEFINE_RAW_SPINLOCK(loongson2_wait_lock);

and the operation should be raw_spin_lock_irqsave/restore...

> +static void loongson2_cpu_wait(void)
> +{
> +    u32 cpu_freq;
> +    unsigned long flags;
> +

The indent should be a TAB(the same to the others), you can try to
format it with:

indent -linux /path/to/file ...

and please check it with scripts/checkpatch.pl before sending your
next revision.

$ ./scripts/checkpatch.pl --strict /path/to/your_patch

and fix all of the errors and the warnings if possible.

> +    /* enter the lowest power mode available while still alive */
> +    /* future work: check cpu freq -- do nothing if no change */
> +    /* otherwise, change the frequency and propagate the clock rate */

For Comments, you'd better use something like this:

/*
 * enter ....
 */

and if you are using vim, you can format it with :gqap.

> +    spin_lock_irqsave(&loongson2_wait_lock, flags);
> +    cpu_freq = LOONGSON_CHIPCFG0;
> +       LOONGSON_CHIPCFG0 = (cpu_freq & ~0x7) | 1;

The indent problem here too.

> +    spin_unlock_irqrestore(&loongson2_wait_lock, flags);
> +}
> +
>  /*
>  * This variant is preferable as it allows testing need_resched and going to
>  * sleep depending on the outcome atomically.  Unfortunately the "It is
> @@ -212,6 +230,9 @@ void __init check_wait(void)
>                if ((c->processor_id & 0x00ff) >= 0x40)
>                        cpu_wait = r4k_wait;
>                break;
> +    case CPU_LOONGSON2:
> +        cpu_wait = loongson2_cpu_wait;
> +        break;

indent problem ;)

>        default:
>                break;
>        }

[...]

Will take a look at the left parts later.

Regards,
Wu Zhangjin
