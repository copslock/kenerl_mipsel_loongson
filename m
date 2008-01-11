Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 16:08:53 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:34724 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28579704AbYAKQIo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 16:08:44 +0000
Received: (qmail 5461 invoked from network); 11 Jan 2008 16:08:42 -0000
Received: from 75-144-238-166-atlanta.hfc.comcastbusiness.net (HELO ?10.41.13.3?) (75.144.238.166)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 11 Jan 2008 09:08:40 -0700
Subject: Re: Linux mips and DMA
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080110143142.GA13210@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
	 <20080110113931.GA4774@linux-mips.org>
	 <1199971818.4344.5.camel@microwave.infinitevideocorporation.com>
	 <20080110134634.GA12060@linux-mips.org>
	 <1199974344.4344.16.camel@microwave.infinitevideocorporation.com>
	 <20080110143142.GA13210@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 11 Jan 2008 11:08:00 -0500
Message-Id: <1200067681.3349.3.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips


> > > Hardware coherency for DMA is the exception for low-end embedded MIPS
> > > systems andgiven the CPU address your's is no exception from that.
> > > 
> > > If your system was supporting hardware coherency for DMA I/O you would
> > > have obtained a cachable CPU address like:
> > > 
> > >   dma_handle=0x026f0000 size=0x00010000 cpu_addr=0x826f0000
> > >                                                   ^^^
> > > 
> > > A 0x8??????? would be in KSEG0 so cachable.
> > 
> > I do have a an embedded system. Are you saying that, in all likelyhood,
> > I do not have coherency? If I understand you correctly, this is a bad
> > thing right? Will I need to take extra care to work around this issue.
> > 
> > So are you saying I would prefer a cpu_addr in the 0x8******* range?
> 
> No. because you don't seem to have hw coherency.

So, the address I received is in uncachable memory, and therefore,
should look the same to all devices on the bus without hw cache
coherency?

> 
> > If it is true that I don't have hardware coherency should I still be
> > using the pci_*_consistent api? Or should I switch to the
> > dma_*_noncoherent api? Also what extra steps do I need to take to get
> > this to work with a non-coherent system?
> 
> What you were doing seemed to be the right thing.  The API is supposed
> to do the necessary address conversion and cache flushes for the driver.
> That is the unchanged driver should work on any architecture.

Should I need to do any explicit cache flushes in my code for hardware
without cache coherency? If I wanted to do this what function should I
use?


> According to the current kernel code the PNX8550 non-coheren (aka software
> coherency).

Will this be a problem for what I'm trying to accomplish? That is dma on
a pci device.

Thanks,
Jon
