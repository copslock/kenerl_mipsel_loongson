Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 15:44:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7066 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365601AbZCDPof (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 15:44:35 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n24FiQlo019538;
	Wed, 4 Mar 2009 15:44:26 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n24FiIYL019535;
	Wed, 4 Mar 2009 15:44:18 GMT
Date:	Wed, 4 Mar 2009 15:44:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090304154418.GA13464@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200903040919.29294.brian.foster@innova-card.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:

> On Tuesday 03 March 2009 17:56:25 David Daney wrote:
> >[ ... ]
> > When (and if) we move the sigreturn trampoline to a vdso we should be
> > able to maintain the ABI.
> 
>  it's more a matter of “when” rather than “if”.
>  there is still an intention here to use XI (we
>  have SmartMIPS), which requires not using the
>  signal (or FP) trampoline on the stack.
> 
>  moving the signal trampoline to a vdso (which
>  is(? was?) called, maybe misleadingly, ‘vsyscall’,
>  on other architectures) is the obvious solution to
>  that part of the puzzle.  and yes, it is possible
>  to maintain the ABI; the signal trampoline is still
>  also put on the stack, and modulo XI, would work if
>  used — the trampoline-on-stack is simply not used
>  if there is a vdso with the signal trampoline.

We generally want to get rid of stack trampolines.  Trampolines require
cacheflushing which especially on SMP systems can be a rather expensive
operation.

  Ralf
