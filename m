Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 13:22:56 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:48403 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133531AbWBBNWj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 13:22:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12DQxkm014261;
	Thu, 2 Feb 2006 13:26:59 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12DQwhZ014260;
	Thu, 2 Feb 2006 13:26:58 GMT
Date:	Thu, 2 Feb 2006 13:26:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Michael Uhler <uhler@mips.com>,
	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	"'Johannes Stezenbach'" <js@linuxtv.org>, linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Message-ID: <20060202132658.GC4986@linux-mips.org>
References: <20060201164423.GA4891@nevyn.them.org> <005901c62754$b414dc80$bb14a8c0@MIPS.COM> <20060201192404.GA11719@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201192404.GA11719@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 02:24:04PM -0500, Daniel Jacobowitz wrote:

> > The O/S maybe doing something different, but the architecture has 3 bits in
> > Status: KX, SX, and UX that enable access to the address space above 32
> > bits.  With these bits off, an attempt to access these addresses causes an
> > exception.  So while 32-bit apps have the full 64-bit address space, most of
> > it is inaccessible to the 32-bit app.
> 
> That's not actually what I was referring to: there's at least one MIPS
> implementation where the results of 32-bit arithmetic operations are
> not just architecturally unpredictable but actually wrong if the upper
> bits are not properly sign extended (I might be misremembering, but I
> think I'm talking about the SB-1).  That's the sort of thing that can
> be basically impossible to track down if your debugger doesn't show
> you the whole register.

You were right, that was the SB1 core of the BCM1250 on your Sentosa.  The
behaviour however is legal; the MIPS64 specification states for almost all
32-bit arithmetic instructions that their proper operation is only
guaranteed for properly 64-bit sign-extended operands.

  Ralf
