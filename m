Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93JThF22112
	for linux-mips-outgoing; Wed, 3 Oct 2001 12:29:43 -0700
Received: from dea.linux-mips.net (a1as01-p32.stg.tli.de [195.252.185.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93JTcD22106
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 12:29:38 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f93JTO528867;
	Wed, 3 Oct 2001 21:29:24 +0200
Date: Wed, 3 Oct 2001 21:29:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
Message-ID: <20011003212924.A28810@dea.linux-mips.net>
References: <3BBB62DE.3040003@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBB62DE.3040003@esstech.com>; from gerald.champagne@esstech.com on Wed, Oct 03, 2001 at 02:11:26PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 03, 2001 at 02:11:26PM -0500, Gerald Champagne wrote:

> For each configuration, only one case is compiled in.  Wouldn't it
> be simpler to just give the board-specific setup function a common name
> and consider it part of the board-specific api like all the other
> board-specific functions.  Can this be changed to just this:
> 
> -----------------
> void __init setup_arch(char **cmdline_p)
> {
> 	void foo_setup(void);
> 
> 	...
> 
> 	foo_setup();  /* someone pick a name for this */
> 	...
> -----------------
> 
> I'm trying to document an api for supporting an arbitrary board, and little
> things like this make it more difficult to define something along the lines
> of a bsp interface.  Any suggestions?  Any objections?

We used to allow support for multiple boards in one kernel binary though
that usually doesn't work for MIPS due to the large number of very different
systems.  People have asked to resurrect this option, so I'd like to go
for an option that only removes all those awful #ifdefs.  Something based
on ELF sections looks like a way to do this.

  Ralf
