Received:  by oss.sgi.com id <S42212AbQHKHzL>;
	Fri, 11 Aug 2000 00:55:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:5705 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42202AbQHKHyk>;
	Fri, 11 Aug 2000 00:54:40 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA16218
	for <linux-mips@oss.sgi.com>; Fri, 11 Aug 2000 00:46:35 -0700 (PDT)
	mail_from (shm@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id AAA07490 for <linux-mips@oss.sgi.com>; Fri, 11 Aug 2000 00:52:24 -0700 (PDT)
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [130.62.52.189])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA31668;
	Fri, 11 Aug 2000 00:50:52 -0700 (PDT)
	mail_from (shm@cthulhu.engr.sgi.com)
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA33097; Fri, 11 Aug 2000 00:50:52 -0700 (PDT)
Date:   Fri, 11 Aug 2000 00:50:51 -0700
From:   Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
cc:     linux-fbdev@vuser.vu.union.edu,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and
 evidence..:-)
In-Reply-To: <Pine.SGI.4.10.10008091908170.26870-100000@tigger.ccs.ornl.gov>
Message-ID: <Pine.SGI.4.21.0008110042220.232700-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 9 Aug 2000 philloc@tigger.ccs.ornl.gov wrote:

>	Hi,
>> 
>> > I would also like to ask, if SGI is likely to make the hardware specs OSS
>> > (for cobalt etc.), so that those with the skill (this is not my forte, but
>> > I will try...), can stabilise this otherwise competent port.
>> 
>> Nope. SGI no longer supports Visual Workstations with linux. I don't even
>> know if they support Visual Workstatiosn period. It would be nice if they
>> did release the specs anyways :-)
>	They support it on WindozeNT etc... I was toying with the idea of 
>running VMware just to see what the X server will do under NT.
>

So just to make the statement sound right. SGI never officially supported
linux on the Visual Workstation 320. The current line of the Visual
Workstation family, the 230, 330 and 530 all do and will support highly
accelerated OpenGL under linux.

>
>	Anyone from SGI care to comment on why SGI has not released the
>specs to reasonable attention, since they are unable to help port? 
>
>As complex as the hardware is, the SGI guys did a pretty good job on the
>"hacks" they put in, so I am sure the specs would make it a breeze to port
>:-)
>

Actually a "port" is not that simple. The real problem for opening up the
driver port that we worked on, is that there are critical parts of SGI
driver mode IP in there that we are not ready to open source at this
point. Given that, the software is the best "spec" and documentation we
have at this point .. this is a real issue.

>> 
>> > 1. After boot , no matter what video mode one is in, the text console is
>> > zippy. After using X (or changing modes using fbset) the text scrolling is
>> > *painfully* slow. There is no apparent difference in the kernel mechanism
>> > when switching, so is it just the boot state that works?
>> 
>> Which X server?  Sounds like the X server is doing the naughty.
>	Oh not even X. X is fine in fact (with the exception it shivers
>and is tinted green in 32bit 1600x1200, and tinted green in 32bit 
>1280x1024 , but fine in 8-16bit for all modes).
>

I remember there being some issue about stuff being ABGR or some strange
format in some cases, which was screwing things up. Is this happening only
under WindowMaker or was it Enlightenment .. some window manager was
causing problems since it used X BLT's ..


>	The problems is: 
>
>	machine boots. Text scrolling fine, no matter what I set it to
>in the kernel (in 8bit colour that is. 16bit and I lose the fonts). If you
>then fbset to ANY mode (say 800x600x8), and then do "ls -l", it is very
>slow. Now I have stared at the kernel for a bit, and the only thing that
>strikes me, is that on boot the frambuffer is initialised etc.., and it is
>possible that the hardware is in some sort of "bios" mode, which plays
>nice with the framebuffer. After boot, we switch the mode etc... but
>something is not tripped, or the kernel/video uses a different set of
>routines.
>
>	I suppose I should ask, anyone else see this behaviour?
>
>> 
>> > 	Empirical observations (i.e. writing known patterns to the
>> > /dev/fb0 device) indicate that SGI reverse RGB for 888 format, compared to
>> > RGB565. That is red offset=0, green=8,blue=16 rather than red=24 etc.. I
>> > have reversed the assignment in the "var" structure (in sgivwfb_set_var )
>> > and in setcolreg the offsets are used, but to no effect. What else needs
>> > changing?
>> 

Hope this helps some. 

-- 
--------------------------------------------------------------------------
Shrijeet Mukherjee,    		        MTS Advanced Graphics, SGI
http://reality.sgi.com/shm_engr     	phone: 650-933-5312
email: shm@sgi.com, shrijeet@hotmail.com
--------------------------------------------------------------------------
Where there is a will, there is a way. If a way cannot be found, 
it is the will that is suspect ..                                   -- shm 
