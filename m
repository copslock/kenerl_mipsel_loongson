Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 13:01:37 +0100 (BST)
Received: from grex.cyberspace.org ([IPv6:::ffff:216.93.104.34]:25098 "HELO
	grex.cyberspace.org") by linux-mips.org with SMTP
	id <S8225220AbTFYMBf>; Wed, 25 Jun 2003 13:01:35 +0100
Received: from localhost (ik@localhost) by grex.cyberspace.org (8.6.13/8.6.12) with SMTP id IAA27228; Wed, 25 Jun 2003 08:01:25 -0400
Date: Wed, 25 Jun 2003 08:01:24 -0400 (EDT)
From: <ik@cyberspace.org>
To: <ralf@linux-mips.org>
cc: <linux-mips@linux-mips.org>
Subject: Re: is there any docs/manuals for linker scripts symbols
In-Reply-To: <20030624120017.GE4423@linux-mips.org>
Message-ID: <Pine.SUN.3.96.1030625073721.22435A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ik@grex.cyberspace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ik@cyberspace.org
Precedence: bulk
X-list: linux-mips

Thanks Ralf for your insights !

My board has a boot loader (rom) that enforce/restricts the sections in
the elf header, hence I cannot use the default linker script that comes
wit the kernel(arch/mips/). 

I'm refereing the ld manual at
http://www.gnu.org/manual/ld-2.9.1/html_mono/ld.html

I think your reply could be put as a howto/faqs in
http://www.linux-mips.org (for the global symbols
used in linux kernel).

Thanks,
Indu

On Tue, 24 Jun 2003 ralf@linux-mips.org wrote:

> On Tue, Jun 24, 2003 at 06:00:16AM -0400, ik@cyberspace.org wrote:
> 
> > I'm porting Linux kernel to a mips board for which I need to understand
> > the various symbols used in the kernel.
> > 
> > For example what is the use of the following symbols
> > `__init_begin'
> > `__init_end'
> > `__initcall_start
> > `__initcall_end'
> > `_ftext'
> > `__setup_start'
> > `__setup_end'
> > 
> > I'm not good in these linker scripts... any help pointers would be of
> > great help to me ! (I'm referrring gnu ld  manual pages ... still have a
> > long way to go :(
> 
> You'll find more information in the GNU info pages than in the man page
> which is sort of an option summary only.  Of course both only cover ld,
> not the way it's actually being used in Linux.
> 
> _ftext is the start of the executable kernel code.  __init_begin and
> __init_end wrap the kernel's initialization code which will be freed after
> full initialization.  See arch/mips/mm/init.c:__init_begin() and
> arch/mips/mm/init.c:free_initmem() for how it's used.
> 
> __initcall_start and __initcall_end are used for the initcalls in
> init/main.c.  See how those symbols are used in init/main.c:do_initcalls().
> __setup_start and __setup_end are used in similarly obscure way to mark
> start and end of the .setup.init section; see init/main.c:checksetup()
> and <linux/init.h> for it's use.
> 
>   Ralf
> 
