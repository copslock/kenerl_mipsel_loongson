Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OIFcf25060
	for linux-mips-outgoing; Thu, 24 Jan 2002 10:15:38 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OIFYP25038
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 10:15:34 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16TnTU-00078e-00; Thu, 24 Jan 2002 12:15:44 -0500
Date: Thu, 24 Jan 2002 12:15:44 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Scott A McConnell <samcconn@cotw.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: gdb, pthreads and MIPS
Message-ID: <20020124121544.A26522@nevyn.them.org>
References: <3C502108.B4024075@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C502108.B4024075@cotw.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 24, 2002 at 08:58:16AM -0600, Scott A McConnell wrote:
> I am targeting a NEC VR5432
> 
> I am able to debug/set break points on executables that are not linked
> with -lpthreads. However, whenever I try an executable that was linked
> with pthreads gdb can never find the stack (PC).
> 
> Once a SIGTRAP occurs gdb has lost track of the stack. Up until that
> point it seems to be keeping track of the PC.
> 
> I have tried gdb from the SGI site (H J Lu) I also have built 5.1.0.1
> native. Both fail.
> 
> Are other people having trouble debugging pthreads?
> Are there any patches available?
> Can anyone even help me classify this problem? (gcc, glibc, gdb all
> three)

Primarily glibc.  I've spent a long long time trying to get this fixed
and Ulrich categorically refused the patch.  The size of prgregset in
the headers is wrong.

Edit /usr/include/sys/procfs.h, change the typedef of pr*regset from
*regset_t to elf_*regset_t, rebuild GDB, see if it works.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
