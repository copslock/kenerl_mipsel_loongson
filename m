Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 03:25:04 +0000 (GMT)
Received: from p508B5CF9.dip.t-dialin.net ([IPv6:::ffff:80.139.92.249]:17354
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225426AbTLMDZE>; Sat, 13 Dec 2003 03:25:04 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBD3P2oK026667;
	Sat, 13 Dec 2003 04:25:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBD3P1Lt026662;
	Sat, 13 Dec 2003 04:25:01 +0100
Date: Sat, 13 Dec 2003 04:24:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@theIlya.com>, jsun@mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] PCI I/O region starting from zero is valid
Message-ID: <20031213032459.GE22448@linux-mips.org>
References: <Pine.LNX.4.21.0312130147150.24966-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0312130147150.24966-100000@melkor>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 13, 2003 at 01:54:27AM +0100, Vivien Chappelier wrote:

> 	PCI devices can have I/O mapped at a region starting from
> 0x0000. The O2 actually has one of its onboard SCSI controller here...
> This code looks like a incorrect copy/paste from the x86 code where this
> I/O range is used by legacy ISA.
> 
> --- arch/mips/pci/pci.c	2003-11-12 16:51:09.000000000 +0100
> +++ arch/mips/pci/pci.c	2003-12-13 00:57:56.000000000 +0100
> @@ -173,10 +173,6 @@
>  			continue;
>  
>  		r = &dev->resource[idx];
> -		if (!r->start && r->end) {
> -			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> -			return -EINVAL;
> -		}
>  		if (r->flags & IORESOURCE_IO)
>  			cmd |= PCI_COMMAND_IO;
>  		if (r->flags & IORESOURCE_MEM)
> 

I tend to agree with Vivien.  There's another unsolved problem with
pcibios_enable_device - how many resources should it enable?  Jun once
changed it to PCI_NUM_RESOURCES but that broke other systems though it
seems the logic thing to do ...

The code he wants to remove is just a safety check for PCs.  It doesn't
much sense on legacy-free systems and these days less and less MIPS
systems have legacy devices.

I forgot the details but maybe removing above lines will even permit
putting back the change Jun needed, will need to test.

  Ralf
