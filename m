Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 00:36:30 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:6637 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225324AbUBEAg3>;
	Thu, 5 Feb 2004 00:36:29 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i150aQOI022184;
	Wed, 4 Feb 2004 16:36:26 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i150aOBe029052;
	Wed, 4 Feb 2004 16:36:24 -0800 (PST)
Date: Wed, 4 Feb 2004 16:36:24 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Shaun Savage <savages@savages.net>
cc: Prashant Viswanathan <vprashant@echelon.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: loading kernel via EJTAG interface
In-Reply-To: <40218B29.8010803@savages.net>
Message-ID: <Pine.LNX.4.44.0402041630070.7920-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

> > I am trying to load a linux kernel through a EJTAG device. I was told
> > that I should modify the kernel so that it doesnt attempt to use the
> > parameters passed to it by the loader. However, I am not quite sure as
> > to what it means and what exactly one has to do. I would really
> > appreciate any pointers/help/suggestions.
	One approach is to create some sort of setup script that 
"emulates" the boot loader. I've done that for a Malta board (which uses a 
boot loader called YAMON). Basically it does something like this:

	reset and run the board
	sleep for 7 seconds to let YAMON do its normal setup
	halt the board
	do all the setup that YAMON would do when it runs a program

That last step is where the magic happens. Basically I do things like
setup various registers to point to memory regions, and then in those
regions create arrays of pointers, which point to strings containing
things like the "environment" that YAMON fills in for programs and
arguments that it passes. Depending on the capabilities of your debugging
environment this can either be easy or hard. My setup is really nice,
downloads for small kernels take about the same time as going through
tftp, but bigger kernels with a ramdisk are actually faster to push
through EJTAG, which is nice :)

	nathan

> > 
> > Thanks!
> > Prashant
> > 
> > 
> Ouch!  The best way would be to load a bootloader that knows about bootp 
> and TFTP. Then do a network boot.
> 
> If you dont't have a ethernet connection on the board then in 
> /arch/mips/kernel/head.S is where the loader  info is read into the kernel.
> 
> But I am sure there is a better way.
> 
> shaun
> 
> 
> 
> 

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
