Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA17557 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 16:34:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA19600 for linux-list; Wed, 14 Jan 1998 16:31:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA19591 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:31:32 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA04111
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:31:29 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA05417
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 01:31:27 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA05839;
	Thu, 15 Jan 1998 01:26:23 +0100
Message-ID: <19980115012622.51359@uni-koblenz.de>
Date: Thu, 15 Jan 1998 01:26:22 +0100
To: William Ellis <bellis@cerf.net>
Cc: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: boot problem
References: <34BD4F3E.7F86@cerf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <34BD4F3E.7F86@cerf.net>; from William Ellis on Wed, Jan 14, 1998 at 03:50:22PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 03:50:22PM -0800, William Ellis wrote:

> I'm working with a Challenge S, R5000 (Allegedly the same
> hardware as an Indy without a graphics card)
> 
> Initially booting via tftp with various errors, I am
> now trying to just get the sash boot -f to work.
> I have tried several of the applicable precompiled kernels 
> at ftp.linux.sgi.com/pub/test all with similar errors:
> 
> Standalone Shell SGI Version 6.2 ARCS   Mar  9, 1996 (32 Bit)
> sash: boot -f /vmlinux root=/dev/sda1
> 1278928+236160 entry: 0x8800250c
> newport_probe: read back wrong value ;-(
> 
> What is the newport_probe?  The only non-stock thing about
> the machine is it has a fddi card in it, (which I do not
> need to get going for linux).  Could this error be an effect
> of the fddi card being present, or that there is no graphics
> card present?  Or am I missing something else all together?

No, the FDDI card is just being ignored by Linux.  The problem is
indeed the fact that the newport GFX card isn't installed.  I'll
take a look at it when I have time for more than one breath
per minute ...

Thinking about it, the kernel should only try to touch the gfx hardware
at all, if the ARC environment variable ``console'' is unset.  If you
want to run from a serial console, then the variable's value should be
either ``d1'' or ``d2'' for the first rsp. second serial interface.
I suppose IRIX just defaults to serial console because it knows that
a Challenge S is headless or after a failed probe for gfx hardware.

William, what is the recommended way to recognice whethere a machine
is a Indy or Challenge S?  Probing for a GFX card or checking via
ARC firmware?

  Ralf
