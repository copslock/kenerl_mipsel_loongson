Received:  by oss.sgi.com id <S554032AbRBESIp>;
	Mon, 5 Feb 2001 10:08:45 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:36085 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554024AbRBESIl>;
	Mon, 5 Feb 2001 10:08:41 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f15I59I27128;
	Mon, 5 Feb 2001 10:05:09 -0800
Message-ID: <3A7EEBD6.F4743A97@mvista.com>
Date:   Mon, 05 Feb 2001 10:07:18 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Quinn Jensen <jensenq@Lineo.COM>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Quinn Jensen wrote:
> 
> >> Is anyone else having trouble with NFS root on
> >> the 2.4.0 kernel?  It won't come up with the
> >> KSEG0 cache on unless I pepper the network driver
> >> with flush calls.
> >
> >
> > That's expected for most old network drivers that don't yet use the
> > new PCI DMA API documented in Documentation/DMA-mapping.txt.
> >
> > What driver is this?
> 
> Both the stock 2.4.0 tulip and eepro100 drivers.  The
> problem doesn't happen when I go back to 2.3.99pre8.
> 

Quinn,

Did you set rx_copybreak to 1518?  I sent patches long time ago to the driver
authors for MIPS, but I am not sure they are not there.

Jun
