Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4K65BnC016385
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 23:05:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4K65B2M016383
	for linux-mips-outgoing; Sun, 19 May 2002 23:05:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4K654nC016337;
	Sun, 19 May 2002 23:05:04 -0700
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g4K65qb17191;
	Sun, 19 May 2002 23:05:52 -0700
Date: Sun, 19 May 2002 23:05:52 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519230552.A17175@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020519122336.A20670@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020519122336.A20670@dea.linux-mips.net>; from ralf@oss.sgi.com on Sun, May 19, 2002 at 12:23:37PM -0700
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 19, 2002 at 12:23:37PM -0700, Ralf Baechle wrote:
> On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> > What does it take to do a 64-bit port?  The first problem I see is the
> > boot loader -- do I have to be in 64-bit mode when the kernel starts,
> > or can I start in 32-bit mode and then transfer to 64-bit mode?
> 
> Same loader as before - the build procedure will result in a 32-bit kernel
> binary which is loaded to the same old KSEG0 addresses.

Call me a bit slow, but...

Are you saying that my 32-bit loader (which is designed to load a 32-bit
ELF file) will do exactly that... but this 32-bit ELF file has the magic in
it to switch to 64-bit internally?

Nice... Very nice.  I'm used to slick Open Source solutions, but I have to
admit that this is a pretty elegant one that solves a great many
problems...

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
