Received:  by oss.sgi.com id <S42279AbQHIXau>;
	Wed, 9 Aug 2000 16:30:50 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41325 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42259AbQHIXaF>; Wed, 9 Aug 2000 16:30:05 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA01685
	for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 16:35:16 -0700 (PDT)
	mail_from (philloc@tigger.ccs.ornl.gov)
From:   philloc@tigger.ccs.ornl.gov
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA50004
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 9 Aug 2000 16:28:57 -0700 (PDT)
	mail_from (philloc@tigger.ccs.ornl.gov)
Received: from tigger.ccs.ornl.gov (tigger.ccs.ornl.gov [134.167.16.90]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06032
	for <linux@cthulhu.engr.sgi.com>; Wed, 9 Aug 2000 16:28:48 -0700 (PDT)
	mail_from (philloc@tigger.ccs.ornl.gov)
Received: from localhost (philloc@localhost)
	by tigger.ccs.ornl.gov (8.9.1/8.9.1) with ESMTP id TAA27407;
	Wed, 9 Aug 2000 19:28:08 -0400 (EDT)
Date:   Wed, 9 Aug 2000 19:28:07 -0400
Reply-To: i15@ornl.gov
To:     James Simmons <jsimmons@acsu.buffalo.edu>
cc:     linux-fbdev@vuser.vu.union.edu, linux@cthulhu.engr.sgi.com
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and
 evidence..:-)
In-Reply-To: <Pine.LNX.4.10.10008091913570.1534-100000@maxwell.futurevision.com>
Message-ID: <Pine.SGI.4.10.10008091908170.26870-100000@tigger.ccs.ornl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

	Hi,
> 
> > I would also like to ask, if SGI is likely to make the hardware specs OSS
> > (for cobalt etc.), so that those with the skill (this is not my forte, but
> > I will try...), can stabilise this otherwise competent port.
> 
> Nope. SGI no longer supports Visual Workstations with linux. I don't even
> know if they support Visual Workstatiosn period. It would be nice if they
> did release the specs anyways :-)
	They support it on WindozeNT etc... I was toying with the idea of 
running VMware just to see what the X server will do under NT.


	Anyone from SGI care to comment on why SGI has not released the
specs to reasonable attention, since they are unable to help port? 

As complex as the hardware is, the SGI guys did a pretty good job on the
"hacks" they put in, so I am sure the specs would make it a breeze to port
:-)

> 
> > 1. After boot , no matter what video mode one is in, the text console is
> > zippy. After using X (or changing modes using fbset) the text scrolling is
> > *painfully* slow. There is no apparent difference in the kernel mechanism
> > when switching, so is it just the boot state that works?
> 
> Which X server?  Sounds like the X server is doing the naughty.
	Oh not even X. X is fine in fact (with the exception it shivers
and is tinted green in 32bit 1600x1200, and tinted green in 32bit 
1280x1024 , but fine in 8-16bit for all modes).

	The problems is: 

	machine boots. Text scrolling fine, no matter what I set it to
in the kernel (in 8bit colour that is. 16bit and I lose the fonts). If you
then fbset to ANY mode (say 800x600x8), and then do "ls -l", it is very
slow. Now I have stared at the kernel for a bit, and the only thing that
strikes me, is that on boot the frambuffer is initialised etc.., and it is
possible that the hardware is in some sort of "bios" mode, which plays
nice with the framebuffer. After boot, we switch the mode etc... but
something is not tripped, or the kernel/video uses a different set of
routines.

	I suppose I should ask, anyone else see this behaviour?

> 
> > 	Empirical observations (i.e. writing known patterns to the
> > /dev/fb0 device) indicate that SGI reverse RGB for 888 format, compared to
> > RGB565. That is red offset=0, green=8,blue=16 rather than red=24 etc.. I
> > have reversed the assignment in the "var" structure (in sgivwfb_set_var )
> > and in setcolreg the offsets are used, but to no effect. What else needs
> > changing?
> 
> Have a patch for this? Can you post it?

	If you want, but it has no effect, as bemusing as that sounds. I
could post the framebuffer test program (generates a framebuffer-file full
of "regular" colours, so you can deduce the settings visually- very nasty
hack).


	Oh BTW, kernel is 2.2.13 with all SGI patches (before they yanked
the OSS site),and a few mods of my own to get it to compile(inthe setup
rotuines).

	Hey as an aside, anyone know how to "uncompress" a "vmlinuz"
kernel to a "vmlinux"? SGI had posted a kernel or 2 , but always in the
"vmlinuz" format. To the best of my knowledge cannot be booted
on the VW 540.

	
	Finally, I looked at rewriting the visw_apic.c code upto 2.4 , to
the new format. It looks do-able, but I know little about this, and I do
not know if anyone else has had a hack yet.


	Cheers for now

	PHiL
