Received:  by oss.sgi.com id <S554102AbRBETQ5>;
	Mon, 5 Feb 2001 11:16:57 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:41722 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553987AbRBETQn>;
	Mon, 5 Feb 2001 11:16:43 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f15JDAI31829;
	Mon, 5 Feb 2001 11:13:10 -0800
Message-ID: <3A7EFBC7.9B7D6AF9@mvista.com>
Date:   Mon, 05 Feb 2001 11:15:19 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Quinn Jensen <jensenq@Lineo.COM>
CC:     jsun@hermes.mvista.com, Ralf Baechle <ralf@oss.sgi.com>,
        linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM> <3A7EEBD6.F4743A97@mvista.com> <3A7EF431.2060903@Lineo.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Quinn Jensen wrote:
> 
> jsun@hermes.mvista.com wrote:
> 
> > Quinn Jensen wrote:
> >
> >>>> Is anyone else having trouble with NFS root on
> >>>> the 2.4.0 kernel?  It won't come up with the
> >>>> KSEG0 cache on unless I pepper the network driver
> >>>> with flush calls.
> >>>
> >>>
> >>> That's expected for most old network drivers that don't yet use tye
> he
> >>> new PCI DMA API documented in Documentation/DMA-mapping.txt.
> >>>
> >>> What driver is this?
> >>
> >> Both the stock 2.4.0 tulip and eepro100 drivers.  The
> >> problem doesn't happen when I go back to 2.3.99pre8.
> >>
> >
> > Did you set rx_copybreak to 1518?  I sent patches long time ago to the driver
> > authors for MIPS, but I am not sure they are not there.
> 
> Jun,
> 
> I have tried that in this case but it didn't help,
> because the receive skb data pointers all point to
> the KSEG0 view of the data anyway. 

I looked into similar problems a while back.  If I remeber correctly, the data
pointers do point to kseg0.  It is up to the driver to do appropriate
dma_cache_invalidate() (or some functions to that effect) at certain places.

What is the CPU?  It seems logical to suspect about the dma cache routines.

Jun
