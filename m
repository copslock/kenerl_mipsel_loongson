Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 18:46:13 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:12559 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022368AbXDZRqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 18:46:12 +0100
Received: (qmail 27735 invoked by uid 1000); 26 Apr 2007 19:45:08 +0200
Date:	Thu, 26 Apr 2007 19:45:08 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS ioport_map and Au1xxx PCMCIA
Message-ID: <20070426174508.GB27510@roarinelk.homelinux.net>
References: <20070426093515.GA26434@roarinelk.homelinux.net> <20070426165525.27bd8a77@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070426165525.27bd8a77@the-village.bc.nu>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Apr 26, 2007 at 04:55:25PM +0100, Alan Cox wrote:
> iomap uses PIO_MASK to idenfiy ports within the I/O space range. The mips
> code looks somewhat incomplete in the base kernel which is probably much
> of the problem.
> 
> The basic idea is that ioread/iowrite and friends work generically
> regardless of MMIO v PIO so you can just do
> 
> 	pci_iomap(some bar);
> 	iowrite(blah);
> 	pci_iounmap(blah)
> 
> and not worry about anything.
> 
> Now if your platform doesn't have seperate IO space you could probably
> implement iowrite/ioremap/ioport_map to be pretty much no-ops depending
> upon how your PCI bars are encoded.

This Au1200 doesn't have PCI; to access the PCMCIA IO space one has
to ioremap() a part from the top of the 36bit space.

I took the cheap route and simply removed the PIO_MASK check
from my local kernel.

Thank you,

-- 
 Manuel Lauss
