Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 17:31:15 +0200 (CEST)
Received: from p508B7CE7.dip.t-dialin.net ([80.139.124.231]:16513 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSIBPbO>; Mon, 2 Sep 2002 17:31:14 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82GUr219081;
	Mon, 2 Sep 2002 18:30:53 +0200
Date: Mon, 2 Sep 2002 18:30:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Matthew Dharm <mdharm@momenco.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: time.c CP0_COMPARE
Message-ID: <20020902183053.E15618@linux-mips.org>
References: <NEBBLJGMNKKEEMNLHGAIEEKHCIAA.mdharm@momenco.com> <20020829142133.A3905@bacchus.dhis.org> <3D6E5C58.405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6E5C58.405@mvista.com>; from jsun@mvista.com on Thu, Aug 29, 2002 at 10:39:36AM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 29, 2002 at 10:39:36AM -0700, Jun Sun wrote:

> Ralf Baechle wrote:

> >  c0_compare = c0_count + mips_counter_frequency / HZ.
> > 
> > That's what the individual boards are currently doing themselves though that
> > should be done in generic code.
> > 
>
> Good idea.
> 
> The attached patch attempts to set the first interrupt. It should be benign 
> even if a system is not using CPU counter as timer interrupt.
> 
> I also updated the time.README, including a new section about implementation 
> on a SMP machine.

Applied though I think that this should also be done via start_secondary
that is we'll need some per_cpu_time_init analog to per_cpu_trap_init.
Also of course your change makes some cleanup possible as the initialization
no happens twice for a bunch of platforms.

  Ralf
