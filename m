Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93LKcM25107
	for linux-mips-outgoing; Wed, 3 Oct 2001 14:20:38 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93LKUD25104;
	Wed, 3 Oct 2001 14:20:30 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f93LNLB32003;
	Wed, 3 Oct 2001 14:23:21 -0700
Message-ID: <3BBB7F14.C864736A@mvista.com>
Date: Wed, 03 Oct 2001 14:11:48 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Gerald Champagne <gerald.champagne@esstech.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
References: <3BBB62DE.3040003@esstech.com> <20011003212924.A28810@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Gereald,

The following is copied from one of my previous posts in linux-mips mailing
list.  I think this is a reasonable idea.

BTW, do_initcalls() scheme is the same thing as Ralf is referring to as ELF
section.

Jun

.....
I talked about machine detection a while back.  My idea is following:

0. all machines that are *configured* into the image will supply <my>_detect()
and <my>_setup() functions.

1. at MIPS start up, we loop through all <my>_detect(), which returns three
values, a) run-time detection negative, b) run-time detection positive, and c)
no run-time detection code, but I return positive because I am configured in.

2. the startup code resolves conflicts (which sometimes may panic); and decide
on one machine.

3. then the startup code calls the right <my>_setup() code which will set up
the mach_type and other stuff. 

BTW, a side benenfit of doing this is that we can remove all the machine
specific code in common files such as bootinfo.h, setup.c, etc, which are
getting harder and harder to maintain as we are adding more and more embedded
boards to the tree.  

If we push it to an extreme by using mechnism like do_initcalls(), we can
achieve zero common source file modification when adding a new a machine. 
This will greatly facilitate embedded development as it allows more parallel
development and allow people to maintain their own board code much easier
before the code is submitted to the tree.

Jun




Ralf Baechle wrote:
> 
> On Wed, Oct 03, 2001 at 02:11:26PM -0500, Gerald Champagne wrote:
> 
> > For each configuration, only one case is compiled in.  Wouldn't it
> > be simpler to just give the board-specific setup function a common name
> > and consider it part of the board-specific api like all the other
> > board-specific functions.  Can this be changed to just this:
> >
> > -----------------
> > void __init setup_arch(char **cmdline_p)
> > {
> >       void foo_setup(void);
> >
> >       ...
> >
> >       foo_setup();  /* someone pick a name for this */
> >       ...
> > -----------------
> >
> > I'm trying to document an api for supporting an arbitrary board, and little
> > things like this make it more difficult to define something along the lines
> > of a bsp interface.  Any suggestions?  Any objections?
> 
> We used to allow support for multiple boards in one kernel binary though
> that usually doesn't work for MIPS due to the large number of very different
> systems.  People have asked to resurrect this option, so I'd like to go
> for an option that only removes all those awful #ifdefs.  Something based
> on ELF sections looks like a way to do this.
> 
>   Ralf
