Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 21:31:05 +0000 (GMT)
Received: from GS256.SP.CS.CMU.EDU ([IPv6:::ffff:128.2.199.27]:22450 "HELO
	gs256.sp.cs.cmu.edu") by linux-mips.org with SMTP
	id <S8225196AbTA1VbF>; Tue, 28 Jan 2003 21:31:05 +0000
Subject: [OT] Re: unaligned load in branch delay slot
From: justinca@cs.cmu.edu
To: linux-mips@linux-mips.org
In-Reply-To: <200301281948.h0SJmug29073@uhler-linux.mips.com>
References: <200301281948.h0SJmug29073@uhler-linux.mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043789409.23571.12.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 16:30:09 -0500
Source-Info: Sender is really justinca+@gs256.sp.cs.cmu.edu
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips

On Tue, 2003-01-28 at 14:48, Mike Uhler wrote:

> If the patch assumes that one can look backward by one instruction
> in the STATIC code to determine if the instruction is in a
> delay slot, one can not have code that jumps directly to the
> instruction following another branch, as this would cause the
> code to assume that it was in the delay slot of the branch.

A while back, when working on a different architecture that also had
branch delay slots, it took me a while to get my head around the
branch-in-a-delay-slot case, e.g.


10:  b 100
20:  b 30
30:  foo
...
100: bar

where the actual program flow would be

10
20
100
30

and instruction 100 would be considered to be in the delay slot of 20.

I was *very* happy when I first looked at MIPS to see that this was 
specified as unpredictable, even if it was pretty cool to be able to
make the CPU execute a single instruction in the middle of nowhere. 
Pointless, but cool.  :)

-Justin
