Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 17:37:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22771 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225196AbTA1Rhr>;
	Tue, 28 Jan 2003 17:37:47 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0SHbhO26719;
	Tue, 28 Jan 2003 09:37:43 -0800
Date: Tue, 28 Jan 2003 09:37:42 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: when does do_fpe() get called? (or when does FPE happen?)
Message-ID: <20030128093742.V11633@mvista.com>
References: <20030127190423.U11633@mvista.com> <20030128043744.A24686@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030128043744.A24686@linux-mips.org>; from ralf@linux-mips.org on Tue, Jan 28, 2003 at 04:37:44AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 04:37:44AM +0100, Ralf Baechle wrote:
> On Mon, Jan 27, 2003 at 07:04:23PM -0800, Jun Sun wrote:
> 
> > Can someone enlighten me a little?  I am trying
> > to figure out what the FPU state should be (or can be) when
> > we are inside do_fpe() routine.
> 
> Checkout the various flags in $fcr31.  Whenever one of the enabled
> exceptions is triggered we get to handle_fpe via do_fpe.  In addition
> the unimplemented exception can also result in invocation of do_fpe.
>

So it seems safe to assume FPU should have been enabled when we get
here, right?

Jun
