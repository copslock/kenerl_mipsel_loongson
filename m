Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FN0onC015890
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 16:00:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FN0oNB015889
	for linux-mips-outgoing; Sat, 15 Jun 2002 16:00:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FN0inC015886
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 16:00:44 -0700
Received: from drow by crack.them.org with local (Exim 3.12 #1 (Debian))
	id 17JMZp-00055q-00; Sat, 15 Jun 2002 18:03:25 -0500
Date: Sat, 15 Jun 2002 18:03:25 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Justin Wojdacki <justin.wojdacki@analog.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
Message-ID: <20020615180325.B19472@crack.them.org>
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org> <3D0BA3C4.79ED2B5D@analog.com> <20020615153831.B19123@crack.them.org> <3D0BBCA5.5A0D722A@analog.com> <20020615172645.A19472@crack.them.org> <3D0BC248.16CB7EC2@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0BC248.16CB7EC2@analog.com>; from justin.wojdacki@analog.com on Sat, Jun 15, 2002 at 03:40:08PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 15, 2002 at 03:40:08PM -0700, Justin Wojdacki wrote:
> Daniel Jacobowitz wrote:
> >
> > Wait, wait.  What are you trying to do?  Originally you were talking
> > about userspace debugging via gdbserver.  Now you're talking about
> > kernel debugging via kgdb.  They're separate (and coexisting can cause
> > problems if you are not careful with your exception handlers; I do not
> > remember when my patches to make that work went into the tree, or if
> > someone else did it).
> > 
> > gdbserver can just use TCP.
> > 
> > --
> > Daniel Jacobowitz                           Debian GNU/Linux Developer
> > MontaVista Software                         Carnegie Mellon University
> 
> Sorry for the confusion. I've been discussing userspace debugging via
> gdbserver the entire time. However, I've noticed that gdbserver
> doesn't seem to be fully functional because the kernel doesn't seem to
> be handling the "BREAK 5" instruction correctly. You mentioned
> problems with board exception handling and I looked at the ddb series
> board support code. In there, I found handling for software
> breakpoints, and got the impression from the code that it was a
> general debugging interface, not just for kernel debugging. Again,
> sorry for the confusion.
> 
> As it stands right now, when I get hit a "BREAK 5" instruction,
> gdbserver never get's a chance to handle it, as the kernel keeps
> scheduling the child process I'm trying to debug, and hitting the
> "BREAK 5" instruction over and over again. What I can't seem to find
> out is how gdbserver is supposed to get scheduled again. 

What should happen is that the child receives a signal (SIGTRAP) after
the exception.  Then it is scheduled again, drops into do_signal, and
the kernel notices that the traced bit is set and wakes the tracer.  I'd
guess your board needs to do something different to deliver the SIGTRAP
properly, if that isn't happening.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
