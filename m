Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 21:23:58 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:27556 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S3458540AbVLIVXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 21:23:40 +0000
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id jB9LNYXr013970;
	Fri, 9 Dec 2005 16:23:34 -0500
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id EUJ28926;
	Fri, 9 Dec 2005 16:23:25 -0500 (EST)
Message-ID: <4399F5C3.1050706@gentoo.org>
Date:	Fri, 09 Dec 2005 16:23:15 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Michael Joosten <michael.joosten@c-lab.de>
CC:	linux-mips@linux-mips.org
Subject: Re: SGI O2: working framebuffer/X11 modes?
References: <4399CD04.2781@c-lab.de> <4399D209.1060301@gentoo.org> <4399E92C.6000709@c-lab.de>
In-Reply-To: <4399E92C.6000709@c-lab.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> As just today another old O2 materialized on the trash heap around here, 
> I actually might try my luck - but it's a R10K O2, IP32.

No luck there, as r10k ip32 still has the cache coherency problem, and 
won't run linux.


> The sgivwfb driver uses by default 8MB at the highest end of phys 
> memory, and increasing it to 16MB hasn't harmed yet.

The gbefb driver won't even let you choose more than 8mb, and I think 
2mb is the default.


> Well, I don't have a 1600sw, and there are some internal patches in the 
> visws mailing list of Florian Boor who added a I2C self configuration to 
> the driver, such that entereing the monitor type by kernel cmd line 
> argument is not necessary anymore.

It would be nice to know if these help out on mips, and if so, they 
should probably be contributed to the linux-mips tree.  I wish I had a 
1600sw with which to tinker.


> ...different depths produce funny results. Haven't tried 8bit, but 24 is 
> definitely broken. You can still see something, but barely. So, we can 
> probably deduce that the other-than-15bit modes were never actually 
> tested by the original author (some intern then a SGI?).

There was actually a patch for Xfree by the original author of the 
sgio2fb driver (Vivien, aka glaurung, wasn't it?) which allowed X to run 
properly in 16bpp.  However, this patch was lost in a hard drive crash 
if I recall.


> Recent info 
> about the chances to get some hardware docs about the VisWS from SGI 
> were simply turned down by the astonishing fact that they really dumped 
> the whole product line: hardware, contracts, subcontractors (developed 
> the gfx drivers for Win NT) and even documentation. Speak about a deed 
> (x86 graphics workstations) so awful that nobody at SGI wanted be 
> remembered about it ?

There are at least a couple of folks on this mailing list who I'm pretty 
sure know more about the specifics of this hardware.  The only question 
is, are they allowed to talk to you about it?

-Steve
