Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Nov 2005 19:48:45 +0000 (GMT)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:57688 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8136324AbVKMTs0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Nov 2005 19:48:26 +0000
Received: (qmail 60682 invoked from network); 13 Nov 2005 19:50:09 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 13 Nov 2005 19:50:08 -0000
Subject: Re: [Fwd: mtd/drivers/mtd/nand au1550nd.c,1.13,1.14]
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Linux MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <43779854.5040307@ru.mvista.com>
References: <43779854.5040307@ru.mvista.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Sun, 13 Nov 2005 11:49:59 -0800
Message-Id: <1131911400.11644.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Sun, 2005-11-13 at 22:47 +0300, Sergei Shtylylov wrote:
> Hello.
> 
>     Thought it's worth forwarding this here...

Just FYI, the patch is in the mtd tree only right now. It will get to
linux-mips when Ralf does a pull.

Pete

> -------- Original Message --------
> Subject: mtd/drivers/mtd/nand au1550nd.c,1.13,1.14
> Date: Sun, 13 Nov 2005 09:52:10 +0000
> From: ppopov@infradead.org
> To: linux-mtd-cvs@lists.infradead.org
> 
> Update of /home/cvs/mtd/drivers/mtd/nand
> In directory phoenix.infradead.org:/tmp/cvs-serv4485/drivers/mtd/nand
> 
> Modified Files:
> 	au1550nd.c
> Log Message:
> 1. MEM_STNDCTL is write only.
> 2. Patch for problem with static bus controller which fails to keep
> CE asserted during chip ready delay on read commands. The problem was
> documented by Sergei Shtylylov; patch by the same author.
> 
> 
> Index: au1550nd.c
> ===================================================================
> RCS file: /home/cvs/mtd/drivers/mtd/nand/au1550nd.c,v
> retrieving revision 1.13
> retrieving revision 1.14
> diff -u -r1.13 -r1.14
> --- au1550nd.c	7 Nov 2005 11:14:30 -0000	1.13
> +++ au1550nd.c	13 Nov 2005 09:52:07 -0000	1.14
> @@ -14,9 +14,11 @@
>   #include <linux/slab.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
> +#include <linux/interrupt.h>
>   #include <linux/mtd/mtd.h>
>   #include <linux/mtd/nand.h>
>   #include <linux/mtd/partitions.h>
> +#include <linux/version.h>
>   #include <asm/io.h>
> 
>   /* fixme: this is ugly */
> @@ -313,6 +315,141 @@
>   	return ret;
>   }
> 
> +/**
> + * au1550_select_chip - control -CE line
> + *	Forbid driving -CE manually permitting the NAND controller to do this.
> + *	Keeping -CE asserted during the whole sector reads interferes with the
> + *	NOR flash and PCMCIA drivers as it causes contention on the static bus.
> + *	We only have to hold -CE low for the NAND read commands since the flash
> + *	chip needs it to be asserted during chip not ready time but the NAND
> + *	controller keeps it released.
> + *
> + * @mtd:	MTD device structure
> + * @chip:	chipnumber to select, -1 for deselect
> + */
> +static void au1550_select_chip(struct mtd_info *mtd, int chip)
> +{
> +}
> +
> +/**
> + * au1550_command - Send command to NAND device
> + * @mtd:	MTD device structure
> + * @command:	the command to be sent
> + * @column:	the column address for this command, -1 if none
> + * @page_addr:	the page address for this command, -1 if none
> + */
> +static void au1550_command(struct mtd_info *mtd, unsigned command, int 
> column, int page_addr)
> +{
> +	register struct nand_chip *this = mtd->priv;
> +	int ce_override = 0, i;
> +	ulong flags;
> +
> +	/* Begin command latch cycle */
> +	this->hwcontrol(mtd, NAND_CTL_SETCLE);
> +	/*
> +	 * Write out the command to the device.
> +	 */
> +	if (command == NAND_CMD_SEQIN) {
> +		int readcmd;
> +
> +		if (column >= mtd->oobblock) {
> +			/* OOB area */
> +			column -= mtd->oobblock;
> +			readcmd = NAND_CMD_READOOB;
> +		} else if (column < 256) {
> +			/* First 256 bytes --> READ0 */
> +			readcmd = NAND_CMD_READ0;
> +		} else {
> +			column -= 256;
> +			readcmd = NAND_CMD_READ1;
> +		}
> +		this->write_byte(mtd, readcmd);
> +	}
> +	this->write_byte(mtd, command);
> +
> +	/* Set ALE and clear CLE to start address cycle */
> +	this->hwcontrol(mtd, NAND_CTL_CLRCLE);
> +
> +	if (column != -1 || page_addr != -1) {
> +		this->hwcontrol(mtd, NAND_CTL_SETALE);
> +
> +		/* Serially input address */
> +		if (column != -1) {
> +			/* Adjust columns for 16 bit buswidth */
> +			if (this->options & NAND_BUSWIDTH_16)
> +				column >>= 1;
> +			this->write_byte(mtd, column);
> +		}
> +		if (page_addr != -1) {
> +			this->write_byte(mtd, (u8)(page_addr & 0xff));
> +
> +			if (command == NAND_CMD_READ0 ||
> +			    command == NAND_CMD_READ1 ||
> +			    command == NAND_CMD_READOOB) {
> +				/*
> +				 * NAND controller will release -CE after
> +				 * the last address byte is written, so we'll
> +				 * have to forcibly assert it. No interrupts
> +				 * are allowed while we do this as we don't
> +				 * want the NOR flash or PCMCIA drivers to
> +				 * steal our precious bytes of data...
> +				 */
> +				ce_override = 1;
> +				local_irq_save(flags);
> +				this->hwcontrol(mtd, NAND_CTL_SETNCE);
> +			}
> +
> +			this->write_byte(mtd, (u8)(page_addr >> 8));
> +
> +			/* One more address cycle for devices > 32MiB */
> +			if (this->chipsize > (32 << 20))
> +				this->write_byte(mtd, (u8)((page_addr >> 16) & 0x0f));
> +		}
> +		/* Latch in address */
> +		this->hwcontrol(mtd, NAND_CTL_CLRALE);
> +	}
> +
> +	/*
> +	 * Program and erase have their own busy handlers.
> +	 * Status and sequential in need no delay.
> +	 */
> +	switch (command) {
> +
> +	case NAND_CMD_PAGEPROG:
> +	case NAND_CMD_ERASE1:
> +	case NAND_CMD_ERASE2:
> +	case NAND_CMD_SEQIN:
> +	case NAND_CMD_STATUS:
> +		return;
> +
> +	case NAND_CMD_RESET:
> +		break;
> +
> +	case NAND_CMD_READ0:
> +	case NAND_CMD_READ1:
> +	case NAND_CMD_READOOB:
> +		/* Check if we're really driving -CE low (just in case) */
> +		if (unlikely(!ce_override))
> +			break;
> +
> +		/* Apply a short delay always to ensure that we do wait tWB. */
> +		ndelay(100);
> +		/* Wait for a chip to become ready... */
> +		for (i = this->chip_delay; !this->dev_ready(mtd) && i > 0; --i)
> +			udelay(1);
> +
> +		/* Release -CE and re-enable interrupts. */
> +		this->hwcontrol(mtd, NAND_CTL_CLRNCE);
> +		local_irq_restore(flags);
> +		return;
> +	}
> +	/* Apply this short delay always to ensure that we do wait tWB. */
> +	ndelay(100);
> +
> +	while(!this->dev_ready(mtd));
> +}
> +
> +
>   /*
>    * Main initialization routine
>    */
> @@ -342,12 +479,8 @@
>   	/* Link the private data with the MTD structure */
>   	au1550_mtd->priv = this;
> 
> -
> -	/* disable interrupts */
> -	au_writel(au_readl(MEM_STNDCTL) & ~(1<<8), MEM_STNDCTL);
> -
> -	/* disable NAND boot */
> -	au_writel(au_readl(MEM_STNDCTL) & ~(1<<0), MEM_STNDCTL);
> + 	/* MEM_STNDCTL: disable ints, disable nand boot */
> + 	au_writel(0, MEM_STNDCTL);
> 
>   #ifdef CONFIG_MIPS_PB1550
>   	/* set gpio206 high */
> @@ -437,6 +570,9 @@
>   	/* Set address of hardware control function */
>   	this->hwcontrol = au1550_hwcontrol;
>   	this->dev_ready = au1550_device_ready;
> +	this->select_chip = au1550_select_chip;
> +	this->cmdfunc = au1550_command;
> +
>   	/* 30 us command delay time */
>   	this->chip_delay = 30;
>   	this->eccmode = NAND_ECC_SOFT;
> 
> 
> __________________________________________________________
> Linux-MTD CVS commit list
> http://lists.infradead.org/mailman/listinfo/linux-mtd-cvs/
> 
> 
> 
