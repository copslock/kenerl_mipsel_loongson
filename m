Received:  by oss.sgi.com id <S553976AbQKMWUd>;
	Mon, 13 Nov 2000 14:20:33 -0800
Received: from u-174.karlsruhe.ipdial.viaginterkom.de ([62.180.10.174]:27404
        "EHLO u-174.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553967AbQKMWUY>; Mon, 13 Nov 2000 14:20:24 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868642AbQKMWTt>;
        Mon, 13 Nov 2000 23:19:49 +0100
Date:   Mon, 13 Nov 2000 23:19:49 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com,
        lfs-discuss@linuxfromscratch.org
Subject: Re: User/Group Problem
Message-ID: <20001113231949.B16012@bacchus.dhis.org>
References: <20001108050158.B12999@bacchus.dhis.org> <Pine.GSO.3.96.1001113195048.12211C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001113195048.12211C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Nov 13, 2000 at 08:02:48PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Nov 13, 2000 at 08:02:48PM +0100, Maciej W. Rozycki wrote:

> >  - your chown / chgrp binaries are statically linked.  In that case nss
> >    won't work on MIPS until it's fixed ...
> 
>  That's actually not a MIPS-specific problem.  This happens due to a bogus
> error from mmap() (when called by ld.so) which cannot handle certain valid
> requests -- when there is a non-zero suggested VM address, but the area
> and all space above it is already occupied or unavailable for other
> reasons.  It can sometimes appear for other ports, as well (I have an i386
> test case, for example), but it bites MIPS specifically, because of a
> non-zero initial VMA set for our shared objects.
> 
>  Here is a patch I use since July successfully.  We need to wait until
> 2.4.1 or so (or maybe even 2.5) is released for it to be applied as
> 2.4.0-test* are currently code-frozen.  Maybe we could apply it to our CVS
> for now?  Ralf, what do you think? 

There is second interpretation of this problem - the address passed to
mmap is bogus, so this computation needs to be fixed.

  Ralf
