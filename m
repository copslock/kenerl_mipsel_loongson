Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KKUDnC025375
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 13:30:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KKUD6N025374
	for linux-mips-outgoing; Mon, 20 May 2002 13:30:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KKU8nC025371
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 13:30:08 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4KKUuh15905;
	Mon, 20 May 2002 13:30:56 -0700
Date: Mon, 20 May 2002 13:30:56 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020520133056.D14066@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020519122336.A20670@dea.linux-mips.net> <20020519230552.A17175@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020519230552.A17175@momenco.com>; from mdharm@momenco.com on Sun, May 19, 2002 at 11:05:52PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 19, 2002 at 11:05:52PM -0700, Matthew Dharm wrote:

> > > What does it take to do a 64-bit port?  The first problem I see is the
> > > boot loader -- do I have to be in 64-bit mode when the kernel starts,
> > > or can I start in 32-bit mode and then transfer to 64-bit mode?
> > 
> > Same loader as before - the build procedure will result in a 32-bit kernel
> > binary which is loaded to the same old KSEG0 addresses.
> 
> Call me a bit slow, but...
> 
> Are you saying that my 32-bit loader (which is designed to load a 32-bit
> ELF file) will do exactly that... but this 32-bit ELF file has the magic in
> it to switch to 64-bit internally?
> 
> Nice... Very nice.  I'm used to slick Open Source solutions, but I have to
> admit that this is a pretty elegant one that solves a great many
> problems...

It's a fairly natural solution to the problem we had.  The scenario we had
to deal with was

 - a machine (SGI Origin 200/2000 aka IP27) where configurations are
   commonly way too large for a 32-bit kernel.
 - 64-bit MIPS/ELF support that was close to entierly unusable
 - fixing binutils fully would have taken a serious amount of time which
   we didn't have.

As it turned out gas is perfectly able to assemble the assembler code that
is generated for the N64 ABI by gcc into 32-bit ELF and linking that.
That code model still uses 64-bit pointers just all intra-kernel refernces
that were generated from la or dla macros get expanded into just the
two instruction sequence for 32-bit code, not the upto 7 instruction used
for 64-bit code.  Result: much less tools work necessary yet better code.

  Ralf
