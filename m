Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR4Bpn05324
	for linux-mips-outgoing; Mon, 26 Nov 2001 20:11:51 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAR4Blo05316
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 20:11:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAR1DbJ26525;
	Tue, 27 Nov 2001 12:13:37 +1100
Date: Tue, 27 Nov 2001 12:13:37 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: Report the faulting FPU instruction
Message-ID: <20011127121337.E2525@dea.linux-mips.net>
References: <Pine.GSO.3.96.1011126160822.21598N-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011126160822.21598N-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Nov 26, 2001 at 04:28:34PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 04:28:34PM +0100, Maciej W. Rozycki wrote:

>  I believe it's desireable to point to the faulting instruction upon an
> FPU trap and not the following one.  Why?  First, the FPU restores the
> state from before attempting to exectute the instruction.  Second, with
> the current approach state is lost -- consider instructions in branch/jump
> delay slots.  Third, erroneous execution is possible if SIG_FPE's handler
> is set to "ignore" by mistake.
> 
>  The following patch implements the described approach.  It should not
> affect standard handlers which use setjmp()/longjmp(), but it should
> enable a smarter interpreting handler or just better diagnostics.  Both
> the hardware and the emulator are handled.  Tested successfully with gdb
> on an R3k, an R4k and the emulator. 

The problem you found in the FPU emulator is a fairly generic one.  We
got other exception handlers which in error case will still skip over
the instruction.  What also isn't handled properly is the case of sending
a signal to the application.  In such a case sigreturn() should do the
the compute_return_epc() thing ...

  Ralf
