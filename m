Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 14:29:33 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12495 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S28575042AbXALO33 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Jan 2007 14:29:29 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id l0CEeg6d030870;
	Fri, 12 Jan 2007 14:40:43 GMT
Date:	Fri, 12 Jan 2007 14:40:42 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	Peter Horton <phorton@bitbox.co.uk>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-ID: <20070112144042.74c4edca@localhost.localdomain>
In-Reply-To: <45A79847.1060302@bitbox.co.uk>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
	<45A79847.1060302@bitbox.co.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 12 Jan 2007 14:16:39 +0000
Peter Horton <phorton@bitbox.co.uk> wrote:

> Ralf Baechle wrote:
> > On Thu, Jan 11, 2007 at 02:55:58PM +0900, Yoichi Yuasa wrote:
> > 
> >> This patch has fixed IDE resources problem about Cobalt.
> >>
> >> pcibios_fixup_device_resources() changes non-movable resources.
> >> It cannot be changed if there is IORESOURCE_PCI_FIXED in the resource flags. 
> > 
> > <Ralf> anemo: Have you seen Yoichi's patch?
> > <anemo> Ralf: yes, but I could not see why ...  My impression is IORESOURCE_PCI_FIXED and io_offset adjustment is irrerevant.
> > <Ralf> This whole fixup thing is really meant to handle machines where there is an offset between PCI bus addresses and CPU physical addresses.
> > <Ralf> And that exists regardless of IORESOURCE_PCI_FIXED
> > <anemo> I thought so too.  So I can not see why youichi's patch fix something.
> > <Ralf> This may be the explanation:
> > <Ralf> static struct pci_controller cobalt_pci_controller = {
> > <Ralf>         .pci_ops        = &gt64111_pci_ops,
> > <Ralf>         .mem_resource   = &cobalt_mem_resource,
> > <Ralf>         .mem_offset     = 0,
> > <Ralf>         .io_resource    = &cobalt_io_resource,
> > <Ralf>         .io_offset      = 0 - GT_DEF_PCI0_IO_BASE,
> > <Ralf> };
> > <Ralf> I think he should have io_offset = 0.
> > 
> > Which is what other GT-64120 platforms are using, so I wonder why that is
> > different on Cobalt.
> > 
> 
> The GT-64111 passes the CPU addresses straight onto the PCI bus and does 
> not remove the offset of the Galileo's PCI window in CPU space. This 
> means the only PCI I/O addresses that can be supported are 0x1000.0000 
> to 0x11ff.ffff, hence the negative 'io_offset'.
> 
> I assume the GT-64120 remaps the PCI addresses somehow to remove the offset.
> 
> P.


-- 
--
Sick of rip off UK rail fares ? Learn how to get far cheaper fares
		http://zeniv.linux.org.uk/~alan/GTR/
