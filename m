Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:00:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:13553 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225201AbTDVXAS>;
	Wed, 23 Apr 2003 00:00:18 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA07576;
	Tue, 22 Apr 2003 16:00:11 -0700
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030422155625.E28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab>
	 <20030422155625.E28544@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051052439.2552.352.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2003 16:00:39 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-04-22 at 15:56, Jun Sun wrote:
> I think this is a good example to show benefit of code sharing.
> There is no good reason for au1x00 boards of not using new time.c.
> You get to write less board code, fewer bugs and future proof.

The I didn't use the generic time.c back then is power management. The
CP0 counter sleeps when using the 'wait' instruction, so in that case
you have to use a different counter with a rather poor resolution. The
modifications I had to make were such that they couldn't go in the
generic time.c. But that area definitely needs to be revisited and
cleaned up.

Pete

> Jun
> 
> On Tue, Apr 22, 2003 at 12:54:50PM -0700, Jeff Baitis wrote:
> > Pete:
> > 
> > While struggling to get Linux up on Evolution's custom board based on the
> > Au1500, I discovered a poorly handled case in time.c; null interrupts are
> > handled should not affect the local IRQ count. (if the local IRQ count is not
> > decremented, tests for in_irq() fail.)
> > 
> > Thanks for taking a look at my patch!
> > 
> > -Jeff
> > 
> > Index: time.c
> > ===================================================================
> > RCS file: /home/cvs/linux/arch/mips/au1000/common/time.c,v
> > retrieving revision 1.5.2.10
> > diff -u -r1.5.2.10 time.c
> > --- time.c      25 Mar 2003 14:30:19 -0000      1.5.2.10
> > +++ time.c      22 Apr 2003 19:47:24 -0000
> > @@ -114,6 +114,7 @@
> >         return;
> >  
> >  null:
> > +       irq_exit(cpu, irq);
> >         ack_r4ktimer(0);
> >  }
> > 
> > 
> 
> 
