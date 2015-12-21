Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 11:49:15 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:58489 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008272AbbLUKtKV2ziL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Dec 2015 11:49:10 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663E83A8;
        Mon, 21 Dec 2015 02:48:36 -0800 (PST)
Received: from e106497-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1213F24D;
        Mon, 21 Dec 2015 02:49:02 -0800 (PST)
Received: by e106497-lin.cambridge.arm.com (Postfix, from userid 1005)
        id CF265107D8D7; Mon, 21 Dec 2015 10:49:00 +0000 (GMT)
Date:   Mon, 21 Dec 2015 10:49:00 +0000
From:   Liviu.Dudau@arm.com
To:     Matti Laakso <malaakso@elisanet.fi>
Cc:     linux-mips@linux-mips.org
Subject: Re: Unable to allocate PCI I/O resources
Message-ID: <20151221104900.GN960@e106497-lin.cambridge.arm.com>
References: <56732950.4060201@elisanet.fi>
 <20151218114210.GJ960@e106497-lin.cambridge.arm.com>
 <010801d13a6d$31eb3740$95c1a5c0$@elisanet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010801d13a6d$31eb3740$95c1a5c0$@elisanet.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <Liviu.Dudau@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Liviu.Dudau@arm.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, Dec 19, 2015 at 04:54:41PM +0200, Matti Laakso wrote:
> Second try after webmail messed up my first message.
> 
> > On Thu, Dec 17, 2015 at 11:29:52PM +0200, Matti Laakso wrote:
> > > Hello all,
> > > 
> > > I have some oldish MIPS-based (Lantiq Danube) routers that have a PCI 
> > > bus and a VIA 6212 USB-controller connected to it. The USB controller 
> > > requires I/O resources in addition to memory. It seems that with 
> > > kernel
> > > 3.18 and newer PCI I/O resources can no longer be allocated on this 
> > > platform. I tracked the problem down to a patch set from Liviu Dudau 
> > > (Support for creating generic PCI host bridges from DT). After this 
> > > patch the function pci_address_to_pio in drivers/of/address.c hits the 
> > > check
> > >
> > > address > IO_SPACE_LIMIT
> > >
> > > since address on this SoC is 0x1AE00000 and IO_SPACE_LIMIT is 0xFFFF 
> > > on MIPS (PCI_IOBASE is not defined). Changing IO_SPACE_LIMIT to 
> > > 0xFFFFFFFF I can work around the problem, but I think that is not the proper solution.
> >
> > if PCI_IOBASE is not defined then you should not hit the code I have added with commit 41f8bba7f5552d0 but the old code path, in which case I would guess the code was broken before my change?
> >
> 
> Well, before your change of_pci_range_to_resource() simply filled the resource struct without any checks. Now it fills it with OF_BAD_ADDR. Maybe it was broken, but at least it worked in this case.

Yes, but if you look in the git log the change was not due to my commit, but
Rob Herring's 25ff7944 where he removed the MIPS specific version of
pci_address_to_pio(). But even then, that version had a BUG_ON(address > IO_SPACE_LIMIT)
so that would not have worked for you either. And IO_SPACE_LIMIT has been
set to 0xffff since the beginning of GIT history, so there must have been a
different reason why your system worked before.

> 
> > > 
> > > Any ideas on how to fix this?
> > >
> >
> > There is a distinction between IO range being visible from the CPU @ 0x1AE00000 and the IO address being used by the PCI subsystem. The IO address is a bus address and it should be between 0 - IO_SPACE_LIMIT.
> >
> 
> From reading the code in of_pci_range_to_resource() I'd expect pci_address_to_pio(range->cpu_addr) to get the CPU address as its argument. Why is it checked against IO_SPACE_LIMIT? Or is the IO address yet different from PCI address (meaning, range->pci_addr)?

The kernel treats all supported architectures as being x86 compatible. That means the
IO space from a CPU point of view is limited to the [0 - 0xffff] range inside each
bus. Because most non-x86 architectures don't have a special instruction for reading
from IO space, we play various tricks to make the CPU see the flat address, while
still keeping the kernel happy that the IO space is limited on PCI.

Now, of_pci_range_to_resource() is parsing the OF range description that ignores the
kernel internal view of IO space and lists the addresses as seen from CPU point of view
if such limitation did not exist. We use those addresses (stored in range->cpu_addr) to
build the "IO port" address that gets put into the struct resource.

It might be useful if you give a bit more information on your setup. Are you using a
device tree? If so, can you post the PCI node here?

> 
> > I would look into the actual user of pci_address_to_pio(), and maybe define PCI_IOBASE for your platform to tell it where the IO space starts from CPU point of view.

Also, have you tried my suggestion?

> >
> 
> Best regards,
> Matti Laakso
> 

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
