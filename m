Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 18:37:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27886 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225229AbTGaRhw>;
	Thu, 31 Jul 2003 18:37:52 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6VHboK06262;
	Thu, 31 Jul 2003 10:37:50 -0700
Date: Thu, 31 Jul 2003 10:37:50 -0700
From: Jun Sun <jsun@mvista.com>
To: Chris Dearman <chris@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Malta + USB on 2.4, anyone?
Message-ID: <20030731103750.E14914@mvista.com>
References: <20030730191219.A14914@mvista.com> <3F28E702.70401@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F28E702.70401@mips.com>; from chris@mips.com on Thu, Jul 31, 2003 at 10:53:06AM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2003 at 10:53:06AM +0100, Chris Dearman wrote:
> Jun Sun wrote:
> > Has anybody tried USB on malta with 2.4 kernel?  I just found that
> > I got 0xff IRQ number and kernel panics.
> 
> > Also, the kgdb seems to be flaky.  Targets can send chars too fast
> > so that chars get lost.  It appears that the linux status register
> > might be lying about "transmitter buffer empty".  
> 
>    I regularly use gdb @ 115200 on Malta and haven't noticed any problems.
>

Yes.  I notice that kgdb generally works, but gets flaky when I hit
this particular problem.  That makes me wonder maybe something gets
very wrong with the controller chip....

Keep debugging ...

Jun
