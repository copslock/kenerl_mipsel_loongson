Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 14:39:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38835 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20032374AbZDBNjC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 14:39:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n32Dcv6B015553;
	Thu, 2 Apr 2009 15:38:57 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n32Dctps015551;
	Thu, 2 Apr 2009 15:38:55 +0200
Date:	Thu, 2 Apr 2009 15:38:55 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	Brian Foster <brian.foster@innova-card.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090402133855.GC15021@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304154418.GA13464@linux-mips.org> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 04, 2009 at 05:25:35PM -0500, David VomLehn (dvomlehn) wrote:

> > >  it's more a matter of "when" rather than "if".
> > >  there is still an intention here to use XI (we
> > >  have SmartMIPS), which requires not using the
> > >  signal (or FP) trampoline on the stack.
> > > 
> > >  moving the signal trampoline to a vdso (which
> > >  is(? was?) called, maybe misleadingly, 'vsyscall',
> > >  on other architectures) is the obvious solution to
> > >  that part of the puzzle.  and yes, it is possible
> > >  to maintain the ABI; the signal trampoline is still
> > >  also put on the stack, and modulo XI, would work if
> > >  used - the trampoline-on-stack is simply not used
> > >  if there is a vdso with the signal trampoline.
> > 
> > We generally want to get rid of stack trampolines.  
> > Trampolines require
> > cacheflushing which especially on SMP systems can be a rather 
> > expensive
> > operation.
> 
> If I understand this correctly, using a vdso would allow a stack without
> execute permission on those processors that differentiate between read
> and execute permission. This defeats attaches that use buffer overrun to
> write code to be executed onto the stack, a nice thing for more secure
> systems.

The good news is that many of these stack buffer overruns don't work on
MIPS anyway due to the somewhat unusual stack frame.  Don't rely on that
too much for security though - like 10 years ago Phrack published an
article under the title "Smashing the stack for fun and profit" explaining
how to write exploits for IRIX 5 which als was using o32.

  Ralf
