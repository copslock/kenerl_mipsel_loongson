Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 13:53:13 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:34288 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023669AbYFHMxK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Jun 2008 13:53:10 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m58Cr778021068;
	Sun, 8 Jun 2008 14:53:07 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m58Cr66i021064;
	Sun, 8 Jun 2008 13:53:06 +0100
Date:	Sun, 8 Jun 2008 13:53:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Luke -Jr <luke@dashjr.org>
cc:	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
In-Reply-To: <200806072332.06460.luke@dashjr.org>
Message-ID: <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl>
References: <200806072113.26433.luke@dashjr.org>
 <Pine.LNX.4.55.0806080342310.15673@cliff.in.clinika.pl> <200806072332.06460.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 7 Jun 2008, Luke -Jr wrote:

> Well, I always imagined memory layout as being a simple flat range from 0 to 
> all_memory_in_system, but this is my first experience with it at such a low 
> level, so I guess I don't know what's "odd" or "normal".

 You mean the layout of virtual memory?  Well, have a look at what the
Alpha defines as sparse memory for something certainly less
straightforward than what MIPS segments are.  Anyway, what's reported here
is physical memory and there is nothing special about it.

> VxWorks, including the boot loader, is not CFE as far as I am aware. If you're 
> referring to the "CFEv2" in the log, that appears to be the default of a 
> switch (eg, if Linux doesn't detect anything else).

 That message is not included in the standard kernel -- how can I know it
is meaningless?  As I wrote CFE is standard Broadcom firmware.

> The calibration code was crashing, so I set it to a fixed 1 value.
> Worst case, some code won't delay as long as it wants to, right?

 That's grossly wrong.  If you need to preset it for the time being till
you debug calibration, then for a MIPS processor assume one instruction
per clock tick and two instructions per loop -- that may not be entirely
correct, but is a good approximation.  Otherwise you risk peripheral
devices are not driven correctly with all sorts of the nasty results.

> >  You have got something seriously broken -- __bzero traps exceptions on
> > stores for graceful recovery as user addresses may be accessed as is the
> > case here.  If the reserved instruction exception handler is reached, then
> > clearly the store instruction is not the immediate cause.
> 
> What else could it be?

 Well, you've got the system and I have no crystal ball.  You have means
to debug it.  See how control is passed to the RI exception.  Find which 
of the TLB exceptions happens and how it proceeds.  Etc...

  Maciej
