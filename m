Received:  by oss.sgi.com id <S553861AbQLKS0r>;
	Mon, 11 Dec 2000 10:26:47 -0800
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:40693
        "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP
	id <S553667AbQLKS0c>; Mon, 11 Dec 2000 10:26:32 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBBJMOS20966;
	Mon, 11 Dec 2000 11:22:24 -0800
Message-ID: <3A358CEB.1B986EB7@mvista.com>
Date:   Mon, 11 Dec 2000 18:26:51 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Guido Guenther <guido.guenther@gmx.net>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
References: <20001209003222.A10669@bacchus.dhis.org> <Pine.GSO.3.96.1001211122115.18945B-100000@delta.ds2.pg.gda.pl> <20001211134133.A8720@faramir.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Guido Guenther wrote:
> 
> On Mon, Dec 11, 2000 at 12:28:19PM +0100, Maciej W. Rozycki wrote:
> > friends) by glibc.  At least XFree86 and SVGATextMode make use of these
> > features.  I suppose it's the same for MIPS (I haven't checked, though).
> Yes. xf86MapVidMem & friends use /dev/mem to mmap videomemory & iospace
> independent of architecure.
>  -- Guido


I am surprised.  I thought /dev/mem is for accessing SYSTEM RAM.  (do a 'man'
on /dev/mem)  It is also confirmed by the code in drivers/char/mem.c.  If you
want to access anything beyond 'high_memory", nothing is read.  

Note that drivers/char/mem.c is cross-platform code.  I am not sure how X
would access video memory through /dev/mem on either MIPS or other platforms.

That reason I want to fix /dev/kmem is that in some cases before a driver is
written people want to play with the hardware directly from the userland
(especially for demo purpose. :-0)  Very useful for embedded systems.

Potentially fixing /dev/mem can do the same job.  However /dev/mem cannot
differentiate cached or uncached accesses.  With /dev/kmem, we just specify
0x8.. or 0xa....

Jun
