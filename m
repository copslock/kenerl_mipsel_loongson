Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47MDtwJ010277
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 15:13:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47MDsmc010276
	for linux-mips-outgoing; Tue, 7 May 2002 15:13:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47MDnwJ010272
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 15:13:50 -0700
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 175DEm-0005r9-00; Tue, 07 May 2002 18:15:12 -0400
Date: Tue, 7 May 2002 18:15:12 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
Message-ID: <20020507221512.GA22326@nevyn.them.org>
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX>
User-Agent: Mutt/1.5.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 05:05:36PM -0500, Siders, Keith wrote:
> I am using x86 Linux for host development to a MIPS Linux embedded target. I
> finally have a hardware debugger for my target board that works, but I have
> to get large application files downloaded in a timely fashion. The debugger
> must download to the target via JTAG, therefore downloads have lots of bits
> of overhead, i.e. downloads are slow. Is there anything like a gdb server
> that can I run on the target to connect to a remote client via ethernet? I
> don't really want to have to compile a complete gdb tool to run on my target
> board to do this. I don't have the luxury of a lot of memory on this board,
> and no swap space (flash-based system, no hdd). The real catch is I would
> like to be able to resolve the symbols of the application so the debugger
> can be used to set hardware breakpoints, and provide source-level debugging
> of the application. Or am I going about this totally bassackwards?

There is an appropriate program.  In fact, you even got the name right:
it's called "gdbserver", and is included with the GDB distribution.

I recommend you get GDB 5.2, released last week; the gdbserver included
in that version is far superior for GNU/Linux targets to any previous
release.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
