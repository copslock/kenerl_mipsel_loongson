Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 01:17:04 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:48371 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIQXRD>;
	Wed, 18 Sep 2002 01:17:03 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8HN4Pj23401;
	Tue, 17 Sep 2002 16:04:25 -0700
Date: Tue, 17 Sep 2002 16:04:25 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [jsun@mvista.com: Re: [RFC] FPU context switch]
Message-ID: <20020917160425.O17321@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Meant to send to the list ....

----- Forwarded message from Jun Sun <jsun@mvista.com> -----

X-Sieve: cmu-sieve 2.0
Date: Tue, 17 Sep 2002 16:02:26 -0700
From: Jun Sun <jsun@mvista.com>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: jsun@mvista.com
Subject: Re: [RFC] FPU context switch
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020917155854.B1883@wumpus.attbi.com>; from lindahl@keyresearch.com on Tue, Sep 17, 2002 at 03:58:54PM -0700

On Tue, Sep 17, 2002 at 03:58:54PM -0700, Greg Lindahl wrote:
> On Wed, Sep 18, 2002 at 12:30:23AM +0200, Kevin D. Kissell wrote:
> 
> > I'm extremely skeptical about this "evidence".
> 
> The only good test is Linux with and without lazy saves. Throwing in a
> new OS complicates matters. It sounds like Jun already has working
> code for (1) and (3), so he can do a good test.
>

I actually have 2) and 3).  1) is easy to do, though.  

Anyone can recommand some test programs to try?

A while back, I tried lmbench which is not very telling.
I think the reason is that most of the tests are not using
FPU at all.

However I might try it again anyway.  It might tell the
difference between 1) and 2)&3) easily.

Jun

----- End forwarded message -----
