Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 21:38:33 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:28424 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122987AbSIQTid>;
	Tue, 17 Sep 2002 21:38:33 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17rP6y-0004Lw-00; Tue, 17 Sep 2002 15:38:20 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17rOAu-0007M8-00; Tue, 17 Sep 2002 15:38:20 -0400
Date: Tue, 17 Sep 2002 15:38:20 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917193820.GA28255@nevyn.them.org>
References: <20020917110423.E17321@mvista.com> <1032288140.28433.165.camel@gs256.sp.cs.cmu.edu> <20020917114831.G17321@mvista.com> <20020917120310.A2043@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917120310.A2043@wumpus.internal.keyresearch.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 12:03:10PM -0700, Greg Lindahl wrote:
> On Tue, Sep 17, 2002 at 11:48:31AM -0700, Jun Sun wrote:
> 
> > I think this gives a big performance improvement because most processes
> > don't use FPU during their runs but they all have used_math flag set!
> 
> Jun,
> 
> You really ought to prove that first. Many people spend a lot of time
> optimizing things that aren't important. If it isn't important, than
> the simplest scheme is the best choice.

Oh, he's quite correct.  There's a setjmp() early in the execution
path, and it saves FP registers on machines with FP support configured
on.  So tasks are marked as FPU users.

I've never thought of a terribly good way around this.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
