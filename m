Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 17:02:50 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:38543 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225340AbTKZRCi>;
	Wed, 26 Nov 2003 17:02:38 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AP33c-0003QK-LP; Wed, 26 Nov 2003 12:02:28 -0500
Date: Wed, 26 Nov 2003 12:02:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
Message-ID: <20031126170228.GA13116@nevyn.them.org>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl> <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl> <20031125232439.GE11047@linux-mips.org> <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2003 at 01:09:16AM +0100, Maciej W. Rozycki wrote:
> On Wed, 26 Nov 2003, Ralf Baechle wrote:
> 
> > Guess we'll need a solution along the lines of
> > unix/sysv/linux/sparc/sparc32/getpagesize.c then ...
> 
>  I suppose so, although being not that fond of insane numbers of syscalls
> I wonder how sysdeps/unix/sysv/linux/ia64/getpagesize.c gets away with
> static binaries...  Perhaps we should ask glibc hackers?

Look at elf/dl-support.c:_dl_aux_init? dl_pagesize should end up
initialized for static binaries too.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
