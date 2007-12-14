Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 16:26:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:41880 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030442AbXLNQ0l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 16:26:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBEGQT9a006511;
	Fri, 14 Dec 2007 16:26:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBEGQTvT006510;
	Fri, 14 Dec 2007 16:26:29 GMT
Date:	Fri, 14 Dec 2007 16:26:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mikael Starvik <mikael.starvik@axis.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: GCC 3.4.5 and mftc0
Message-ID: <20071214162629.GC30137@linux-mips.org>
References: <BFECAF9E178F144FAEF2BF4CE739C6680557B0DB@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C6680557B0DB@exmail1.se.axis.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 14, 2007 at 10:49:40AM +0100, Mikael Starvik wrote:

> mftc0() is implemented as
>  
>  .word ...
>   move %0, $1
> 
> With at least gcc 3.4.5 the move is implemented as an addu %0, $1, $0.
> But in the MIPS sumulator this fails and %0 gets the value 0xffffffff.
> Implementing this as a or %0, $1, $0 instead gives the expected result.

I wonder what "sumulator" you're using ...

Addu is a perfectly fine implementation of move for 32-bit code.  It's not
for 64-bit code but that's beside the point here.  The or method is also
correct but historically the add instruction has been prefered, also
because some processor - the R4300 afair - processes arithmetic instructions
(add, sub that is not mul / div) faster than logic operations.

> Any suggestions where the problem is and what the correct solution is?

Fix the sumulator.

> After fixing this my next problem is that IPIs doesn't reach all TCs
> correctly (it seams like the code doesn't detect IXMT status correctly,
> but I am still investigating). It is likely that it is caused by
> something similar to the problem above.

The code certainly works on real silicon, so the cause must be something
local to your environment.

Cheers,

  Ralf
