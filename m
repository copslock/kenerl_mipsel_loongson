Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 17:45:34 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:54179
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225299AbTA1Rpd>; Tue, 28 Jan 2003 17:45:33 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0SHjTR30369;
	Tue, 28 Jan 2003 18:45:29 +0100
Date: Tue, 28 Jan 2003 18:45:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: when does do_fpe() get called? (or when does FPE happen?)
Message-ID: <20030128184529.B29262@linux-mips.org>
References: <20030127190423.U11633@mvista.com> <20030128043744.A24686@linux-mips.org> <20030128093742.V11633@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030128093742.V11633@mvista.com>; from jsun@mvista.com on Tue, Jan 28, 2003 at 09:37:42AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 09:37:42AM -0800, Jun Sun wrote:

> > > Can someone enlighten me a little?  I am trying
> > > to figure out what the FPU state should be (or can be) when
> > > we are inside do_fpe() routine.
> > 
> > Checkout the various flags in $fcr31.  Whenever one of the enabled
> > exceptions is triggered we get to handle_fpe via do_fpe.  In addition
> > the unimplemented exception can also result in invocation of do_fpe.
> >
> 
> So it seems safe to assume FPU should have been enabled when we get
> here, right?

Yes, otherwise we'd get a coprocessur unusable exception.

  Ralf
