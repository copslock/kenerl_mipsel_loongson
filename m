Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 07:07:06 +0100 (BST)
Received: from alnrmhc12.comcast.net ([204.127.225.92]:14776 "EHLO
	alnrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022205AbXJCGG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 07:06:57 +0100
Received: from [192.168.1.4] (c-69-140-18-238.hsd1.md.comcast.net[69.140.18.238])
          by comcast.net (alnrmhc12) with ESMTP
          id <20071003060614b1200m1ra0e>; Wed, 3 Oct 2007 06:06:14 +0000
Message-ID: <47033156.7090703@gentoo.org>
Date:	Wed, 03 Oct 2007 02:06:14 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Ed Stafford <ed.stafford@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: What is the current state of the Octane/IP30 support?
References: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com>
In-Reply-To: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ed Stafford wrote:
> I have a single-proc Octane at home that I've decided should be
> running with Linux, but I have been reading up online about the
> Experimental nature of the kernel in relation to the hardware.  Since
> most of the info I found was dated 2006, I wanted to ask your (as a
> group) opinion on how stable / usable the Octane is today with the
> current kernel.
> 
> I'm not adverse to bleeding edge, I just want to know whether or not
> I'll be struggling on something that just doesn't have enough drivers
> written for it to make it usable.
> 
> Just in case anyone asks, I'll probably be using Gentoo, but I'm not
> glued to that distro.  (I'm very agnostic and just prefer it to work
> the best vs. distro-warring..)
> 
> Thanks a bunch!

Right now, Gentoo does have the best support for them (mine is running 
2.6.23-rc5 about 3.5ft from me as I type).  But I do believe the debian guys 
have been working on a debian install image for them too (tbm/ths, am I right on 
this?)

For the most part, Impact-based systems run great.  You get X, unaccelerated, no 
3D, and a framebuffer.  VPro, framebuffer, but no X.  USB kinda weorks if you 
have a PCI-Card Cage and a OHCI chipsets (UHCI is dead last I checked), and I 
think EHCI works fine.  Haven't tried much else beyond those PCI devices.

A lot of the other XIO Boards, outside of the Impact or Vpro boards, are wholly 
untested, and likely won't work at all.  Nor do I think dual head will work if 
you have a second Impact card kicking around.

For gentoo, we have an "RC6" livecd.  I've played with building an RC7 several 
times, but that got sidetracked about 2-3 months ago.  I hope to resume work on 
it soon.  You can find that and the current netboots on your local gentoo 
mirror, in the experimental/mips sub-folders.

Further gentoo questions regarding this system should be directed to the 
gentoo-mips ML; linux-mips here is more for distro-agnostic development.

Have fun!  (and what Proc, btw?)


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
