Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FLmbnC002288
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 14:48:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FLmbGb002287
	for linux-mips-outgoing; Wed, 15 May 2002 14:48:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FLmWnC002284
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 14:48:32 -0700
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 1786d8-0000WX-00; Wed, 15 May 2002 17:48:18 -0400
Date: Wed, 15 May 2002 17:48:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020515214818.GA1991@nevyn.them.org>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>
User-Agent: Mutt/1.5.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> That kinda blows the 32-bit MIPS port option right out of the water...

Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
there any reason MIPS has special problems in this area?

> 
> What does it take to do a 64-bit port?  The first problem I see is the
> boot loader -- do I have to be in 64-bit mode when the kernel starts,
> or can I start in 32-bit mode and then transfer to 64-bit mode?
> 
> I looked in the arch/mips64/ directory, but I don't see much for
> specific boards there, but there are references to the Malta
> boards....
> 
> Matt
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
> 

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
