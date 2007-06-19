Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 04:11:02 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11492 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021351AbXFSDLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 04:11:00 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 19 Jun 2007 12:10:58 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3F430416FC;
	Tue, 19 Jun 2007 12:10:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2ADFB2093B;
	Tue, 19 Jun 2007 12:10:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5J3AVAF000616;
	Tue, 19 Jun 2007 12:10:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 19 Jun 2007 12:10:30 +0900 (JST)
Message-Id: <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
References: <cda58cb80706120255w5ef28123tc27a8152d18e3039@mail.gmail.com>
	<39830.129.133.92.31.1181651585.squirrel@webmail.wesleyan.edu>
	<54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 Jun 2007 12:32:37 -0400 (EDT), sknauert@wesleyan.edu wrote:
> Justing bumping this topic, I'm really stuck and could use some (any) help
> here. I understand that people are busy and most effort is focused on
> 2.6.23, but I haven't received any response regarding my prelimenary patch
> and its been over a week.

I suppose HAVE_PCI_LEGACY provides us a standard way to access 8/16/32
bit registers in PCI I/O space, right?

If so, it would be great; When I tried to read a 16-bit register in
PCI I/O space from userland, I had to find a physical address of the
PCI I/O region and mmap it via /dev/mem, since /dev/port only supports
8bit access.

Also I'd suggest to support multiple PCI busses (please refer iomap-pci.c):

Something like this:

int pci_legacy_read(struct pci_bus *bus, u16 port, u32 *val, u8 size)
{
	struct pci_controller *ctrl = bus->sysdata;
	unsigned long base = ctrl->io_map_base;
	void __iomem *addr = (void __iomem *)(ctrl->io_map_base + port);
	int ret = size;

	switch (size) {
	case 1:
		*val = ioread8(addr);
		break;
	case 2:
		*val = ioread16(addr);
		break;
	case 4:
		*val = ioread32(addr);
		break;
	default:
		ret = -EINVAL;
		break;
	}

	return ret;
}

Also I think no need to add "mips_" prefix and make aliases. (unless
we really need to override them for each platform)

> +#define pci_get_legacy_mem mips_pci_get_legacy_mem
> +#define pci_legacy_read mips_pci_legacy_read
> +#define pci_legacy_write mips_pci_legacy_write

---
Atsushi Nemoto
