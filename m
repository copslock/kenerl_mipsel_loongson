Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 16:42:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16018 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024031AbXFKPmL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 16:42:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5BFeLUj022103;
	Mon, 11 Jun 2007 16:40:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5BFeKmp022102;
	Mon, 11 Jun 2007 16:40:20 +0100
Date:	Mon, 11 Jun 2007 16:40:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 01/15] new files for lemote fulong mini-PC support
Message-ID: <20070611154020.GB9778@linux-mips.org>
References: <11811127722019-git-send-email-tiansm@lemote.com> <1181112773134-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181112773134-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 02:52:38PM +0800, tiansm@lemote.com wrote:

So I've taken the whole patch set and combined it into just two separate
patches for the -queue tree.  I combined them because splitting a
patchset into just new and modified files isn't terribly useful way.
Patches should rather be split in a logic way such as "add suport for
new feature x", "cleanup foobar frobnication state engine" or "fix bug y".

A few comments still:

arch/mips/pci/fixup-lm2e.c:

> +int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	unsigned int val;
> +	if (PCI_SLOT(dev->devfn) == 4) {	/* wireless card(notebook) */
> +		dev->irq = BONITO_IRQ_BASE + 26;
> +		return dev->irq;
> +	} else if (PCI_SLOT(dev->devfn) == 5) {	/* via686b */
> +		switch (PCI_FUNC(dev->devfn)) {
> +		case 2:
> +			dev->irq = 10;
> +			break;
> +		case 3:
> +			dev->irq = 11;
> +			break;
> +		case 5:
> +			dev->irq = 9;
> +			break;
> +		}
> +		return dev->irq;
> +	} else if (PCI_SLOT(dev->devfn) == 6) {	/* radeon 7000 */
> +		dev->irq = BONITO_IRQ_BASE + 27;
> +		return dev->irq;
> +	} else if (PCI_SLOT(dev->devfn) == 7) {	/* 8139 */
> +		dev->irq = BONITO_IRQ_BASE + 26;
> +		return dev->irq;
> +	} else if (PCI_SLOT(dev->devfn) == 8) {	/* nec usb */
> +		switch (PCI_FUNC(dev->devfn)) {
> +		case 0:
> +			dev->irq = BONITO_IRQ_BASE + 26;
> +			break;
> +		case 1:
> +			dev->irq = BONITO_IRQ_BASE + 27;
> +			break;
> +		case 2:
> +			dev->irq = BONITO_IRQ_BASE + 28;
> +			break;
> +		}
> +		pci_read_config_dword(dev, 0xe0, &val);
> +		pci_write_config_dword(dev, 0xe0, (val & ~7) | 0x4);
> +		pci_write_config_dword(dev, 0xe4, 1 << 5);
> +		return dev->irq;
> +	} else
> +		return 0;
> +}

The purpose of pcibios_map_irq() is to map PCI slot numbers to host system
interrupt numbers.  PCI-to-PCI bridge may also need to be taken in
consideration, that's why the function also receives a pin number but a
generic standard compliant PCI device only ever uses INTA.

Things not to do:

 o modify the pci_dev structure pointed to by the function's dev argument.
   So I changed the first argument to const struct pci_dev * to make that
   sort of things a bit harder in the future.
 o doing any kind of other initialization.  That sort of stuff should go
   elsewhere such as into a DECLARE_PCI_FIXUP_* call.
 o The generic MIPS PCI code calls pcibios_map_irq() in order when
   initializing dev->irq, so you can't refer to that variable because
   either it's unset or your changes would be overwritten right away.
 o To figure our the interrupt numbers you probably want to look at just
   the slot and pin arguments; PCI_{FUNC,SLOT} like any other dereferencing
   of dev look suspiciously wrong in this function - pcibios_map_irq
   can normally be implemented as just an array lookup, see fixup-malta.c
   or for a slightly more complicated example supporting multiple rather
   different systems fixup-sni.c.

Can you send a patch to fix this, please?  Thanks :-)

> +static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
> +{

> +	printk(KERN_INFO"ac97 interrupt = 9\n");

General comment - your kernel patches are fairly talkative - probably a
bit too much.

> +static void __init loongson2e_fixup_pcimap(struct pci_dev *pdev)
[...]
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2e_fixup_pcimap);

This one doesn't initialize or fixup any PCI device at all so I think
this shold not be implemented as a PCI fixup.  I suggest doing that
before calling register_pci_controller().

> diff --git a/arch/mips/pci/ops-lm2e.c b/arch/mips/pci/ops-lm2e.c

This file could probable be combined with ops-bonito64.c.  After all it's
banging the essentially same hardware.

> diff --git a/include/asm-mips/mach-lemote/bonito.h b/include/asm-mips/mach-lemote/bonito.h
> new file mode 100644
> index 0000000..83f7ac3
> --- /dev/null
> +++ b/include/asm-mips/mach-lemote/bonito.h
> @@ -0,0 +1,381 @@
> +/*
> + * Based on Algorithmics header
> + */

And the original (C) header said:

 * Bonito Register Map
 *
 * This file is the original bonito.h from Algorithmics with minor changes
 * to fit into linux.
 *
 * Copyright (c) 1999 Algorithmics Ltd
 *
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2001 MIPS Technologies, Inc.  All rights reserved.
 *
 * Algorithmics gives permission for anyone to use and modify this file
 * without any obligation or license condition except that you retain
 * this copyright message in any source redistribution in whole or part.

So I did you a favor and put the (C) notice back into place.

Anyway, it seems the Fulong is based on a slightly older Bonito64 version
and both Malta and Fulong can be made to share that header file easily.

A patch to resolve those issues would be appreciated.  Note that now
that I've put the patches into the -queue tree I'd appreciate a patch
relative to that tree which lives at:

    git://git.linux-mips.org/pub/scm/linux-queue.git

If you want to clone this tree and alrady have a copy of the normal
Linux/MIPS git tree on your disk you can speedup the clone by a few orders
of magnitude by using the --reference option like this:

  git clone --reference ~/src/linux/linux-mips \
        git://git.linux-mips.org/pub/scm/linux-queue.git

It will bring down the clone process to something on the order of a
few seconds.

  Ralf
