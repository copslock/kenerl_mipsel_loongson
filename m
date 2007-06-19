Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 07:01:58 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:6055 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20023384AbXFSGBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 07:01:55 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l5J5wZW0001813
	for <linux-mips@linux-mips.org>; Tue, 19 Jun 2007 01:58:36 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l5J5wZMk003373
	for <linux-mips@linux-mips.org>; Tue, 19 Jun 2007 01:58:35 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l5J5wZ7q003369;
	Tue, 19 Jun 2007 01:58:35 -0400
Received: from 64.148.57.81
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 19 Jun 2007 01:58:35 -0400 (EDT)
Message-ID: <3916.64.148.57.81.1182232715.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
References: <cda58cb80706120255w5ef28123tc27a8152d18e3039@mail.gmail.com>
    <39830.129.133.92.31.1181651585.squirrel@webmail.wesleyan.edu>
    <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
    <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
Date:	Tue, 19 Jun 2007 01:58:35 -0400 (EDT)
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.193
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

First, thanks for the interest.

> On Mon, 18 Jun 2007 12:32:37 -0400 (EDT), sknauert@wesleyan.edu wrote:
>> Justing bumping this topic, I'm really stuck and could use some (any)
>> help
>> here. I understand that people are busy and most effort is focused on
>> 2.6.23, but I haven't received any response regarding my prelimenary
>> patch
>> and its been over a week.
>
> I suppose HAVE_PCI_LEGACY provides us a standard way to access 8/16/32
> bit registers in PCI I/O space, right?

Yes, according to Jesse Barnes' description of the ia64 version:

"The legacy_io file is a read/write file that can be used by applications to
do legacy port I/O.  The application should open the file, seek to the
desired +port (e.g. 0x3e8) and do a read or a write of 1, 2 or 4 bytes.
The legacy_mem +file should be mmapped with an offset corresponding to the
memory offset +desired, e.g. 0xa0000 for the VGA frame buffer. The
application can then +simply dereference the returned pointer (after
checking for errors of course) to access legacy memory space."

More info. here:
http://www.kernel.org/pub/linux/kernel/people/jbarnes/patches/sysfs-legacy-resource-7.patch

>
> If so, it would be great; When I tried to read a 16-bit register in
> PCI I/O space from userland, I had to find a physical address of the
> PCI I/O region and mmap it via /dev/mem, since /dev/port only supports
> 8bit access.
>
> Also I'd suggest to support multiple PCI busses (please refer
> iomap-pci.c):
>
> Something like this:
>
> int pci_legacy_read(struct pci_bus *bus, u16 port, u32 *val, u8 size)
> {
> 	struct pci_controller *ctrl = bus->sysdata;
> 	unsigned long base = ctrl->io_map_base;
> 	void __iomem *addr = (void __iomem *)(ctrl->io_map_base + port);
> 	int ret = size;
>
> 	switch (size) {
> 	case 1:
> 		*val = ioread8(addr);
> 		break;
> 	case 2:
> 		*val = ioread16(addr);
> 		break;
> 	case 4:
> 		*val = ioread32(addr);
> 		break;
> 	default:
> 		ret = -EINVAL;
> 		break;
> 	}
>
> 	return ret;
> }
>

I could be wrong, but I believe it already supports multiple buses some
other way. I get legacy_io, legacy_mem in /sys/class/pci_bus/0000:xx/ for
the three on my O2. If not (I couldn't get any useful io with the
interface files though), I agree something like the above is a great idea.

> Also I think no need to add "mips_" prefix and make aliases. (unless
> we really need to override them for each platform)
>
>> +#define pci_get_legacy_mem mips_pci_get_legacy_mem
>> +#define pci_legacy_read mips_pci_legacy_read
>> +#define pci_legacy_write mips_pci_legacy_write
>

I did define the functions directly as you suggested first, but there were
a bunch of compile errors. Plus, my only example code, the ia64 version of
this did it with an ia64_ prefix. If there is consensus for direct
declaration, I'll glady spend the time to change this (shouldn't be too
hard).

The main part of this code which will probably be platform specific
shouldn't be the legacy functions, but the address offsets as different
hardware may different memory structures so either method should in theory
be okay.

> ---
> Atsushi Nemoto
>
>

Thanks again,
Scott
