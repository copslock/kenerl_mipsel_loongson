Received:  by oss.sgi.com id <S553864AbQLKS71>;
	Mon, 11 Dec 2000 10:59:27 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:51720 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553845AbQLKS7R>; Mon, 11 Dec 2000 10:59:17 -0800
Received: from faramir.physik.uni-konstanz.de [134.34.144.86] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 145Y7i-00050f-00; Mon, 11 Dec 2000 19:56:30 +0100
Received: from agx by faramir.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 145Y7i-0003Mu-00; Mon, 11 Dec 2000 19:56:30 +0100
Date:   Mon, 11 Dec 2000 19:56:30 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
Message-ID: <20001211195630.A12935@faramir.physik.uni-konstanz.de>
References: <20001209003222.A10669@bacchus.dhis.org> <Pine.GSO.3.96.1001211122115.18945B-100000@delta.ds2.pg.gda.pl> <20001211134133.A8720@faramir.physik.uni-konstanz.de> <3A358CEB.1B986EB7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A358CEB.1B986EB7@mvista.com>; from jsun@mvista.com on Mon, Dec 11, 2000 at 06:26:51PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 11, 2000 at 06:26:51PM -0800, Jun Sun wrote:
> Guido Guenther wrote:
> > 
> > On Mon, Dec 11, 2000 at 12:28:19PM +0100, Maciej W. Rozycki wrote:
> > > friends) by glibc.  At least XFree86 and SVGATextMode make use of these
> > > features.  I suppose it's the same for MIPS (I haven't checked, though).
> > Yes. xf86MapVidMem & friends use /dev/mem to mmap videomemory & iospace
> > independent of architecure.
> >  -- Guido
> 
> 
> I am surprised.  I thought /dev/mem is for accessing SYSTEM RAM.  (do a 'man'
I'd not call it system ram but rather ''visible address space'' or
something. If there's actually ''system ram'' or the fb of a graphics
card at a given address doesn't make a difference.

> on /dev/mem)  It is also confirmed by the code in drivers/char/mem.c.  If you
> want to access anything beyond 'high_memory", nothing is read.  
> 
> Note that drivers/char/mem.c is cross-platform code.  I am not sure how X
> would access video memory through /dev/mem on either MIPS or other platforms.
The newports REX3 for example is at (KSEG1 + 0x1f0f000) which is mmaped
by the xserver to access the REX3s registers.
 -- Guido
