Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2009 07:16:32 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:51648 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491918AbZKMGQZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2009 07:16:25 +0100
Received: by pxi3 with SMTP id 3so2160509pxi.22
        for <multiple recipients>; Thu, 12 Nov 2009 22:16:17 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=0bsvJBxAyekWS1ngn0XS7g/h7PHggiV2nuEXJAYrVCg=;
        b=u+Hh0OtdWHoDFA09GeXb8smo6hpJDGEItSY7qX5Jag6/VhawmZDoysHjGQC2tY55rx
         YEZTZYAdIB6RTJghWXkrCFB+xLLPC9OnWaHGa2ocQchhrIUuILfvYe663X7JFvvg4JL3
         Jgg/uYgtlXOPdF3HMrApcOy9iruoLy2uirC2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Xu5t1o9GK9S7OrL/OvISypdu5liUNeCu8aJjQujla/N9trnnOY1ZhhvwyWdVtoFzon
         cuTQLsKsgI04I54GM2GGvMVK0OD/aiYbMcpe2kLIL+1xjsvSg6nRJMJCQTE4FvhIzMSg
         047ekgqlv6I9PBBft4w7lMgsYY8eBucoexjhY=
Received: by 10.114.7.9 with SMTP id 9mr7533321wag.71.1258092977477;
        Thu, 12 Nov 2009 22:16:17 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2159298pxi.8.2009.11.12.22.16.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 22:16:16 -0800 (PST)
Subject: Re: [PATCH -queue 1/3] [loongson] lemote-2f: add cs5536 MFGPT
 timer support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com, huhb@lemote.com
In-Reply-To: <20091112201735.GA25435@linux-mips.org>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
	 <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
	 <20091112201735.GA25435@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 13 Nov 2009 14:16:08 +0800
Message-ID: <1258092968.3144.179.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2009-11-12 at 21:17 +0100, Ralf Baechle wrote:
[...]
> > And also, this external timer is also needed by the next Cpufreq support,
> > 'Cause the frequency of the MIPS Timer is half of the cpu frequency, if
> > we use it with Cpufreq support, the sytem time will become not accuracy.
[...]
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> > index 029360f..648c47d 100644
> > --- a/arch/mips/loongson/Kconfig
> > +++ b/arch/mips/loongson/Kconfig
> > @@ -34,10 +34,10 @@ config LEMOTE_MACH2F
> >  	select ARCH_SPARSEMEM_ENABLE
> >  	select BOARD_SCACHE
> >  	select BOOT_ELF32
> > -	select CEVT_R4K
> > +	select CEVT_R4K if !CS5536_MFGPT
> >  	select CPU_HAS_WB
> >  	select CS5536
> > -	select CSRC_R4K
> > +	select CSRC_R4K if !CS5536_MFGPT
> 
> A bit inelegant to trust on a user to pick the right value for CS5536_MFGPT.
> 
> A non-fixed clock for c0_count is an obvious reason to avoid using CEVT_R4K
> and CSRC_R4K; we probably need something like cpu_has_fixed_c0_count_clock
> to make that decission at runtime.

Do you mean enable both of them when compiling, and at runtime select
the external one when something like cpu_has_fixed_c0_count_clock is
undefined and the CPUFreq Driver is loaded?

This maybe a good idea to allow users to choose their need in userspace
via /sys/devices/system/clocksource/clocksource0/current_clocksource,
and hide the details from the users.

But we may meet some problems:

  1. At first, we must ensure the external one is used when the CPUFreq
Driver is loaded.

  Just have a look at the source code in kernel/time/clocksource.c,
Seems we can finish this job via clocksource_change_rating().
  
  we can try to increase the rating of the MFGPT Timer(external timer,
in Gdium, they use I8253), but perhaps we need to add a flag to this
external timer to mask them, otherwise, we will not know which one is
the external one, what about these flags in include/linux/clocksource.h:

/*
 * Clock source flags bits:
 */
#define CLOCK_SOURCE_IS_CONTINUOUS              0x01
#define CLOCK_SOURCE_MUST_VERIFY                0x02

#define CLOCK_SOURCE_WATCHDOG                   0x10
#define CLOCK_SOURCE_VALID_FOR_HRES             0x20
#define CLOCK_SOURCE_UNSTABLE                   0x40

  Seems no suitable flag to mask them, what about 0? we just set the
flag as 0, 'Cause the flag of MIPS Timer is set as
CLOCK_SOURCE_IS_CONTINUOUS, we will be able to distinguish them by this
flag. so, this problem will be fixed.

  Of course, if there is no external timer found, we have to exit from
the CPUFreq Driver. and also, we need to resume the Timer to the MIPS
when we unload the CPUFreq Driver.

  2. And another problem is: people will choose their own
current_clocksource when they want, if they choose MIPS, we must disable
the CPUFreq Driver asap, otherwise, the system time will be broken.

  It will be hard to detect when will people change the current clock
source, and just checked the clocksource_select() in
kernel/time/clocksource.c, seems there is a timekeeping_notify() called:

  timekeeping_notify()
     --> tick_clock_notify()
      --> set_bit(0, &per_cpu(tick_cpu_sched, cpu).check_clocks);

  perhaps we can check the check_clocks bit in the CPUFreq Driver, for
example we do it in loongson2_cpufreq_target(), but we can not protect,
which cpu frequency currently we are, if we are not in the normal
level(normally it is 797MHz, the mult/shift of MIPS timer is calculated
with mips_hpt_frequency when initialization), we will also break the
system time. So, if we really want to fix this problem, perhaps we need
to touch the source code of the clocksource subsystem, 

kernel/time/timekeeping.c:

/**
 * timekeeping_notify - Install a new clock source
 * @clock:              pointer to the clock source
 *
 * This function is called from clocksource.c after a new, better clock
 * source has been registered. The caller holds the clocksource_mutex.
 */
void timekeeping_notify(struct clocksource *clock)
{
        if (timekeeper.clock == clock)
                return;
        stop_machine(change_clocksource, clock, NULL);
        tick_clock_notify();
}
  
 We can add a early-notify before changing the clocksource to tell the
relative drivers to do some necessary preparation.

void timekeeping_notify(struct clocksource *clock)
{
        if (timekeeper.clock == clock)
                return;
+	 tick_clock_early_notify(clock);
        stop_machine(change_clocksource, clock, NULL);
        tick_clock_notify();
}

we must ensure the drivers can register a notifier to that
tick_clock_early_notify can called by it.

and then, in the CPUFreq driver, we can check who is the target clock,
if it is MIPS, the CPUFreq driver must change it's Frequency to a normal
level and then the whole problem will be fixed.

Seems this will make the problem be more complex.

> >  	select DMA_NONCOHERENT
> >  	select GENERIC_HARDIRQS_NO__DO_IRQ
> >  	select GENERIC_ISA_DMA_SUPPORT_BROKEN
> > @@ -62,6 +62,13 @@ endchoice
> >  config CS5536
> >  	bool
> >  
> > +config CS5536_MFGPT
> > +	bool "Using cs5536's MFGPT as system clock"
> > +	depends on CS5536
> > +	help
> > +	  This is needed when cpufreq or oprofile is enabled in Lemote Loongson2F
> > +	  family machines
> 
> A patch to deal with interaction between oprofile and the cp0 count / compare
> was queued recently.  So is there any remaining issue or is the comment here
> just outdated?
> 

Okay, Will remove the out-of-date part.

Thanks & Regards,
	Wu Zhangjin
