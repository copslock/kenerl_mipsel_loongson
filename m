Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 12:17:51 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:2682 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225196AbTDVLRu>;
	Tue, 22 Apr 2003 12:17:50 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 67FC5729; Tue, 22 Apr 2003 13:17:21 +0200 (CEST)
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] TANBAC TB0226(NEC VR4131) for v2.5
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030422191137.4ac88897.yuasa@hh.iij4u.or.jp> (Yoichi Yuasa's
 message of "Tue, 22 Apr 2003 19:11:37 +0900")
References: <20030422191137.4ac88897.yuasa@hh.iij4u.or.jp>
Date: Tue, 22 Apr 2003 13:17:21 +0200
Message-ID: <86lly2ixxa.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "yoichi" == Yoichi Yuasa <yuasa@hh.iij4u.or.jp> writes:

Hi
        a couple of comments.

Later, Juan.

yoichi> diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
yoichi> --- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Jan  1 09:00:00 1970
yoichi> +++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Tue Apr 22 17:55:33 2003
yoichi> +
yoichi> +#ifdef CONFIG_PCI
yoichi> +static struct resource vr41xx_pci_io_resource = {
yoichi> +	"PCI I/O space",
yoichi> +	VR41XX_PCI_IO_START,
yoichi> +	VR41XX_PCI_IO_END,
yoichi> +	IORESOURCE_IO
yoichi> +};
yoichi> +
yoichi> +static struct resource vr41xx_pci_mem_resource = {
yoichi> +	"PCI memory space",
yoichi> +	VR41XX_PCI_MEM_START,
yoichi> +	VR41XX_PCI_MEM_END,
yoichi> +	IORESOURCE_MEM
yoichi> +};

Please, use C99 named initializers in the whole file.

yoichi> +
yoichi> +extern struct pci_ops vr41xx_pci_ops;
yoichi> +
yoichi> +struct pci_channel mips_pci_channels[] = {
yoichi> +	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
yoichi> +	{NULL, NULL, NULL, 0, 0}
yoichi> +};
yoichi> +
yoichi> +struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
yoichi> +	VR41XX_PCI_MEM1_BASE,
yoichi> +	VR41XX_PCI_MEM1_MASK,
yoichi> +	IO_MEM1_RESOURCE_START
yoichi> +};
yoichi> +
yoichi> +struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
yoichi> +	VR41XX_PCI_MEM2_BASE,
yoichi> +	VR41XX_PCI_MEM2_MASK,
yoichi> +	IO_MEM2_RESOURCE_START
yoichi> +};
yoichi> +
yoichi> +struct vr41xx_pci_address_space vr41xx_pci_io = {
yoichi> +	VR41XX_PCI_IO_BASE,
yoichi> +	VR41XX_PCI_IO_MASK,
yoichi> +	IO_PORT_RESOURCE_START
yoichi> +};
yoichi> +
yoichi> +static struct vr41xx_pci_address_map pci_address_map = {
yoichi> +	&vr41xx_pci_mem1,
yoichi> +	&vr41xx_pci_mem2,
yoichi> +	&vr41xx_pci_io
yoichi> +};
yoichi> +#endif

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
