Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 10:17:47 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:39117
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225232AbTE0JRo>; Tue, 27 May 2003 10:17:44 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R9HgbY023487;
	Tue, 27 May 2003 02:17:42 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R9Heid023486;
	Tue, 27 May 2003 11:17:40 +0200
Date: Tue, 27 May 2003 11:17:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: pci_alloc_consistent usage
Message-ID: <20030527091740.GA23296@linux-mips.org>
References: <20030523215935.71373.qmail@web11901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523215935.71373.qmail@web11901.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 23, 2003 at 02:59:35PM -0700, Wayne Gowcher wrote:

> Where PAGE_OFFSET is 0x8000 0000, and where PHYSADDR
> would AND the address against 0x1FFF FFFF. As far as I
> can tell the problem comes from pci_alloc_consistent
> doing :
> 
> ret = UNCAC_ADDR(ret) 
> 
> which converts a 0x8xxx address to 0xAxxx, and then
> when you pass this 0xAxxx_xxxx address through
> virt_to_phys() you get an address of the form
> 0x2xxx_xxxx. This 0x2xxx_xxxx is passed to the dma
> controller as the physical address to where it must
> read / write data, and because it is 0x2xxx_xxxx and
> not 0x0xxx_xxxx an exception occurs.

The change was partly done to catch broken code, partly because a
subtraction is potencially faster on some processors.

> At first I just tried AND'ing out the 0xA.. like
> PHYSADDR used to do it, but with that change i no
> longer get the exception, but the driver does not dma
> the data across - it just sits there.
> 
> I read DMA-mapping.txt and it says virt_to_phys() will
> be phased out, and should be used, but doesn't
> elaborate any further (like how you should do it now).

Use the value returned by pci_alloc_consistent in *dma_handle instead
of trying to do any conversions with of pci_alloc_consistent's return
value.

  Ralf
