Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K5mHV03489
	for linux-mips-outgoing; Tue, 19 Feb 2002 21:48:17 -0800
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K5mD903486
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 21:48:13 -0800
Received: (qmail 11470 invoked from network); 20 Feb 2002 04:48:13 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2002 04:48:13 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g1K4m8C04590
	for linux-mips@oss.sgi.com; Tue, 19 Feb 2002 23:48:08 -0500
X-Authentication-Warning: localhost.hpti.com: lindahl set sender to lindahl@conservativecomputer.com using -f
Date: Tue, 19 Feb 2002 23:48:08 -0500
From: Greg Lindahl <lindahl@conservativecomputer.com>
To: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219234808.A4475@wumpus.skymv.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219202434.F25739@mvista.com>; from jsun@mvista.com on Tue, Feb 19, 2002 at 08:24:34PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 08:24:34PM -0800, Jun Sun wrote:

> I think the comment might be an execuse. :-)  Never heard of gcc
> generating unnecessary floating point code.

I don't really remember, but I think the Alpha calling standards
encourages using some of the fp registers as scratch all the time. The
price is that you have to always save them, but you get more registers,
which helps you avoid spills, which speeds up all kinds of code.

> If you do use floating point, I think it is pretty common to have
> only process that uses fpu and runs for very long.  In that case,
> leaving FPU owned by the process also saves quite a bit.

You're assuming, I guess, that there are a lot of interrupts. OK, so
how much CPU time is saved? You can't compare the cost if you don't
know the number.

> In this case, proc that uses fpu gets about 50% of one cpu, i.e.,
> 25% of total load, while the other two integer math proces split the
> rest 75%, which gives 37.5% each.  Not too bad in my opinion.

One man's "not too bad" can be another man's "oh my God, that's
horrible!"

-- greg
