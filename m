Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 13:46:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14977 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577281AbYAJNqt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 13:46:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0ADkZXu012756;
	Thu, 10 Jan 2008 13:46:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0ADkYDG012755;
	Thu, 10 Jan 2008 13:46:34 GMT
Date:	Thu, 10 Jan 2008 13:46:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux mips and DMA
Message-ID: <20080110134634.GA12060@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com> <20080110113931.GA4774@linux-mips.org> <1199971818.4344.5.camel@microwave.infinitevideocorporation.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1199971818.4344.5.camel@microwave.infinitevideocorporation.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 08:30:16AM -0500, Jon Dufresne wrote:

> > MIPS hardware is different so pci_alloc_consistent is implemented
> > differently.  For correct use however this should not matter.  Any bugs
> > you may find porting to MIPS were already bugs on x86.
> > 
> > (Or in pci_alloc_consistent but I'm optimistic ;-)
> 
> 
> Is there a chance that my platform does not support coherent DMA
> mappings? Or is this unheard of for a MIPs platform?

Hardware coherency for DMA is the exception for low-end embedded MIPS
systems andgiven the CPU address your's is no exception from that.

If your system was supporting hardware coherency for DMA I/O you would
have obtained a cachable CPU address like:

  dma_handle=0x026f0000 size=0x00010000 cpu_addr=0x826f0000
                                                  ^^^

A 0x8??????? would be in KSEG0 so cachable.

What hardware are you using anyway?

  Ralf
