Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4LGxXnC003717
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 21 May 2002 09:59:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4LGxX5D003716
	for linux-mips-outgoing; Tue, 21 May 2002 09:59:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4LGxUnC003708
	for <linux-mips@oss.sgi.com>; Tue, 21 May 2002 09:59:30 -0700
Received: (qmail 19387 invoked from network); 21 May 2002 17:00:23 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 21 May 2002 17:00:23 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g4LH0eA02119
	for linux-mips@oss.sgi.com; Tue, 21 May 2002 10:00:40 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 21 May 2002 10:00:40 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020521100040.A2103@wumpus.internal.keyresearch.com>
Mail-Followup-To: Linux-MIPS <linux-mips@oss.sgi.com>
References: <20020519123059.E20670@dea.linux-mips.net> <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl> <20020520085743.A1748@wumpus.keyresearch.com> <20020521164730.GC11618@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020521164730.GC11618@paradigm.rfc822.org>; from flo@rfc822.org on Tue, May 21, 2002 at 06:47:30PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 21, 2002 at 06:47:30PM +0200, Florian Lohoff wrote:
> On Mon, May 20, 2002 at 08:57:44AM -0700, Greg Lindahl wrote:
> > On Mon, May 20, 2002 at 12:06:45PM +0200, Maciej W. Rozycki wrote:
> > 
> > >  Well, the surprise is going to happen in drivers, I'm afraid...
> > 
> > Linux drivers as a whole are 64-bit clean; alpha's been around for a
> > long time. MIPS-only devices might be dirtier.
> 
> Not really true - I just stumbled over the cyclades multiport driver
> which says to work on alpha for a long time - But it doesnt on
> Sparc64 due to the porters misunderstanding on typedefs for the 
> driver internals. (Alpha and i386 are happy with char irqs e.g.).

I must say I find this entire discussion bewildering: one example does
not mean that Linux drivers are not "as a whole" 64-bit clean.

Another poster thought that things like ISA and Turbochannel devices
were a counter-example. Well, no.

greg
