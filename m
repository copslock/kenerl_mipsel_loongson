Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:58:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8895 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20034920AbXLLS6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:58:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBCIvRTA026507;
	Wed, 12 Dec 2007 18:57:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBCIvQmX026506;
	Wed, 12 Dec 2007 18:57:26 GMT
Date:	Wed, 12 Dec 2007 18:57:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: questions on struct sigcontext
Message-ID: <20071212185726.GA26190@linux-mips.org>
References: <47601DEE.4090200@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47601DEE.4090200@nortel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 11:44:14AM -0600, Chris Friesen wrote:

> First, I'm not subscribed to the list so I'd appreciate being cc'd on any 
> replies.
>
> We have a project getting started with MIPS, and one of the things that 
> we're trying to bring in is some exception-handling code that logs various 
> information about the ways that apps fail.
>
> In particular, the guys working on this have asked for the STATUS, CAUSE, 
> BADVADDR, and FPC_EIR registers to be made available as part of struct 
> sigcontext so that they can determine exactly why the app is failing.

The status register doesn't provide useful information about application
problems since it almost exclusivly affects kernel level operation.  So
its not exported to userspace.

Cause I agree could occasionally be interesting.  Historically the
Linux/MIPS stackframe is derived from the IRIX stackframe.  But Linux/MIPS
did never populate the sc_cause field - no debugger or anything was using it.
So eventually the field got recycled for the DSP ASE.  The hard part here
is finding place in the stackframe without breaking compatibility - and
there are other users competing ...

C0_badvaddr is available in the si_addr field of struct siginfo.

The FIR register is the "FP Implementation and Revision register" which is
read-only so the same for all processes. A debugger can access it at any
time and there is no need to waste space in the stack frame on it.

> Looking at include/asm-mips/sigcontext.h I can see that these registers 
> appear to be in the struct, but are either marked as "unused" or now have 
> different names.
>
> Am I correct that these registers are not currently exported to userspace 
> on a fault?  If this is the case, why not?  Does anyone have a patch to 
> enable this export?

Be very, very, very careful if you're changing struct siginfo.  Applications
know about it.  Iow if you change it the wrong way you break binary or
even source compatibility and usually that's in very subtle ways.

(Honestly, I hate our stackframe, especially the 32-bit one which is hell
of overbloated.  I *wish* I could just scrap it but its one of those holy
cows - and I don't feel carnivorous enough yet to butcher it ;-)

  Ralf
