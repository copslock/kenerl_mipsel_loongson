Received:  by oss.sgi.com id <S554040AbRBEWIR>;
	Mon, 5 Feb 2001 14:08:17 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:18902 "EHLO dea.waldorf-gmbh.de")
	by oss.sgi.com with ESMTP id <S553765AbRBEWH5>;
	Mon, 5 Feb 2001 14:07:57 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f15M1E004103;
	Mon, 5 Feb 2001 14:01:14 -0800
Date:   Mon, 5 Feb 2001 14:01:14 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     geert@linux-m68k.org (Geert Uytterhoeven),
        carstenl@mips.com (Carsten Langgaard), linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
Message-ID: <20010205140114.D3880@bacchus.dhis.org>
References: <Pine.GSO.4.10.10102051356090.1124-100000@escobaria.sonytel.be> <E14PlGy-0003IW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14PlGy-0003IW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 05, 2001 at 01:01:33PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Feb 05, 2001 at 01:01:33PM +0000, Alan Cox wrote:

> > Is the zero page mapped on non-m68k architectures?
> 
> It can certainly be hit by DMA and kernel memory ops
> 
> > > I dont believe any 2.4 is currently 'safe'
> > Ugh...
> 
> We'll get there, its doing pretty well for most folks

I hope so.  For many of us 2.2 is no longer an option.  That is at least
without heavy patching to add support for hardware that isn't supported
by 2.2.

  Ralf
