Received:  by oss.sgi.com id <S553806AbQKPANA>;
	Wed, 15 Nov 2000 16:13:00 -0800
Received: from u-6.karlsruhe.ipdial.viaginterkom.de ([62.180.20.6]:46597 "EHLO
        u-6.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553717AbQKPAMx>; Wed, 15 Nov 2000 16:12:53 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870082AbQKOHwp>;
        Wed, 15 Nov 2000 08:52:45 +0100
Date:   Wed, 15 Nov 2000 08:52:45 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com,
        lfs-discuss@linuxfromscratch.org, Andreas Jaeger <aj@suse.de>
Subject: Re: User/Group Problem
Message-ID: <20001115085244.A5153@bacchus.dhis.org>
References: <20001113231949.B16012@bacchus.dhis.org> <Pine.GSO.3.96.1001114150916.17140A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001114150916.17140A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Nov 14, 2000 at 03:19:11PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 14, 2000 at 03:19:11PM +0100, Maciej W. Rozycki wrote:

> > There is second interpretation of this problem - the address passed to
> > mmap is bogus, so this computation needs to be fixed.
> 
>  Where is it written mmap() is allowed to fail when a bogus VM address is
> passed but MAP_FIXED is not set?  I believe mmap() should choose a
> different VM address in this case, as long as much enough contiguous VM
> space is available anywhere to satisfy the requested length.

No argument about that, I do agree.

>  Surely, map_segment() (see dl-load.c) might call mmap(0, ...) after
> mmap(<some_address>, ...) fails when MAP_FIXED is not set but wouldn't
> that be a dirty hack?  We'd better fix the kernel. 

Ld.so isn't linked to the same base address as all other libraries for
obscure reasons.  Right now dl-machine.h use the constant value of 0x5ffe0000
as the base address which it assumes all libraries to be linked to - and that
makes us calculate the wrong base address which we're passing to mmap.

So we've got two bugs, not just one.  I knew about the ld.so part since
Linux/MIPS has shared libs.  It's just that this is the first time this bug
bites us.

  Ralf
