Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6E05L205620
	for linux-mips-outgoing; Fri, 13 Jul 2001 17:05:21 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6E05GV05616
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 17:05:16 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09108
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 17:05:06 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15LClu-00059C-00; Fri, 13 Jul 2001 16:54:58 -0700
Date: Fri, 13 Jul 2001 16:54:58 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: GDB <gdb@sourceware.cygnus.com>, linux-mips@oss.sgi.com
Subject: Re: Gdb quit problem on Linux/mips
Message-ID: <20010713165458.A19776@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	GDB <gdb@sourceware.cygnus.com>, linux-mips@oss.sgi.com
References: <20010713164415.A31747@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010713164415.A31747@lucon.org>; from hjl@lucon.org on Fri, Jul 13, 2001 at 04:44:15PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 04:44:15PM -0700, H . J . Lu wrote:
> Did anyone see the quit problem on Linux/mips with gdb 2001-07-13-cvs?
> I got
> 
> (gdb) b main
> Breakpoint 1 at 0x400744: file x.c, line 3.
> (gdb) r
> Starting program: /tmp/./a.out 
> 
> Breakpoint 1, main () at x.c:3
> 3         printf ("Hello\n");
> (gdb) q
> The program is running.  Exit anyway? (y or n) y
> 
> It stops here. I get
> 
>  1540 pts/0    S      0:04 ./gdb ./a.out
>  1550 pts/0    T      0:00 /tmp/./a.out
> 
> # strace -p 1540
> wait4(-1,
> 
> It may be a kernel bug. I am running 2.4.3.

Yes, it's a kernel bug.  I believe this is fixed in the SGI tree; I
know it's fixed in ours (which will be available Monday or later
tonight).

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
