Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 10:01:45 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:63904 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492555AbZKWJBj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 10:01:39 +0100
Received: by pwi15 with SMTP id 15so3460512pwi.24
        for <multiple recipients>; Mon, 23 Nov 2009 01:01:31 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Ckx627iUuM2r2NAFJYzZZ+o/GGiUL/wc4iGzcSDdTlE=;
        b=YZmqhfbSFq4i1QhfT4dY7OJK+xChVBEJ+FbAb3+GX7o869YMYfU/B31LsHAoIqimeX
         k7+I3Yh/ulTqlIGy5ijLCUlYnfasMrj5QwLP76mxz4Rt+KnQ6ZFF2QCr/FuV7yCV9xlX
         io5JjNQO01Xq12f7LhoBIiG72voNtj21gs6ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=xfSQEkoqP4MB3gKvQ6cYwcJmQ3ljG/v2MPpxDr+N3/iddoZsz714x4QmSfCEIlIWD0
         aYlIXDuZXoWJC8chfJJKRjlYLvmTu3JbLHi/F96My3LHmxGVDAEpvfIrNUMZQMQ+t5Ro
         sqg9wx+qdZQX5H7EmEhUmCOERpw2tLoJzMDt0=
Received: by 10.114.18.17 with SMTP id 17mr8338496war.131.1258966891210;
        Mon, 23 Nov 2009 01:01:31 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2941862pzk.1.2009.11.23.01.01.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 01:01:30 -0800 (PST)
Subject: Re: [PATCH v3] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
In-Reply-To: <20091123084423.GB23635@elte.hu>
References: <b08d39e76685878bc91d9de906d155f1daa1c985.1258894783.git.wuzhangjin@gmail.com>
	 <4B098AE4.6090804@ru.mvista.com>
	 <1258938035.2411.6.camel@falcon.domain.org>
	 <20091123084423.GB23635@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 23 Nov 2009 17:00:43 +0800
Message-ID: <1258966849.6088.0.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-23 at 09:44 +0100, Ingo Molnar wrote:
> * Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> 
> > On Sun, 2009-11-22 at 22:03 +0300, Sergei Shtylyov wrote:
> > > Hello.
> > > 
> > > Wu Zhangjin wrote:
> > > 
> > > > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > > >
> > > > (This v3 revision incorporates with the feedbacks from Ingo, Ralf and Sergei.)
> > > >
> > > > This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> > > > which provides high resolution. and also, one new kernel option
> > > > (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> > > >
> > > > Without it, the Ftrace for MIPS will give useless timestamp information.
> > > >
> > > > Because cnt32_to_63() needs to be called at least once per half period
> > > > to work properly, Differ from the old version, this v2 revision set up a
> > > > kernel timer to ensure the requirement of some MIPSs which have short c0
> > > > count period.
> > > >
> > > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > > > ---
> > > >  arch/mips/Kconfig           |   18 ++++++++++++++
> > > >  arch/mips/kernel/csrc-r4k.c |   55 +++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 73 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > > index b342197..5ea55f5 100644
> > > > --- a/arch/mips/Kconfig
> > > > +++ b/arch/mips/Kconfig
> > > > @@ -1952,6 +1952,24 @@ config NR_CPUS
> > > >  source "kernel/time/Kconfig"
> > > >  
> > > >  #
> > > > +# High Resolution sched_clock() Configuration
> > > > +#
> > > > +
> > > > +config HR_SCHED_CLOCK
> > > > +	bool "High Resolution sched_clock()"
> > > > +	depends on CSRC_R4K
> > > > +	default n
> > > > +	help
> > > > +	  This option enables the MIPS c0 count based high resolution
> > > > +	  sched_clock().
> > > > +
> > > > +	  If you need a ns precision timestamp, you are recommended to enable
> > > > +	  this option. For example, If you are using the Ftrace subsystem to do
> > > > +	  real time tracing, this option is needed.
> > > > +
> > > > +	  If unsure, disable it.
> > > > +
> > > > +#
> > > >  # Timer Interrupt Frequency Configuration
> > > >  #
> > > >  
> > > > diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> > > > index e95a3cd..e287f0d 100644
> > > > --- a/arch/mips/kernel/csrc-r4k.c
> > > > +++ b/arch/mips/kernel/csrc-r4k.c
> > > > @@ -10,6 +10,57 @@
> > > >  
> > > >  #include <asm/time.h>
> > > >  
> > > > +#ifdef CONFIG_HR_SCHED_CLOCK
> > > > +#include <linux/cnt32_to_63.h>
> > > > +#include <linux/timer.h>
> > > > +
> > > > +/*
> > > > + * MIPS sched_clock implementation.
> > > > + *
> > > > + * because cnt32_to_63() needs to be called at least once per half period to
> > > > + * work properly, and some of the MIPS frequency is high, perhaps a kernel
> > > > + * timer is needed to be set up to ensure this requirement is always met.
> > > > + * Please refer to arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
> > > > + */
> > > > +static unsigned long __read_mostly tclk2ns_scale;
> > > > +static unsigned long __read_mostly tclk2ns_scale_factor;
> > > > +
> > > > +unsigned long long notrace sched_clock(void)
> > > > +{
> > > > +	unsigned long long v = cnt32_to_63(read_c0_count());
> > > > +	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
> > > > +}
> > > > +
> > > > +static struct timer_list cnt32_to_63_keepwarm_timer;
> > > > +
> > > > +static void cnt32_to_63_keepwarm(unsigned long data)
> > > > +{
> > > > +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> > > > +	(void) sched_clock();
> > > > +}
> > > > +
> > > > +static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
> > > > +{
> > > > +	unsigned long long v;
> > > > +	unsigned long data;
> > > > +
> > > > +	v = cs->mult;
> > > > +	/*
> > > > +	 * We want an even value to automatically clear the top bit
> > > > +	 * returned by cnt32_to_63() without an additional run time
> > > > +	 * instruction. So if the LSB is 1 then round it up.
> > > > +	 */
> > > > +	if (v & 1)
> > > > +		v++;
> > > > +	tclk2ns_scale = v;
> > > > +	tclk2ns_scale_factor = cs->shift;
> > > > +
> > > > +	data = 0x80000000 / tclk * HZ;
> > > > +	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
> > > > +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> > > > +}
> > > > +#endif	/* !CONFIG_HR_SCHED_CLOCK */
> > > > +
> > > >  static cycle_t c0_hpt_read(struct clocksource *cs)
> > > >  {
> > > >  	return read_c0_count();
> > > > @@ -32,6 +83,10 @@ int __init init_r4k_clocksource(void)
> > > >  
> > > >  	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
> > > >  
> > > > +#ifdef CONFIG_HR_SCHED_CLOCK
> > > > +	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);
> > > > +#endif
> > > > +
> > > >   
> > > 
> > >    According to CodingStyle #ifdef's in the code are frowned upon. I 
> > > suggest that you add an empty setup_sched_clock() definition under #else 
> > > above and have the call here without #ifdef. That's the preferred way of 
> > > doing such things...
> > > 
> > 
> > Done, thanks!
> > 
> > Wil resend it later.
> 
> The proper solution would be what i suggested in my previous mail: to 
> put it into a separate .c file. It's easy as the code has its own 
> Kconfig value already. The only #ifdef is out of sight in a .h file.
> 

Done, thanks!

Regards,
	Wu Zhangjin
