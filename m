Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FMO9nC012929
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 15:24:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FMO9Pa012928
	for linux-mips-outgoing; Sat, 15 Jun 2002 15:24:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FMO4nC012923
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 15:24:04 -0700
Received: from drow by crack.them.org with local (Exim 3.12 #1 (Debian))
	id 17JM0L-00054O-00; Sat, 15 Jun 2002 17:26:45 -0500
Date: Sat, 15 Jun 2002 17:26:45 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Justin Wojdacki <justin.wojdacki@analog.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
Message-ID: <20020615172645.A19472@crack.them.org>
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org> <3D0BA3C4.79ED2B5D@analog.com> <20020615153831.B19123@crack.them.org> <3D0BBCA5.5A0D722A@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0BBCA5.5A0D722A@analog.com>; from justin.wojdacki@analog.com on Sat, Jun 15, 2002 at 03:16:05PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 15, 2002 at 03:16:05PM -0700, Justin Wojdacki wrote:
> Daniel Jacobowitz wrote:
> > 
> > Software breakpoints have worked at least as far back as 2.4.2.  This
> > most likely means that the exception handling for your board is broken.
> > 
> 
> Sorry, originally misinterpretted your use of "board" as referring to
> the board itself, and perhaps PMON (I've found a number of references
> online to GDB talking to PMON, but not much else). 
> 
> So what I've found by looking at other board-specific code revolves
> around GDB talking to an in-kernel stub via the serial port. As the
> board I'm working with has an unreliable serial port (and some
> incarnations don't even have that), what about ethernet-based
> debugging? Is that do-able, say via putDebugChar() (although I suspect
> this poses an initialization problem)? 
> 
> Thanks for the info so far. 

Wait, wait.  What are you trying to do?  Originally you were talking
about userspace debugging via gdbserver.  Now you're talking about
kernel debugging via kgdb.  They're separate (and coexisting can cause
problems if you are not careful with your exception handlers; I do not
remember when my patches to make that work went into the tree, or if
someone else did it).

gdbserver can just use TCP.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
