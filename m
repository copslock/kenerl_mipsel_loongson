Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4G79dnC014455
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 00:09:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4G79d5o014454
	for linux-mips-outgoing; Thu, 16 May 2002 00:09:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4G79XnC014451
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 00:09:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA28705;
	Thu, 16 May 2002 00:09:53 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA08193;
	Thu, 16 May 2002 00:09:48 -0700 (PDT)
Message-ID: <007a01c1fca9$86e14f70$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, "Daniel Jacobowitz" <dan@debian.org>
Cc: "Matthew Dharm" <mdharm@momenco.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com>
Subject: Re: MIPS 64?
Date: Thu, 16 May 2002 09:15:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> Daniel Jacobowitz wrote:
> 
> > On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> > 
> >>So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> >>That kinda blows the 32-bit MIPS port option right out of the water...
> >>
> > 
> > Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
> > there any reason MIPS has special problems in this area?
> > 
> 
> 
> MIPS has lower 2GB fixed for user space.  Then you have kseg0, .5GB for cached 
> physical address 0-0.5GB, and kseg1, 0.5GB uncached mapping of the same area. 
>   You can map another 1GB of RAM into kseg2/3, but you will then have no space 
> left for IO.
> 
> So you really can't do 1.5GB on 32 bit kernel.

Is this to say that Linux cannot function unless all physical memory
on the system is mapped at all times into kernel space?  I would
have thought that (a) all that really needs to be mapped is all
memory used by the kernel itself, plus that of the currently active
process (which is mapped in the 2GB kuseg), and that (b) one 
could anyway manage kseg2 or 3 dynamically to provide a window 
into a larger physical memory, and that this window could be
used for any functions that need to do arbitrary phys-to-phys
copies.

I'm not sure what people's definition of a "64-bit kernel"
is around here, but to me, that's a kernel which supports
64-bit virtual addressing and 64-bit registers.  It strikes
me as being rather foolish to impose the overhead of all
that on people whose only real requirement is 2G of RAM
on a 32-bit CPU.  Particularly when many of the new
MIPS parts that could plausibly be connected to 2GB
RAM arrays, such as the Alchemy/AMD and MIPS 4K
parts, don't support 64-bit operation.  So running away
from the problem isn't really an option.

            Regards,

            Kevin K.
