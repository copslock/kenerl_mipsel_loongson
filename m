Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJeZnC012469
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:40:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJeZ0Y012468
	for linux-mips-outgoing; Sun, 19 May 2002 12:40:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJeUnC012444
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:40:30 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJf3F03292;
	Sun, 19 May 2002 12:41:03 -0700
Date: Sun, 19 May 2002 12:41:03 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Jun Sun <jsun@mvista.com>, Daniel Jacobowitz <dan@debian.org>,
   Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519124103.G20670@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com> <007a01c1fca9$86e14f70$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <007a01c1fca9$86e14f70$10eca8c0@grendel>; from kevink@mips.com on Thu, May 16, 2002 at 09:15:40AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 16, 2002 at 09:15:40AM +0200, Kevin D. Kissell wrote:

> Is this to say that Linux cannot function unless all physical memory
> on the system is mapped at all times into kernel space?  I would
> have thought that (a) all that really needs to be mapped is all
> memory used by the kernel itself, plus that of the currently active
> process (which is mapped in the 2GB kuseg), and that (b) one 
> could anyway manage kseg2 or 3 dynamically to provide a window 
> into a larger physical memory, and that this window could be
> used for any functions that need to do arbitrary phys-to-phys
> copies.

Highmem is your dynamic 4MB window into all memory that's not low memory.
KSEG2/3 are currently mostly reserved for vmalloc / ioremap and these
4MB of highmem mapping space - a usage that's certainly wasteful.

As opposed to that all the permanently mapped kernel memory in Linux is
called lowmem.

> I'm not sure what people's definition of a "64-bit kernel"
> is around here, but to me, that's a kernel which supports
> 64-bit virtual addressing and 64-bit registers.  It strikes
> me as being rather foolish to impose the overhead of all
> that on people whose only real requirement is 2G of RAM
> on a 32-bit CPU.  Particularly when many of the new
> MIPS parts that could plausibly be connected to 2GB
> RAM arrays, such as the Alchemy/AMD and MIPS 4K
> parts, don't support 64-bit operation.  So running away
> from the problem isn't really an option.

Highmem doesn't come without a price either - in particular processes doing
heavy I/O will possibly as much as 40% performance penalty (numbers from
Intel systems) and for sanity's sake - 64-bit is keeping people from going
nuts :)

A solution that will use most of KSEG2/3 for mapping more lowmemory is in
the works but it turned out to be drastically more complex that originally
thought so will still take a bit.

  Ralf
