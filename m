Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2008 19:34:29 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:52519 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21860907AbYJSSe1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2008 19:34:27 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1E9463ECA; Sun, 19 Oct 2008 11:34:23 -0700 (PDT)
Message-ID: <48FB7D9E.4030803@ru.mvista.com>
Date:	Sun, 19 Oct 2008 22:34:06 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
References: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Add a helper routine to register tx4938ide driver and use it on
> RBTX4938 board.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
> index af724e5..a5951ed 100644
> --- a/arch/mips/txx9/generic/setup_tx4938.c
> +++ b/arch/mips/txx9/generic/setup_tx4938.c
> @@ -16,6 +16,7 @@
>  #include <linux/param.h>
>  #include <linux/ptrace.h>
>  #include <linux/mtd/physmap.h>
> +#include <linux/platform_device.h>
>  #include <asm/reboot.h>
>  #include <asm/traps.h>
>  #include <asm/txx9irq.h>
> @@ -335,6 +336,43 @@ void __init tx4938_mtd_init(int ch)
>  	txx9_physmap_flash_init(ch, start, size, &pdata);
>  }
>  
> +void __init tx4938_ata_init(unsigned int irq, unsigned int shift, int tune)
> +{
> +	struct platform_device *pdev;
> +	struct resource res[] = {
> +		{
> +			.start = irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};

    Device without a resource for its registers? That's... interesting. :-)

> +	struct tx4938ide_platform_info pdata = {
> +		.ioport_shift = shift,
> +		.gbus_clock = tune ? txx9_gbus_clock : 0,

    Any reason not to supply the GBUS clock?
    I'm afraid you can't just early return from the set_pio_mode() method...

> +	};
> +	int i;
> +
> +	if ((__raw_readq(&tx4938_ccfgptr->pcfg) &
> +	     (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL))
> +	    != TX4938_PCFG_ATA_SEL)
> +		return;
> +	for (i = 0; i < 8; i++) {
> +		/* check EBCCRn.ISA, EBCCRn.BSZ, EBCCRn.ME */
> +		if ((__raw_readq(&tx4938_ebuscptr->cr[i]) & 0x00f00008)
> +		    == 0x00e00008)
> +			break;
> +	}
> +	if (i == 8)
> +		return;
> +	pdata.ebus_ch = i;

    Why not grab the base address from this register as well and put it into 
the resource?

WBR, Sergei
