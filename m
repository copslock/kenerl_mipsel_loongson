Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2011 10:36:52 +0100 (CET)
Received: from bombadil.infradead.org ([18.85.46.34]:39568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1BIJgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Feb 2011 10:36:48 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
        by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
        id 1Pn6Tc-0005eU-I7
        for linux-mips@linux-mips.org; Wed, 09 Feb 2011 09:36:45 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
        by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1Pn6Ta-0000uw-1p
        for linux-mips@linux-mips.org; Wed, 09 Feb 2011 09:36:42 +0000
Received: by dyad.programming.kicks-ass.net (Postfix, from userid 65534)
        id 2027524256; Wed,  9 Feb 2011 10:39:56 +0100 (CET)
Received: from [IPv6:::1] (dyad [192.168.0.60])
        by dyad.programming.kicks-ass.net (Postfix) with ESMTP id EDEF72424A;
        Wed,  9 Feb 2011 10:39:31 +0100 (CET)
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
In-Reply-To: <1297232054.14982.346.camel@pasglop>
References: <1295262433.30950.53.camel@laptop>
         <1297034792.14982.10.camel@pasglop>  <1297086859.13327.16.camel@laptop>
         <1297232054.14982.346.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 09 Feb 2011 10:37:24 +0100
Message-ID: <1297244244.13327.147.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 2011-02-09 at 17:14 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 14:54 +0100, Peter Zijlstra wrote:
> > On Mon, 2011-02-07 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> > > You missed:
> > > 
> > > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > > index 9813605..467d122 100644
> > > --- a/arch/powerpc/kernel/smp.c
> > > +++ b/arch/powerpc/kernel/smp.c
> > > @@ -98,6 +98,7 @@ void smp_message_recv(int msg)
> > >                 break;
> > >         case PPC_MSG_RESCHEDULE:
> > >                 /* we notice need_resched on exit */
> > > +               scheduler_ipi();
> > >                 break;
> > >         case PPC_MSG_CALL_FUNC_SINGLE:
> > >                 generic_smp_call_function_single_interrupt();
> > > 
> > > Fold that in and add:
> > > 
> > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Thanks Ben!
> 
> BTW. I we lurking at some of our CPU hotplug code and I think I cannot
> totally guarantee that this won't be called on an offline CPU. If that's
> a problem, you may want to add a test for that.
> 
> IE. The call function IPIs are normally not going to be sent to an
> offlined CPU, and stop_machine should be a good enough fence here, but
> we do abuse reschedule for a number of things (including in some case
> to wake up a sleeping CPU that was pseudo-offlined :-)

Hmm, I _think_ that should all work out nicely, but we'll see, if when
this stuff hits the tree powerpc machines start falling over we'd better
put that check in ;-)

Meanwhile I'm going to preserve this comment in the changelog of this
patch so we don't forget.
