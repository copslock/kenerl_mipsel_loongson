Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2016 08:36:28 +0100 (CET)
Received: from up.free-electrons.com ([163.172.77.33]:47275 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993321AbcKBHgUruUu8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2016 08:36:20 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 2F19720C8C; Wed,  2 Nov 2016 08:36:15 +0100 (CET)
Received: from bbrezillon (LFbn-1-2159-240.w90-76.abo.wanadoo.fr [90.76.216.240])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 0046820646;
        Wed,  2 Nov 2016 08:36:14 +0100 (CET)
Date:   Wed, 2 Nov 2016 08:36:13 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH V4] mtd: nand: add Loongson1 NAND driver
Message-ID: <20161102083613.443bcb10@bbrezillon>
In-Reply-To: <1478051526-7216-1-git-send-email-keguang.zhang@gmail.com>
References: <1478051526-7216-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

On Wed,  2 Nov 2016 09:52:06 +0800
Keguang Zhang <keguang.zhang@gmail.com> wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch adds NAND driver for Loongson1B.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> ---
> v4:
>    Retrieve the controller from nand_hw_control.
> v3:
>    Replace __raw_readl/__raw_writel with readl/writel.
>    Split ls1x_nand into two structures: ls1x_nand_chip and
>    ls1x_nand_controller.
> V2:
>    Modify the dependency in Kconfig due to the changes of DMA
>    module.
> ---
>  drivers/mtd/nand/Kconfig          |   8 +
>  drivers/mtd/nand/Makefile         |   1 +
>  drivers/mtd/nand/loongson1_nand.c | 571 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 580 insertions(+)
>  create mode 100644 drivers/mtd/nand/loongson1_nand.c
> 

[...]

> +static void ls1x_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
> +			      int column, int page_addr)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc =
> +	    to_ls1x_nand_controller(chip->controller);
> +
> +	dev_dbg(mtd->dev.parent, "cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
> +		command, column, page_addr);
> +
> +	if (command == NAND_CMD_RNDOUT) {
> +		nandc->buf_off = column;
> +		return;
> +	}
> +
> +	/*set address, buffer length and buffer offset */
> +	if (column != -1 || page_addr != -1)
> +		set_addr_len(mtd, command, column, page_addr);
> +
> +	/*prepare NAND command */
> +	switch (command) {
> +	case NAND_CMD_RESET:
> +		nandc->cmd_ctrl = CMD_RESET;
> +		break;
> +	case NAND_CMD_STATUS:
> +		nandc->cmd_ctrl = CMD_STATUS;
> +		break;
> +	case NAND_CMD_READID:
> +		nandc->cmd_ctrl = CMD_READID;
> +		break;
> +	case NAND_CMD_READ0:
> +		nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_READ;
> +		break;
> +	case NAND_CMD_READOOB:
> +		nandc->cmd_ctrl = OP_SPARE | CMD_READ;
> +		break;
> +	case NAND_CMD_ERASE1:
> +		nandc->cmd_ctrl = CMD_ERASE;
> +		break;
> +	case NAND_CMD_PAGEPROG:
> +		break;
> +	case NAND_CMD_SEQIN:
> +		if (column < mtd->writesize)
> +			nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_WRITE;
> +		else
> +			nandc->cmd_ctrl = OP_SPARE | CMD_WRITE;
> +	default:
> +		return;
> +	}

Sorry, but I'm still convinced this driver does not fit in the NAND
subsystem, or at least not the one we have now.

You're just supporting a limited number of the commands a raw NAND can
support (for example, no SET_FEATURE support, which is required for
ONFI NANDs), and your ->cmdfunc() implementation clearly shows that
you're converting all low-level commands into high-level ones.

Can you try to implement the mtd_info hooks directly? This only things
you'll miss are the nand_ids table and the BBT code, but I guess this is
something we can expose so that you don't have to re-use it.

Of course, you'll also have to convert absolute addresses into
page/block numbers, but that's not the hard part of the job.

You may also want to have a look at [1]. I started to abstract away the
NAND interface type to share some code between SPI NANDs and raw NANDs.
By implementing this interface, you'll at least be able to re-use the
BBT code.

I'm really sorry to ask you that now, after you've reworked most of the
driver to address my comments, but the more I look at it the more I
feel it's just a big hack to make it fit in a framework that was not
designed to support such "high-level" controllers.

Regards,

Boris

> +
> +	/*set NAND command */
> +	set_cmd(nandc, nandc->cmd_ctrl);
> +	/*trigger NAND operation */
> +	start_nand(nandc);
> +	/*trigger DMA for R/W operation */
> +	if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
> +		start_dma(mtd, nandc->buf_len, false);
> +	else if (command == NAND_CMD_PAGEPROG)
> +		start_dma(mtd, nandc->buf_len, true);
> +	nand_wait_ready(mtd);
> +
> +	if (command == NAND_CMD_STATUS) {
> +		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_STATUS) >> 8);
> +		/*work around hardware bug for invalid STATUS */
> +		nandc->datareg[0] |= 0xc0;
> +		nandc->data_ptr = nandc->datareg;
> +	} else if (command == NAND_CMD_READID) {
> +		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_IDH));
> +		nandc->datareg[1] = (char)(nand_readl(nandc, NAND_IDL) >> 24);
> +		nandc->datareg[2] = (char)(nand_readl(nandc, NAND_IDL) >> 16);
> +		nandc->datareg[3] = (char)(nand_readl(nandc, NAND_IDL) >> 8);
> +		nandc->datareg[4] = (char)(nand_readl(nandc, NAND_IDL));
> +		nandc->data_ptr = nandc->datareg;
> +	}
> +
> +	nandc->cmd_ctrl = 0;
> +}

[1]http://lkml.iu.edu/hypermail/linux/kernel/1610.2/00066.html
