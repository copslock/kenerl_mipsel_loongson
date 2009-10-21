Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 17:11:34 +0200 (CEST)
Received: from mail-qy0-f172.google.com ([209.85.221.172]:39720 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493652AbZJUPL1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 17:11:27 +0200
Received: by qyk2 with SMTP id 2so5117973qyk.21
        for <multiple recipients>; Wed, 21 Oct 2009 08:11:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=yEQFEtxDCeny5U6MKieFs0mY3soHklaTM2aI6tvo/9Y=;
        b=dNsYiKXlBQPaWtXKZMDGKrYh4LvVYmnUKnMfEw15xlIqWQgvZwH2BgUJzjvfxiT3J2
         +HtzppkfoXTZWFxvigpPNCempG18iYNTrdmZVcReI+gw50fy25sfGva9sWagCGkLQlai
         2ZPVXw3DJSxTcgpexGUhAne8sGe7n6QeLsTaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nfmmCN+rvTz8k7hcViGb7982+jNVFQDgf4PLV092goezUgj34VVwLYaeIwoWCwD0B5
         mWY6wZXUHHzs4TYDmxIDtdJDN36K9OaNY5A+zmVZ0z0a2W8gbG0BixRjU5pgPUQ3GsHT
         GlCTX5ADREt++23egusOX0fFTtZA9U2bU625s=
Received: by 10.103.85.12 with SMTP id n12mr3561176mul.29.1256137879890;
        Wed, 21 Oct 2009 08:11:19 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id s10sm377027mue.52.2009.10.21.08.11.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 08:11:18 -0700 (PDT)
Subject: Re: [PATCH -v4 3/9] tracing: add MIPS specific trace_clock_local()
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256136393.18347.2997.camel@gandalf.stny.rr.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <1256136393.18347.2997.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 21 Oct 2009 23:11:07 +0800
Message-Id: <1256137867.11274.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 10:46 -0400, Steven Rostedt wrote:
> On Wed, 2009-10-21 at 22:34 +0800, Wu Zhangjin wrote:
> > This patch add the mips_timecounter_read() based high precision version
> > of trace_clock_local().
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  arch/mips/kernel/Makefile      |    6 ++++++
> >  arch/mips/kernel/trace_clock.c |   37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/kernel/trace_clock.c
> > 
> > diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> > index 8e26e9c..f228868 100644
> > --- a/arch/mips/kernel/Makefile
> > +++ b/arch/mips/kernel/Makefile
> > @@ -8,6 +8,10 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
> >  		   ptrace.o reset.o setup.o signal.o syscall.o \
> >  		   time.o topology.o traps.o unaligned.o watch.o
> >  
> > +ifdef CONFIG_FUNCTION_TRACER
> > +CFLAGS_REMOVE_trace_clock.o = -pg
> > +endif
> > +
> >  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> >  obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
> >  obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
> > @@ -24,6 +28,8 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
> >  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> >  obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
> >  
> > +obj-$(CONFIG_FTRACE)		+= trace_clock.o
> > +
> >  obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
> >  obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
> >  obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
> > diff --git a/arch/mips/kernel/trace_clock.c b/arch/mips/kernel/trace_clock.c
> > new file mode 100644
> > index 0000000..2e3475f
> > --- /dev/null
> > +++ b/arch/mips/kernel/trace_clock.c
> > @@ -0,0 +1,37 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive for
> > + * more details.
> > + *
> > + * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
> > + * Author: Wu Zhangjin <wuzj@lemote.com>
> > + */
> > +
> > +#include <linux/clocksource.h>
> > +#include <linux/sched.h>
> > +
> > +#include <asm/time.h>
> > +
> > +/*
> > + * trace_clock_local(): the simplest and least coherent tracing clock.
> > + *
> > + * Useful for tracing that does not cross to other CPUs nor
> > + * does it go through idle events.
> > + */
> > +u64 trace_clock_local(void)
> > +{
> > +	unsigned long flags;
> > +	u64 clock;
> > +
> > +	raw_local_irq_save(flags);
> > +
> > +	preempt_disable_notrace();
> 
> Why have the preempt_disable? You disable interrupts already, that will
> prevent any preemption at that point.
> 

just removed it.

Thanks!

Regards,
	Wu Zhangjin
