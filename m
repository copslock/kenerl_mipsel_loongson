Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 14:13:16 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:55214 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28577379AbYAJONG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 14:13:06 +0000
Received: (qmail 26126 invoked from network); 10 Jan 2008 14:13:04 -0000
Received: from 75-144-238-166-atlanta.hfc.comcastbusiness.net (HELO ?10.41.13.3?) (75.144.238.166)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 10 Jan 2008 07:13:03 -0700
Subject: Re: Linux mips and DMA
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080110134634.GA12060@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
	 <20080110113931.GA4774@linux-mips.org>
	 <1199971818.4344.5.camel@microwave.infinitevideocorporation.com>
	 <20080110134634.GA12060@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 10 Jan 2008 09:12:23 -0500
Message-Id: <1199974344.4344.16.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> Hardware coherency for DMA is the exception for low-end embedded MIPS
> systems andgiven the CPU address your's is no exception from that.
> 
> If your system was supporting hardware coherency for DMA I/O you would
> have obtained a cachable CPU address like:
> 
>   dma_handle=0x026f0000 size=0x00010000 cpu_addr=0x826f0000
>                                                   ^^^
> 
> A 0x8??????? would be in KSEG0 so cachable.

I do have a an embedded system. Are you saying that, in all likelyhood,
I do not have coherency? If I understand you correctly, this is a bad
thing right? Will I need to take extra care to work around this issue.

So are you saying I would prefer a cpu_addr in the 0x8******* range?

If it is true that I don't have hardware coherency should I still be
using the pci_*_consistent api? Or should I switch to the
dma_*_noncoherent api? Also what extra steps do I need to take to get
this to work with a non-coherent system?

I am reading Documentation/DMA-API.txt which has some discussion about
non-coherent systems to see if I can get a handle on this.


> What hardware are you using anyway?

I am using the MDS-810 platform supplied by Momentum Data Systems which
contains a Phillips/Nexperia pnx8950 chip. That chip contains a MIPS32
core. http://www.mds.com/products/product.asp?prod=MDS-810

Thanks again,
Jon
