Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 18:52:10 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:5770 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S3458528AbVLISvt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 18:51:49 +0000
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane.cc.vt.edu [10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id jB9IpfWS003355;
	Fri, 9 Dec 2005 13:51:41 -0500
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by zidane.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id ERG81100;
	Fri, 9 Dec 2005 13:50:59 -0500 (EST)
Message-ID: <4399D209.1060301@gentoo.org>
Date:	Fri, 09 Dec 2005 13:50:49 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Michael Joosten <joost@c-lab.de>
CC:	linux-mips@linux-mips.org
Subject: Re: SGI O2: working framebuffer/X11 modes?
References: <4399CD04.2781@c-lab.de>
In-Reply-To: <4399CD04.2781@c-lab.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> We've still have such a beast here, and I'm trying to set up a baseline
> of required patches for current kernels in order to get a running
> configuration out of the box.

Prior to the 2.6.15-rc1 import into linux-mips git, X was only useable 
if some variant of the gbefb patch at 
http://home.tal.org/~milang/o2/patches/ was used.  The symptom was that 
the X server would start and appear to be running, but you would only 
have a black screen as the output.  There was the additional oddity that 
even with this patch applied, X would do the old black screen thing for 
anybody with greater than 256mb, but less than 768mb of RAM (introduced 
by the ip32 full memory patch which went into the linux-mips tree in the 
past year or so).  In 2.6.15, now we only need the following change for 
X to work, and there seems to be no restrictions on the amount of RAM 
under which X will run:

--- drivers/video/gbefb.c.orig  2005-11-22 09:26:05 -0500
+++ drivers/video/gbefb.c       2005-11-22 08:16:58 -0500
@@ -1244,7 +1244,7 @@
                           (void *)gbe_tiles.cpu, gbe_tiles.dma);
         release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
         iounmap(gbe);
-       gbefb_remove_sysfs(dev);
+       gbefb_remove_sysfs(&p_dev->dev);
         framebuffer_release(info);

         return 0;

Another oddity which has plagued gbefb on O2 is that allocating more 
than 4mb of memory to gbefb causes it to fail outright.  The kernel will 
boot and userland comes up, but the framebuffer never initializes.


> Currently, the only VisWS mode that works under X11 is Depth 15bit,
> using the 2 byte/16bit ARGB5 mode in sgivwfb.c, with 1280x1024 
> or higher with the 1600sw LCD panel.

Interesting, because everything I have heard from folks who have tried 
to use 1600sw with their O2s say that it doesn't work at all.  In any 
case, X runs just fine at every single resolution I have tried, 
including 640x480, 800x600, 1024x768, and 1280x1024.  Basically, if you 
have a working framebuffer at any particular resolution (I usually pass 
it at boot time via something like video=gbefb:1280x1024-16@85), X will 
run at that resolution, no problem, since we are just using the fbdev X 
driver.


> Surprisingly, Depth 16 in
> /etc/X11/xorg.conf is not completely OK anymore, perhaps due 
> to problems with the transparency bit. Anything else like 24 
> or 8 bit looks decidedly odd, and hard to read at all. 
> Namely 24/32bit is completely broken, the width of the
> display is only 2/3 of the screen, though timing is still OK.

To my knowledge, running X in anything but 15bit depth has never worked 
on O2.  I have attempted to start my O2 up with gbefb running at various 
depths other than 16, and they always fail, defaulting back to 640x480 
at 16bpp (or occasionally even hanging the kernel).  Attempting to force 
some depth in the X config file always screwed things up whenever I 
attempted this.  Furthermore, it seems like the new modular X.org is 
smarter about probing the framebuffer capabilities, and totally ignores 
the depth you specify in xorg.conf, defaulting straight to 15.


> Back to the question: What mode(s) are usable on a Linux O2? 
> Did 24bit work at ANY time on the O2?

Not as far as I can tell.

-Steve
