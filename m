Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 03:47:38 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:51817 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492792AbZKKCrb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 03:47:31 +0100
Received: by ywh3 with SMTP id 3so1084437ywh.22
        for <multiple recipients>; Tue, 10 Nov 2009 18:47:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=1RcjX4Ee+Z/sxw3gSdQAMJ3OsHrYxIro16FzUDUfdq4=;
        b=Kx0BkOY5GitX3/r22igny02d5td68FxW/BnKk1Pso5S84ydIBqUot/kEjZckUkCrsL
         V40paepw4K2bJWvTq6EuKdfnw/ke3HAE9j1QscrfXOXv8SrF2P6e17Vzm2mut2VeQ9Um
         j5Vq6HdYY0YSjY/2mv0CsJ2/ShiLcXAG3InVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=I7ieCs6YAVBZE4IXWnOfWD4i2pZEGbtAXc1UjRc45HNiS64PBfHEiUxpkgvq6RPyFY
         JVXPAvNQMMwmrvm59FxbRdIFWnb1mu3g0NndttIw2HdSI310J31a8uwXEcBE7SkM3yL/
         gj1dmRA2kbRNz3K9iGIDGodaKXDOy12DteLc0=
Received: by 10.91.144.16 with SMTP id w16mr1520098agn.21.1257907643836;
        Tue, 10 Nov 2009 18:47:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm632185yxd.70.2009.11.10.18.47.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 18:47:22 -0800 (PST)
Subject: Re: [PATCH v7 03/17] tracing: add MIPS specific trace_clock_local()
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
In-Reply-To: <4AF9A77E.6020908@caviumnetworks.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <4AF9A77E.6020908@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 10:47:16 +0800
Message-ID: <1257907636.2922.48.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 2009-11-10 at 09:48 -0800, David Daney wrote:
> Wu Zhangjin wrote:
> [...]
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
> > +	clock = mips_timecounter_read();
> > +
> > +	raw_local_irq_restore(flags);
> > +
> > +	return clock;
> > +}
> 
> Why disable interrupts?
> 

I got it from kernel/trace/trace_clock.c:

/*
 * trace_clock_local(): the simplest and least coherent tracing clock.
 *
 * Useful for tracing that does not cross to other CPUs nor
 * does it go through idle events.
 */
u64 notrace trace_clock_local(void)
{
        unsigned long flags;
        u64 clock;

        /*
         * sched_clock() is an architecture implemented, fast, scalable,
         * lockless clock. It is not guaranteed to be coherent across
         * CPUs, nor across CPU idle events.
         */
        raw_local_irq_save(flags);
        clock = sched_clock();
        raw_local_irq_restore(flags);

        return clock;
}

> Also you call the new function mips_timecounter_read().  Since 
> sched_clock() is a weak function, you can override the definition with a 
> more accurate version when possible.  Then you could just directly call 
> it here, instead of adding the new mips_timecounter_read() that the 
> '[PATCH v7 02/17] tracing: add mips_timecounter_read() for MIPS' adds.
> 

Yes, I have tried to override the sched_clock(), but failed on
booting(just hang there). and also, as you know, this version of
mips_timecounter_read() will bring us some overhead, I think it's not a
good idea to enable it for the whole system, so, I only enable it for
ftrace.

Regards,
	Wu Zhangjin
