Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08Kq3a26870
	for linux-mips-outgoing; Tue, 8 Jan 2002 12:52:03 -0800
Received: from river-bank.demon.co.uk (river-bank.demon.co.uk [193.237.18.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08Kppg26840
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 12:51:51 -0800
Received: from river-bank.demon.co.uk(ratty.river-bank.demon.co.uk[192.168.0.4]) (3242 bytes) by river-bank.demon.co.uk
	via smtpd with P:smtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <phil@river-bank.demon.co.uk>) 
	id <m16O2II-000Sg9C@river-bank.demon.co.uk>
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 19:52:22 +0000 (GMT)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2001-Jan-12)
Message-ID: <3C3B4D1E.2E0C1DDD@river-bank.demon.co.uk>
Date: Tue, 08 Jan 2002 19:48:46 +0000
From: Phil Thompson <phil@river-bank.demon.co.uk>
Organization: At Home
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: linux-mips@oss.sgi.com
Subject: Re: How to Handle PCI Bridge Buffers?
References: <3C39EE20.57513318@river-bank.demon.co.uk> <15418.54280.707286.147408@gladsmuir.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dominic Sweetman wrote:
> 
> Phil,
> 
> > I am working with some hardware that has a "feature" that I'd like some
> > advice on how to handle. The PCI bridge has a read-ahead buffer between
> > the PCI bus and system memory - used by PCI bus masters. The buffer can
> > only be invalidated from software.
> 
> So it also acts as a cache.  Interesting.
> 
> > An example of the problem it causes is an ethernet device is kicked off
> > to go through its ring buffers. The first one has a flag saying there is
> > no data, so it stops. The kernel then puts data in the buffer, toggles
> > the flag, and kicks off the ethernet device again. The old value of the
> > flag is still in the read-ahead buffer so the device stops again. The
> > fix is obviously to invalidate the read-ahead buffer before kicking off
> > the device. The question is, how to do this in a generic way?
> 
> This is analogous to the problem you get when accessing device buffers
> through the MIPS cache; so we know there's no easy fix.  You'll have
> to locate every write made to a shared memory structure, and then
> invalidate the cache in the bridge.  If you're mapping the shared
> memory cached, that would be just after doing a forced write-back of
> the CPU cache... but the shared memory is more likely accessed
> uncached.
> 
> But as a result of the MIPS cache experience there are a collection of
> cache-safety buffer functions (rely on a proper Linux expert to tell
> you about them, sorry).  So you can update your driver to call them,
> then change your local implementation of the functions to invalidate
> the bridge's cache too.  You still have to change all the
> non-compliant drivers, of course, but at least you have the warm
> feeling that you're *improving* them.
> 
> [Just a note: I suppose you've checked you're not accidentally working
>  through a "writeback" CPU cache, which would cause the identical
>  symptom?  This feature would cause such routine trouble
>  in a bridge that I'm surprised it isn't at least easy to disable...]

It's definately in the bridge.

> > I don't want to modify the driver for every PCI device that might be
> > used. The only other way seems to be to add the buffer invalidation code
> > to outb() etc. (and hope that no driver wants to use memory mapped
> > registers).
> 
> But lots of drivers use memory mapped registers.  x86 I/O space
> (inb/outb etc) maps to PCI I/O space, the use of which is deprecated
> except for legacy software.

Oh dear!

Phil
