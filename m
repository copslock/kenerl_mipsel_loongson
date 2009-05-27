Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 18:38:59 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:44190 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022027AbZE0Rix (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 18:38:53 +0100
Received: by pxi17 with SMTP id 17so4384727pxi.22
        for <multiple recipients>; Wed, 27 May 2009 10:38:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=zTYp1gRB6urikkKHNK9pkK2eh3hD1HwEdqOdNEHusKE=;
        b=FCeXsgkPFqacwPzjq3XO64w2HZmu47pMb2Ya97jueR9xbWtXMKznXWzROyWuhl2ys3
         nFAct59Zx1C76Kxgk6rhL5bYM6GdLyJJ8bl806OQey6GdiglEsre6kpvhSrKmxAmakp9
         KK3nJuFESvw5ykvz/oKbDZe0KuaUE3nH/q3TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ZsTz527V5vMHrlIDu6oMV0jFy4BspnG7/8E7nKNb9dUA0Vt4q3IcQZAf4irBQBMoWl
         KjVQoSimUFHDteFqhZaOWjLhF9MtCB/9SfC74TewzCh3qr06MaVgISGjqQG8HFdwH1mi
         qDrNfOVfflhmPwdGJMJ7xCdsmbhJSwjQhea98=
Received: by 10.115.14.1 with SMTP id r1mr473444wai.27.1243445925641;
        Wed, 27 May 2009 10:38:45 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id v25sm14303305wah.46.2009.05.27.10.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 10:38:45 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 19/23] Loongson2F cpufreq support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>, Yan Hua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <m3skiqop3b.fsf@anduin.mandriva.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <1a75bd9d59ff0c92250ddb7238509a7a4b154505.1243362545.git.wuzj@lemote.com>
	 <m3skiqop3b.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 28 May 2009 01:37:59 +0800
Message-Id: <1243445879.11263.116.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-05-27 at 11:46 +0200, Arnaud Patard wrote:
> > Loongson2F add a new capability to dynamic scaling cpu frequency.  However the
> > cpu count timer depends on cpu frequency. So an alternative clock must be used
> > if this driver is enabled. Besides, the CPU enter wait state when the frequency
> > is setting zero. All these features help power save.
> >
> > In fuloong(2f) and yeeloong(2f), if you want to use this feature, you
> > should enable the cs5536 mfgpt timer.
[...]
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 74efb43..aa8cd64 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2136,6 +2136,23 @@ source "kernel/power/Kconfig"
> >  
> >  endmenu
> >  
> > +menu "CPU Frequency scaling"
> > +
> > +source "drivers/cpufreq/Kconfig"
> > +
> > +config LOONGSON2F_CPU_FREQ
> > +	bool "Loongson-2F CPU Frequency driver"
> > +	depends on CPU_LOONGSON2F && CPU_FREQ && CS5536_MFGPT
> 
> If I have a clock from (for instance) a i8253 compatible source, one will
> have to add something here. I'm not sure it's a good idea. Did you try
> with something like "select  LOONGSON2F_CPU_FREQ" in the machine Kconfig
> entry ?
> 

something like "select LOONGSON2F_CPU_FREQ" not work, because users may
do not need LOONGSON2F_CPU_FREQ.
 
what about this solution?

+config LOONGSON2F_CPU_FREQ +	bool "Loongson-2F CPU Frequency driver"
+	depends on CPU_LOONGSON2F && CPU_FREQ && (CS5536_MFGPT || I8253)


> > diff --git a/arch/mips/kernel/loongson2f_freq.c b/arch/mips/kernel/loongson2f_freq.c
> > new file mode 100644
> > index 0000000..183f36b
[...]
> > +static int __init loongson2f_cpufreq_module_init(void)
> > +{
> > +	struct cpuinfo_mips *c = &cpu_data[0];
> > +	int result;
> > +
> > +	if (c->processor_id != PRID_IMP_LOONGSON2F)
> > +		return -ENODEV;
> 
> How can this happen ? the Kconfig entry depends on CPU_LOONGSON2F so I
> would expect this is useless.
> 

i just removed it, thanks!

> > diff --git a/arch/mips/loongson/common/clock.c b/arch/mips/loongson/common/clock.c
> > new file mode 100644
> > index 0000000..a8c648d
> > --- /dev/null
> > +++ b/arch/mips/loongson/common/clock.c
[...]
> > +/*
> > + * This is the simple version of Loongson-2F wait
> > + * Maybe we need do this in interrupt disabled content
> > + */
> > +DEFINE_SPINLOCK(loongson2f_wait_lock);
> > +void loongson2f_cpu_wait(void)
> > +{
> > +	u32 cpu_freq;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&loongson2f_wait_lock, flags);
> > +	cpu_freq = LOONGSON_CHIPCFG0;
> > +	LOONGSON_CHIPCFG0 &= ~0x7;	/* Put CPU into wait mode */
> 
> by doing this, if you want to "wake up" the 2f, you need an external
> interrupt source otherwise your only solution is to power down your
> machine. Are you sure that it's really safe to enable it by default ?
> 

sorry, I am not clear why Yanhua use a loongson-specific cpu_wait
here(seems used in loongson2f_freq.c)? perhaps he can explain it. and I
also have a question about it: why not use the "wait" instruction
directly here like r4k_wait() does? or just use the r4k_wait() function
via adding some code in arch/mips/kernel/cpu-probe.c:

void __init check_wait(void)
{
    ...
    switch (c->cputype) {
    ...
    case CPU_PR4450:
    case CPU_BCM3302:
    case CPU_CAVIUM_OCTEON:
+    case CPU_LOONGSON2:
        cpu_wait = r4k_wait;
        break;
    ...
}

and even if we not use cpufreq, is better to enable a loongson-specific
cpu_wait()? cpu_wait() is called in cpu_idle() (defined in
arch/mips/kernel/process.c), does we need cpu_wait() to save power when
cpu is idle?
