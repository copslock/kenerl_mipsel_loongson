Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2003 13:00:30 +0100 (BST)
Received: from p508B58EB.dip.t-dialin.net ([IPv6:::ffff:80.139.88.235]:39308
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225232AbTFXMA1>; Tue, 24 Jun 2003 13:00:27 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5OC0JML007253;
	Tue, 24 Jun 2003 14:00:19 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5OC0I9P007252;
	Tue, 24 Jun 2003 14:00:18 +0200
Date: Tue, 24 Jun 2003 14:00:18 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: ik@cyberspace.org
Cc: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: is there any docs/manuals for linker scripts symbols
Message-ID: <20030624120017.GE4423@linux-mips.org>
References: <Pine.SUN.3.96.1030624055005.4605A-100000@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SUN.3.96.1030624055005.4605A-100000@grex.cyberspace.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 24, 2003 at 06:00:16AM -0400, ik@cyberspace.org wrote:

> I'm porting Linux kernel to a mips board for which I need to understand
> the various symbols used in the kernel.
> 
> For example what is the use of the following symbols
> `__init_begin'
> `__init_end'
> `__initcall_start
> `__initcall_end'
> `_ftext'
> `__setup_start'
> `__setup_end'
> 
> I'm not good in these linker scripts... any help pointers would be of
> great help to me ! (I'm referrring gnu ld  manual pages ... still have a
> long way to go :(

You'll find more information in the GNU info pages than in the man page
which is sort of an option summary only.  Of course both only cover ld,
not the way it's actually being used in Linux.

_ftext is the start of the executable kernel code.  __init_begin and
__init_end wrap the kernel's initialization code which will be freed after
full initialization.  See arch/mips/mm/init.c:__init_begin() and
arch/mips/mm/init.c:free_initmem() for how it's used.

__initcall_start and __initcall_end are used for the initcalls in
init/main.c.  See how those symbols are used in init/main.c:do_initcalls().
__setup_start and __setup_end are used in similarly obscure way to mark
start and end of the .setup.init section; see init/main.c:checksetup()
and <linux/init.h> for it's use.

  Ralf
