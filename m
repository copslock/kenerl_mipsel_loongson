Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:32:26 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:53927 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493393Ab1AQLb7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 12:31:59 +0100
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=laptop)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PenIK-0004DN-Su; Mon, 17 Jan 2011 11:30:44 +0000
Received: by laptop (Postfix, from userid 1000)
        id 73A0610067258; Mon, 17 Jan 2011 12:31:25 +0100 (CET)
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
From:   Peter Zijlstra <peterz@infradead.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
In-Reply-To: <20110117112637.GA18599@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop>
         <20110117112637.GA18599@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Mon, 17 Jan 2011 12:31:24 +0100
Message-ID: <1295263884.30950.54.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 11:26 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 17, 2011 at 12:07:13PM +0100, Peter Zijlstra wrote:
> > diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> > index 42aa078..c4a570b 100644
> > --- a/arch/alpha/kernel/smp.c
> > +++ b/arch/alpha/kernel/smp.c
> > @@ -587,6 +587,7 @@ handle_ipi(struct pt_regs *regs)
> >  		case IPI_RESCHEDULE:
> >  			/* Reschedule callback.  Everything to be done
> >  			   is done by the interrupt return path.  */
> > +			scheduler_ipi();
> >  			break;
> >  
> >  		case IPI_CALL_FUNC:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 9066473..ffde790 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -579,6 +579,7 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
> >  				 * nothing more to do - eveything is
> >  				 * done on the interrupt return path
> >  				 */
> > +				scheduler_ipi();
> 
> Maybe remove the comment "everything is done on the interrupt return path"
> as with this function call, that is no longer the case.
> 
> Looks like the same is true for Alpha as well?

Right, will do, thanks! It looks like I've somewhat inconsistent with
that.
