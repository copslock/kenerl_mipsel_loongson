Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 15:05:20 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:24000 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28577415AbYAJPFL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 15:05:11 +0000
Received: (qmail 7507 invoked from network); 10 Jan 2008 15:05:09 -0000
Received: from 75-144-238-166-atlanta.hfc.comcastbusiness.net (HELO ?10.41.13.3?) (75.144.238.166)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 10 Jan 2008 08:05:08 -0700
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
Date:	Thu, 10 Jan 2008 10:04:29 -0500
Message-Id: <1199977469.4344.23.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> What you were doing seemed to be the right thing.  The API is supposed
> to do the necessary address conversion and cache flushes for the driver.
> That is the unchanged driver should work on any architecture.

> 
> According to the current kernel code the PNX8550 non-coheren (aka software
> coherency).
> 

Thanks Ralf,

So it sounds like you're saying even though my platform does not have HW
coherency, it shouldn't affect the driver code.

In my code, the device creates an interrupt when a message is to be
passed to the host. The message is written in the DMA memory. When I
receive that interrupt, is there some sort of flush I should do to
update the memory the cpu sees, with the data written by the device?

As of right now when I receive the interrupt, then inspect the dma
memory it appears as though nothing was written to memory. So at this
point I left thinking either the device can't correctly write to the
memory, or the memory isn't ready to be read by the host. I am having
trouble discovering which case is actually occurring.

Jon
