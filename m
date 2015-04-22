Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 05:00:31 +0200 (CEST)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33582 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbDVDA3dRepe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 05:00:29 +0200
Received: by oica37 with SMTP id a37so166431955oic.0;
        Tue, 21 Apr 2015 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aYMFaKZL71PZPOYKy9W8whKQmnEiKNMPL6iYg8hsFkY=;
        b=RPmBzd2okbbUIIez+8ja3KIDNEcHSDbva9FitTidkwB8h+SPHSf/kXPFhTwRUC+Erj
         kzTn2+l8pz/SLV56uQn1OnJhinC1fpU0Lg8y3A9XezUylswaJXwlj7GL0RMeJmALGPo0
         a9sEEGCvirkigAk2wE91oNgJg+BrM8xoprYGTXpBrk3arJZJxmDyMHM9fWmx1wF4oFb0
         amiREVK19UKphByp6xDKq05XHKcLUUwr+I8qiAjc8I5xAQ8oDe4rr3f0Ymi5HKm0uOZp
         ZeRD81K0fBBicUt0/3AC9VcEXHgtN43k1BOXZu7jpS6hCXshZNjKBCZnahItZL8marJf
         aZcg==
X-Received: by 10.182.80.103 with SMTP id q7mr21763714obx.18.1429671625122;
 Tue, 21 Apr 2015 20:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.209.3 with HTTP; Tue, 21 Apr 2015 19:59:44 -0700 (PDT)
In-Reply-To: <20150421154108.GA20223@roeck-us.net>
References: <20150420194028.GA10814@roeck-us.net> <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
 <87fv7up15k.fsf@rustcorp.com.au> <20150421154108.GA20223@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 21 Apr 2015 19:59:44 -0700
Message-ID: <CAGVrzcYt0EAK05DoKBMT5m9wjk3rjAS_puDz3gbpbThrUq7e4A@mail.gmail.com>
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47003
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

2015-04-21 8:41 GMT-07:00 Guenter Roeck <linux@roeck-us.net>:
> On Tue, Apr 21, 2015 at 01:45:35PM +0930, Rusty Russell wrote:
>> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
>> > Hi,
>> >
>> > On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:
>> >> the upstream kernel fails to build mips:nlm_xlp_defconfig,
>> >> mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
>> >> other targets, with errors such as
>> >>
>> >> arch/mips/kernel/smp.c:211:2: error:
>> >>    passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
>> >>    from pointer target type
>> >> arch/mips/kernel/process.c:52:2: error:
>> >>    passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
>> >>    from pointer target type
>> >> arch/mips/cavium-octeon/smp.c:242:2: error:
>> >>    passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
>> >>    from pointer target type
>> >>
>> >> The problem was introduced with commit 8dd928915a73 (" mips: fix up
>> >> obsolete cpu function usage"). I would send a patch to fix it, but I
>> >> am not sure if removing 'volatile' from the variable declaration(s)
>> >> would be a good idea.
>> >
>> > I think removing volatile from cpu_callin_map declaration should be OK,
>> > since test_cpu (only reader) uses test_bit which takes care of it:
>> >
>> >     static inline int test_bit(int nr, const volatile unsigned long *addr)
>>
>> No, that got replaced too, with cpumask_test_cpu AFAICT.
>>
>> You can open-code it, like so:
>>
>>         test_bit(0, cpumask_bits(cpu_callin_map));
>>
>> But you probably want to put a barrier in that loop instead of relying
>> on volatile.
>>
> The following might do it. Note that I can not really test it since I don't have
> a real mips system, and qemu gets rcu hangs if I enable more than one CPU (I see
> that with older kernels as well, so it is not a new problem). Someone will have
> to test the patch on a real multi-core system.

Would be nice to get this merged ASAP as a build failure is not great.
See below for the tested tag, thanks for the fix!

>
> Guenter
>
> ---
> From 94026cc98a6b7b3567780a5443674c71202e2497 Mon Sep 17 00:00:00 2001
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Tue, 21 Apr 2015 08:31:01 -0700
> Subject: [PATCH] mips: Fix SMP builds
>
> Mips SMP builds fail with error messages similar to the following.
>
> arch/mips/kernel/smp.c:211:2: error:
>         passing argument 2 of 'cpumask_set_cpu' discards 'volatile'
>         qualifier from pointer target type
> arch/mips/kernel/process.c:52:2: error:
>         passing argument 2 of 'cpumask_test_cpu' discards 'volatile'
>         qualifier from pointer target type
> arch/mips/cavium-octeon/smp.c:242:2: error:
>         passing argument 2 of 'cpumask_clear_cpu' discards 'volatile'
>         qualifier from pointer target type
>
> cpu_callin_map is declared as volatile variable, but passed to various
> functions with non-volatile arguments. Make it non-volatile and add a
> memory barrier at the one location where volatile might be needed.
>
> Fixes: 8dd928915a73 ("mips: fix up obsolete cpu function usage")
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

On Netlogic XLP-FVP (8 cores):

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/include/asm/smp.h | 2 +-
>  arch/mips/kernel/smp.c      | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index bb02fac9b4fa..2b25d1ba1ea0 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -45,7 +45,7 @@ extern int __cpu_logical_map[NR_CPUS];
>  #define SMP_DUMP               0x8
>  #define SMP_ASK_C0COUNT                0x10
>
> -extern volatile cpumask_t cpu_callin_map;
> +extern cpumask_t cpu_callin_map;
>
>  /* Mask of CPUs which are currently definitely operating coherently */
>  extern cpumask_t cpu_coherent_mask;
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 193ace7955fb..158191394770 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -43,7 +43,7 @@
>  #include <asm/time.h>
>  #include <asm/setup.h>
>
> -volatile cpumask_t cpu_callin_map;     /* Bitmask of started secondaries */
> +cpumask_t cpu_callin_map;              /* Bitmask of started secondaries */
>
>  int __cpu_number_map[NR_CPUS];         /* Map physical to logical */
>  EXPORT_SYMBOL(__cpu_number_map);
> @@ -218,8 +218,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>         /*
>          * Trust is futile.  We should really have timeouts ...
>          */
> -       while (!cpumask_test_cpu(cpu, &cpu_callin_map))
> +       while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
>                 udelay(100);
> +               mb();
> +       }
>
>         synchronise_count_master(cpu);
>         return 0;
> --
> 2.1.0
>



-- 
Florian
