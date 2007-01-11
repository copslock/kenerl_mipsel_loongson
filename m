Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 14:30:31 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:14313 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20046744AbXAKOa3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jan 2007 14:30:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0BEVI0t004534;
	Thu, 11 Jan 2007 14:31:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0BEVGGj004533;
	Thu, 11 Jan 2007 14:31:16 GMT
Date:	Thu, 11 Jan 2007 14:31:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-ID: <20070111143116.GA4451@linux-mips.org>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 11, 2007 at 02:55:58PM +0900, Yoichi Yuasa wrote:

> This patch has fixed IDE resources problem about Cobalt.
> 
> pcibios_fixup_device_resources() changes non-movable resources.
> It cannot be changed if there is IORESOURCE_PCI_FIXED in the resource flags. 

<Ralf> anemo: Have you seen Yoichi's patch?
<anemo> Ralf: yes, but I could not see why ...  My impression is IORESOURCE_PCI_FIXED and io_offset adjustment is irrerevant.
<Ralf> This whole fixup thing is really meant to handle machines where there is an offset between PCI bus addresses and CPU physical addresses.
<Ralf> And that exists regardless of IORESOURCE_PCI_FIXED
<anemo> I thought so too.  So I can not see why youichi's patch fix something.
<Ralf> This may be the explanation:
<Ralf> static struct pci_controller cobalt_pci_controller = {
<Ralf>         .pci_ops        = &gt64111_pci_ops,
<Ralf>         .mem_resource   = &cobalt_mem_resource,
<Ralf>         .mem_offset     = 0,
<Ralf>         .io_resource    = &cobalt_io_resource,
<Ralf>         .io_offset      = 0 - GT_DEF_PCI0_IO_BASE,
<Ralf> };
<Ralf> I think he should have io_offset = 0.

Which is what other GT-64120 platforms are using, so I wonder why that is
different on Cobalt.

  Ralf
