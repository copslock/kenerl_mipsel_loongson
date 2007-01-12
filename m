Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 14:16:49 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([80.176.203.50]:62648 "EHLO
	pangolin.localnet") by ftp.linux-mips.org with ESMTP
	id S28574873AbXALOQo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Jan 2007 14:16:44 +0000
Received: from [192.168.1.21] (hylobates.localnet [192.168.1.21])
	by pangolin.localnet (Postfix) with ESMTP id B50FD1476D9;
	Fri, 12 Jan 2007 14:16:26 +0000 (GMT)
Message-ID: <45A79847.1060302@bitbox.co.uk>
Date:	Fri, 12 Jan 2007 14:16:39 +0000
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net> <20070111143116.GA4451@linux-mips.org>
In-Reply-To: <20070111143116.GA4451@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jan 11, 2007 at 02:55:58PM +0900, Yoichi Yuasa wrote:
> 
>> This patch has fixed IDE resources problem about Cobalt.
>>
>> pcibios_fixup_device_resources() changes non-movable resources.
>> It cannot be changed if there is IORESOURCE_PCI_FIXED in the resource flags. 
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
> 
> Which is what other GT-64120 platforms are using, so I wonder why that is
> different on Cobalt.
> 

The GT-64111 passes the CPU addresses straight onto the PCI bus and does 
not remove the offset of the Galileo's PCI window in CPU space. This 
means the only PCI I/O addresses that can be supported are 0x1000.0000 
to 0x11ff.ffff, hence the negative 'io_offset'.

I assume the GT-64120 remaps the PCI addresses somehow to remove the offset.

P.
