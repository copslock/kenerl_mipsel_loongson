Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 19:19:20 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:479 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S3458570AbWBATTC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 19:19:02 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1F4NaG-00033X-MM; Wed, 01 Feb 2006 14:24:04 -0500
Date:	Wed, 1 Feb 2006 14:24:04 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Michael Uhler <uhler@mips.com>
Cc:	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	'Johannes Stezenbach' <js@linuxtv.org>,
	linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Message-ID: <20060201192404.GA11719@nevyn.them.org>
References: <20060201164423.GA4891@nevyn.them.org> <005901c62754$b414dc80$bb14a8c0@MIPS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005901c62754$b414dc80$bb14a8c0@MIPS.COM>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 09:26:57AM -0800, Michael Uhler wrote:
> Daniel,
> 
> The O/S maybe doing something different, but the architecture has 3 bits in
> Status: KX, SX, and UX that enable access to the address space above 32
> bits.  With these bits off, an attempt to access these addresses causes an
> exception.  So while 32-bit apps have the full 64-bit address space, most of
> it is inaccessible to the 32-bit app.

That's not actually what I was referring to: there's at least one MIPS
implementation where the results of 32-bit arithmetic operations are
not just architecturally unpredictable but actually wrong if the upper
bits are not properly sign extended (I might be misremembering, but I
think I'm talking about the SB-1).  That's the sort of thing that can
be basically impossible to track down if your debugger doesn't show
you the whole register.

-- 
Daniel Jacobowitz
CodeSourcery
