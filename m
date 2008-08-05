Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 20:16:27 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:65431
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20033084AbYHETQV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 20:16:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m75JGKqa011206;
	Tue, 5 Aug 2008 20:16:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m75JGJfD011204;
	Tue, 5 Aug 2008 20:16:19 +0100
Date:	Tue, 5 Aug 2008 20:16:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
Message-ID: <20080805191618.GB8629@linux-mips.org>
References: <48989AFE.5000500@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48989AFE.5000500@nortel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 05, 2008 at 12:25:02PM -0600, Chris Friesen wrote:

> I've run into an interesting issue with an Octeon-based board, where it  
> just seems to hang.  I suspect we're hitting some kind of locking bug,  
> and I'm trying to track it down.  If it matters, the kernel is quite old  
> (heavily patched 2.6.14) and I've got no chance of upgrading it.  (The  
> usual embedded scenario.)
>
> I've added some scheduler instrumentation, as well as adding a stack  
> dump to the output of the softlockup code.
>
> In the trace below, is "epc" the program counter at the time of the  
> timer interrupt?  How does "ra" fit into this, given that the function  
> whose address it contains isn't seen in the stack trace until quite a  
> ways down?

$LBB378 is an internal symbol.  The value of RA may not be very informative
if it was overwritten by a random subroutine call.

> Any insights are greatly appreciated...

You may also try lockdep; it gives much more detailed information though
it's more heavyweight.

  Ralf
