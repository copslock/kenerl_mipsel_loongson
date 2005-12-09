Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 20:35:36 +0000 (GMT)
Received: from mailserver.c-lab.de ([131.234.80.230]:29366 "EHLO
	mailserver.c-lab.de") by ftp.linux-mips.org with ESMTP
	id S3458533AbVLIUfR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 20:35:17 +0000
Received: from [131.234.81.18] (warstein.c-lab.de [131.234.81.18])
	by mailserver.c-lab.de (8.13.4/8.13.4/Debian-3) with ESMTP id jB9KZ4fS010198;
	Fri, 9 Dec 2005 21:35:04 +0100
Message-ID: <4399E92C.6000709@c-lab.de>
Date:	Fri, 09 Dec 2005 21:29:32 +0100
From:	Michael Joosten <michael.joosten@c-lab.de>
Organization: Siemens C-LAB
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Stephen P. Becker" <geoman@gentoo.org>
CC:	linux-mips@linux-mips.org
Subject: Re: SGI O2: working framebuffer/X11 modes?
References: <4399CD04.2781@c-lab.de> <4399D209.1060301@gentoo.org>
In-Reply-To: <4399D209.1060301@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.51 on 131.234.80.230
Return-Path: <michael.joosten@c-lab.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.joosten@c-lab.de
Precedence: bulk
X-list: linux-mips

Ups, that was fast...

Stephen P. Becker wrote:

>
> Prior to the 2.6.15-rc1 import into linux-mips git, X was only useable 
> if some variant of the gbefb patch at 
> http://home.tal.org/~milang/o2/patches/ was used.  The symptom was 
> that the X server would start and appear to be running, but you would 
> only have a black screen as the output.  There was the additional 
> oddity that even with this patch applied, X would do the old black 
> screen thing for anybody with greater than 256mb, but less than 768mb 
> of RAM (introduced by the ip32 full memory patch which went into the 
> linux-mips tree in the past year or so).  In 2.6.15, now we only need 
> the following change for X to work, and there seems to be no 
> restrictions on the amount of RAM under which X will run:
> Another oddity which has plagued gbefb on O2 is that allocating more 
> than 4mb of memory to gbefb causes it to fail outright.  The kernel 
> will boot and userland comes up, but the framebuffer never initializes.
>
As just today another old O2 materialized on the trash heap around here, 
I actually might try my luck - but it's a R10K O2, IP32.
The sgivwfb driver uses by default 8MB at the highest end of phys 
memory, and increasing it to 16MB hasn't harmed yet.

>
>> Currently, the only VisWS mode that works under X11 is Depth 15bit,
>> using the 2 byte/16bit ARGB5 mode in sgivwfb.c, with 1280x1024 or 
>> higher with the 1600sw LCD panel.
>
>
> Interesting, because everything I have heard from folks who have tried 
> to use 1600sw with their O2s say that it doesn't work at all.

Well, I don't have a 1600sw, and there are some internal patches in the 
visws mailing list of Florian Boor who added a I2C self configuration to 
the driver, such that entereing the monitor type by kernel cmd line 
argument is not necessary anymore.

> In any case, X runs just fine at every single resolution I have tried, 
> including 640x480, 800x600, 1024x768, and 1280x1024.  Basically, if 
> you have a working framebuffer at any particular resolution (I usually 
> pass it at boot time via something like video=gbefb:1280x1024-16@85), 
> X will run at that resolution, no problem, since we are just using the 
> fbdev X driver.
>
>
OK, resolution also seems less a problem with the sgivwfb driver (though 
I remember a weirdness with 1024x768), but...

>> Surprisingly, Depth 16 in
>> /etc/X11/xorg.conf is not completely OK anymore, perhaps due to 
>> problems with the transparency bit. Anything else like 24 or 8 bit 
>> looks decidedly odd, and hard to read at all. Namely 24/32bit is 
>> completely broken, the width of the
>> display is only 2/3 of the screen, though timing is still OK.
>
>
> To my knowledge, running X in anything but 15bit depth has never 
> worked on O2.  I have attempted to start my O2 up with gbefb running 
> at various depths other than 16, and they always fail, defaulting back 
> to 640x480 at 16bpp (or occasionally even hanging the kernel).  
> Attempting to force some depth in the X config file always screwed 
> things up whenever I attempted this.  Furthermore, it seems like the 
> new modular X.org is smarter about probing the framebuffer 
> capabilities, and totally ignores the depth you specify in xorg.conf, 
> defaulting straight to 15.
>
...different depths produce funny results. Haven't tried 8bit, but 24 is 
definitely broken. You can still see something, but barely. So, we can 
probably deduce that the other-than-15bit modes were never actually 
tested by the original author (some intern then a SGI?). Recent info 
about the chances to get some hardware docs about the VisWS from SGI 
were simply turned down by the astonishing fact that they really dumped 
the whole product line: hardware, contracts, subcontractors (developed 
the gfx drivers for Win NT) and even documentation. Speak about a deed 
(x86 graphics workstations) so awful that nobody at SGI wanted be 
remembered about it ?

Thanks a bunch, Michael
