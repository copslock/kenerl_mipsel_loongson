Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1NLUiA12350
	for linux-mips-outgoing; Sat, 23 Feb 2002 13:30:44 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1NLUc912344
	for <linux-mips@oss.sgi.com>; Sat, 23 Feb 2002 13:30:38 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g1NKUbW08334;
	Sat, 23 Feb 2002 12:30:37 -0800
Date: Sat, 23 Feb 2002 12:30:37 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Kevin Paul Herbert <kph@ayrnetworks.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Anyone have the e1000.o driver working?
Message-ID: <20020223123037.A8314@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIMELICFAA.mdharm@momenco.com> <a05100300b89cfbd22145@[192.168.1.5]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a05100300b89cfbd22145@[192.168.1.5]>; from kph@ayrnetworks.com on Fri, Feb 22, 2002 at 11:59:34PM -0800
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, I finally got the latest version running (see my other message to
this list... where did that go, anyway?).  The problem was that the code to
deal with CONFIG_PROC_FS is causing a crash... and it looks like it might
be a toolchain bug.

What toolchain are you using?

Hopefully my last message will get through... but basically e1000_main.c
references and extern struct pointer, and the code generated doesn't look
right -- it does a lui v0,0x0 and then a lw v0,0(v0) which causes a crash.

If you're not seeing this, then maybe I'm doing something wrong.

What CFLAGS are you using?  I had to modify mine based on an old e-mail
from someone (Pete?) that I found via google.

Matt

On Fri, Feb 22, 2002 at 11:59:34PM -0800, Kevin Paul Herbert wrote:
> At 4:22 PM -0800 2/22/02, Matthew Dharm wrote:
> >Does anyone here have the e1000.o driver from Intel for their gigabit
> >ethernet devices working on a MIPS?
> >
> >After overcoming the intitial CFLAGS problem, the darned thing just
> >seems to keep crashing on me during initialization.  I'm looking for a
> >datapoint to suggest that it's either (a) a problem with my linux
> >port, or (b) a problem with their driver.
> >
> >Matt
> >
> >--
> >Matthew D. Dharm                            Senior Software Designer
> >Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> >(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> >Momentum Works For You                      www.momenco.com
> 
> I have the e1000 driver working... I've had 3.0 and 3.5 working. The 
> only changes that I made were related to the specifics of the 
> software defined I/O pins. Are you sure that you have ioremap() and 
> your PCI subsystem working correctly? Have you tested any other 
> devices that use registers in PCI memory space, or just PCI i/o space?
> 
> Kevin
> -- 

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
