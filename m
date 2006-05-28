Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 12:50:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:3232 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133592AbWE1KuS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2006 12:50:18 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4SAoF5H028827;
	Sun, 28 May 2006 11:50:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4SAoE8c028826;
	Sun, 28 May 2006 11:50:14 +0100
Date:	Sun, 28 May 2006 11:50:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060528105014.GA28621@linux-mips.org>
References: <4478C0F1.8000006@gentoo.org> <20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org> <4479250E.3080604@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4479250E.3080604@gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 28, 2006 at 12:20:30AM -0400, Kumba wrote:

> >If it's really, really not deadlocky to call smp_call_function() with
> >interrupts disabled at that time in the MIPS kernel bringup then I'd
> >suggest you should open-code an smp_call_function() and put a big comment
> >over it explaining why it's done this way, and why it isn't deadlocky.

MIPS does on_each_cpu() for cache maintenance.  In the early stages before
interrupts are enabled there is only one CPU active anyway, so it's
perfectly safe - and obvious to the reader I hope - to use the local_*
variant of the cacheflushes.  smp_call_function will yell loudly anyway
if called with interrupts disabled.

> ><tries to remember what the deadlock is>
> >
> >If CPU A is running smp_call_function() it's waiting for CPU B to run the
> >handler.
> >
> >But if CPU B is presently _also_ running smp_call_function(), it's waiting
> >for CPU A to run the handler.
> >
> >If either of those CPUs is waiting for the other with local interrupts
> >disabled, that CPU will never respond to the other CPU's IPI and they'll
> >deadlock.

Circumstances which don't apply during the early startup phase but
since the MIPS smp_call_function() does a WARN_ON(irqs_disabled()) I had
to clean that.

> The catch is, the system being affected here is strictly a UP machine.  
> It's impossible to make an O2 go SMP.  It seems that the disable call in 
> the UP version of on_each_cpu() (which I assume is the #define macro) is 
> what's causing this issue, since the machine comes to a halt in the dark 
> void between function calls (i.e., that memset() I alluded to earlier)
> 
> So I'm wondering, is there a way to see if the IRQ handlers have been 
> installed already prior to disabling them, or is this more of a 
> machine-specific oddity wherein the IRQ handlers need to be setup earlier 
> (I don't even know if this is even possible/relevant to O2 systems)?
> 
> It also seems this was affecting AMD Alchemy-based systems too.  Other SGI 
> machines are known to work fine, except Indy and Indigo2, as I haven't 
> tested those yet.

IP27 is fine but it's SMP but I've already cleaned out all the early
calls to smp_call_function there were shown by the WARN() ages ago.

You can do it the same way, use this debugging version of on_each_cpu:

#define on_each_cpu(func,info,retry,wait)       \
        ({                                      \
		WARN_ON(irqs_disabled());	\
                func(info);                     \
                0;                              \
        })

  Ralf
