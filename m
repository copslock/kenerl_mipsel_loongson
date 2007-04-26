Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 16:51:44 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16838 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20023441AbXDZPvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 16:51:42 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l3QFtP9a026458;
	Thu, 26 Apr 2007 16:55:25 +0100
Date:	Thu, 26 Apr 2007 16:55:25 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS ioport_map and Au1xxx PCMCIA
Message-ID: <20070426165525.27bd8a77@the-village.bc.nu>
In-Reply-To: <20070426093515.GA26434@roarinelk.homelinux.net>
References: <20070426093515.GA26434@roarinelk.homelinux.net>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 26 Apr 2007 11:35:15 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Hello,
> 
> the file arch/mips/lib/iomap.c contains this define
> #define PIO_MASK 0x0ffffUL
> 
> which prevents pata_pcmcia with the new devres stuff
> from attaching to a CF card. (on my Au1200).
> The ports-to-be-iomap()'ed are in the 0xc0000000 range
> and the ioport_map() function rejects all attempts
> of pata_pcmcia to devm_ioport_map() them.
> 
> What is this mask used for and can it be removed?

iomap uses PIO_MASK to idenfiy ports within the I/O space range. The mips
code looks somewhat incomplete in the base kernel which is probably much
of the problem.

The basic idea is that ioread/iowrite and friends work generically
regardless of MMIO v PIO so you can just do

	pci_iomap(some bar);
	iowrite(blah);
	pci_iounmap(blah)

and not worry about anything.

Now if your platform doesn't have seperate IO space you could probably
implement iowrite/ioremap/ioport_map to be pretty much no-ops depending
upon how your PCI bars are encoded.

Alan
