Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 17:57:38 +0100 (BST)
Received: from web13305.mail.yahoo.com ([IPv6:::ffff:216.136.175.41]:63503
	"HELO web13305.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225780AbUERQ50>; Tue, 18 May 2004 17:57:26 +0100
Message-ID: <20040518165723.31435.qmail@web13305.mail.yahoo.com>
Received: from [12.33.232.234] by web13305.mail.yahoo.com via HTTP; Tue, 18 May 2004 09:57:23 PDT
Date: Tue, 18 May 2004 09:57:23 -0700 (PDT)
From: Ken Giusti <manwithastinkydog@yahoo.com>
Subject: Re: running 2.6 on swarm pass1
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040518001638.GA10423@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <manwithastinkydog@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manwithastinkydog@yahoo.com
Precedence: bulk
X-list: linux-mips


Thanks for the info.  I'll try to free up some time
to dig into that crash, if possible.

My debug skills are nothing to brag about....

-K


--- Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, May 17, 2004 at 08:06:31AM -0700, Ken Giusti
> wrote:
> 
> > 2.6.6 from kernel.org doesn't appear to run at
> all.
> > Once I load the image via CFE and type "go" I get
> > absolutely no console output - the system just
> hangs.
> 
> There is still plenty of code that needs to be
> merged into the kernel.org
> tree before this will have a chance of working.  For
> any MIPS system.
> 
> > 2.6.5 from linux-mips is a bit better - I get
> bootup
> > console output, then an immediate crash (included
> > below).
> > 
> > Has anyone had any luck getting 2.6 running on
> swarm
> > with pass1?  
> 
> I still do have a pass1 board he so I'll eventually
> look at it.  However
> this doesn't look like the fingerprint of the usual
> pass1 crashes so it's
> probably simply a genuine kernel bug.
> 
>   Ralf



	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
