Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 13:56:27 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44347 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822508Ab3FNL4ZnW3r1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 13:56:25 +0200
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com [209.85.220.179])
        by mail.nanl.de (Postfix) with ESMTPSA id 45203406CD;
        Fri, 14 Jun 2013 11:55:36 +0000 (UTC)
Received: by mail-vc0-f179.google.com with SMTP id hz11so353781vcb.38
        for <multiple recipients>; Fri, 14 Jun 2013 04:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oECgm6fJXQFZU3kIeEs7nIa58SaKzgaRHzsUslZAJdM=;
        b=P4axG4yKwi0NTur2deEhsxGvaBsTmx3geYrGkREZSYcRKIqP95eFPhaUr09F0e6iLM
         QNWFPegoN8s3dL2sT3lTUsanKmcZXR6JZ1bXjccQtJ5jzqHvQ1VE5EtRMwhdiw4t6a+N
         n8zAuXVtysRoaCwHmh7hukqXqRxTw7HBZ9Y7o4HRU4i8xB8u5emzihOvlGIagZ1sWKSJ
         LZ/Xv5iAJQ4KKdfdMkukmsxLTmLnoyiHz0NRb8YvSO23vYPcI1nt4+Vce+e/oWTi+xyL
         vXOr092k65XKtq8J7EvgIELIszyE/dCbkDKFj55FY2rr2f/9Lu2TClX1PvOhG8E0Cdk8
         gyBg==
X-Received: by 10.58.46.48 with SMTP id s16mr792144vem.52.1371210978282; Fri,
 14 Jun 2013 04:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Fri, 14 Jun 2013 04:55:57 -0700 (PDT)
In-Reply-To: <20130614103137.GA15775@linux-mips.org>
References: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
 <1370273975-12373-2-git-send-email-jogo@openwrt.org> <20130614103137.GA15775@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 14 Jun 2013 13:55:57 +0200
Message-ID: <CAOiHx=kUFk9uKP7U5tyZZqHNVoKZ5_mHpCN=yP_7YMSpPMHzzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM63XX: Add SMP support to prom.c
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36880
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

On Fri, Jun 14, 2013 at 12:31 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jun 03, 2013 at 05:39:33PM +0200, Jonas Gorski wrote:
>
>>
>> This involves two changes to the BSP code:
>>
>> 1) register_smp_ops() for BMIPS SMP
>>
>> 2) The CPU1 boot vector on some of the BCM63xx platforms conflicts with
>> the special interrupt vector (IV).  Move it to 0x8000_0380 at boot time,
>> to resolve the conflict.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> [jogo@openwrt.org: moved SMP ops registration into ifdef guard]
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>>  arch/mips/bcm63xx/prom.c |   33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
>> index fd69808..1209373 100644
>> --- a/arch/mips/bcm63xx/prom.c
>> +++ b/arch/mips/bcm63xx/prom.c
>> @@ -8,7 +8,11 @@
>>
>>  #include <linux/init.h>
>>  #include <linux/bootmem.h>
>> +#include <linux/smp.h>
>>  #include <asm/bootinfo.h>
>> +#include <asm/bmips.h>
>> +#include <asm/smp-ops.h>
>> +#include <asm/mipsregs.h>
>>  #include <bcm63xx_board.h>
>>  #include <bcm63xx_cpu.h>
>>  #include <bcm63xx_io.h>
>> @@ -52,6 +56,35 @@ void __init prom_init(void)
>>
>>       /* do low level board init */
>>       board_prom_init();
>> +
>> +#if defined(CONFIG_CPU_BMIPS4350) && defined(CONFIG_SMP)
>> +     /* set up SMP */
>> +     register_smp_ops(&bmips_smp_ops);
>
> The call to register_smp_ops() can remain outside the #ifdef.  It's defined
> as:
>
> static inline void register_smp_ops(struct plat_smp_ops *ops)
> {
> }
>
> so the compiler will completly discard it and the referenced SMP ops.

As long as it doesn't cause linking errors with -O0 or something, I'm
fine with either way.

>> +
>> +     /*
>> +      * BCM6328 does not have its second CPU enabled, while BCM6358
>> +      * needs special handling for its shared TLB, so disable SMP for now.
>> +      */
>> +     if (BCMCPU_IS_6328() || BCMCPU_IS_6358()) {
>> +             bmips_smp_enabled = 0;
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * The bootloader has set up the CPU1 reset vector at 0xa000_0200.
>> +      * This conflicts with the special interrupt vector (IV).
>> +      * The bootloader has also set up CPU1 to respond to the wrong
>> +      * IPI interrupt.
>> +      * Here we will start up CPU1 in the background and ask it to
>> +      * reconfigure itself then go back to sleep.
>> +      */
>> +     memcpy((void *)0xa0000200, &bmips_smp_movevec, 0x20);
>> +     __sync();
>> +     set_c0_cause(C_SW0);
>> +     cpumask_set_cpu(1, &bmips_booted_mask);
>> +
>> +     /* FIXME: we really should have some sort of hazard barrier here */
>
> Any reason why the remainder of this code can't go into the smp_setup
> method?  That then would entirely eleminate the <censored> ifdef.

Yes, it would introduce an ifdef there, as this is (as far as I
understood Kevin) bcm63xx specific, and other platforms with BMIPS
CPUs aren't affected by it.
If you want I can replace the #ifdef with if (IS_ENABLED()) if that
suits you better.


Jonas
