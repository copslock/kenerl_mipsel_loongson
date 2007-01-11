Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 14:48:01 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:13317 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28580544AbXAKOrz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2007 14:47:55 +0000
Received: by mo.po.2iij.net (mo32) id l0BElr1c054824; Thu, 11 Jan 2007 23:47:53 +0900 (JST)
Received: from localhost.localdomain (45.28.30.125.dy.iij4u.or.jp [125.30.28.45])
	by mbox.po.2iij.net (mbox32) id l0BEllGG001929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Jan 2007 23:47:47 +0900 (JST)
Date:	Thu, 11 Jan 2007 23:47:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-Id: <20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070111143116.GA4451@linux-mips.org>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 11 Jan 2007 14:31:16 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Jan 11, 2007 at 02:55:58PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has fixed IDE resources problem about Cobalt.
> > 
> > pcibios_fixup_device_resources() changes non-movable resources.
> > It cannot be changed if there is IORESOURCE_PCI_FIXED in the resource flags. 
> 
> <Ralf> anemo: Have you seen Yoichi's patch?
> <anemo> Ralf: yes, but I could not see why ...  My impression is IORESOURCE_PCI_FIXED and io_offset adjustment is irrerevant.
> <Ralf> This whole fixup thing is really meant to handle machines where there is an offset between PCI bus addresses and CPU physical addresses.
> <Ralf> And that exists regardless of IORESOURCE_PCI_FIXED
> <anemo> I thought so too.  So I can not see why youichi's patch fix something.
> <Ralf> This may be the explanation:
> <Ralf> static struct pci_controller cobalt_pci_controller = {
> <Ralf>         .pci_ops        = &gt64111_pci_ops,
> <Ralf>         .mem_resource   = &cobalt_mem_resource,
> <Ralf>         .mem_offset     = 0,
> <Ralf>         .io_resource    = &cobalt_io_resource,
> <Ralf>         .io_offset      = 0 - GT_DEF_PCI0_IO_BASE,
> <Ralf> };
> <Ralf> I think he should have io_offset = 0.

When I tried io_offset = 0, tulip net driver didn't work.

> Which is what other GT-64120 platforms are using, so I wonder why that is
> different on Cobalt.

I don't know, but io_offset is needed for Cobalt.

Yoichi
