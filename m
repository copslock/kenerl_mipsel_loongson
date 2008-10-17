Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 15:13:22 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:59339 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21717619AbYJQONP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2008 15:13:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9HEDD6P015180;
	Fri, 17 Oct 2008 15:13:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9HEDAuS015178;
	Fri, 17 Oct 2008 15:13:10 +0100
Date:	Fri, 17 Oct 2008 15:13:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Message-ID: <20081017141310.GA14999@linux-mips.org>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 17, 2008 at 11:08:25PM +0900, Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against current linux-mips tree.
> 
> Changes since v3:
> * more consistent symbol naming
> * handle only DMA mode in set_dma_mode
> * rename tx4939ide_read_and_clear_dma_status to tx4939ide_clear_dma_status
> * use standard ide_read_sff_dma_status in LE mode
> * remove CS5530 workaround from tx4939ide_build_dmatable
> * use ide_host_alloc/ide_host_register instead of ide_host_alloc
> * fold tx4939ide_insw_swap into tx4939ide_input_data_swap
> * more informative printk
> * whitespace cleanups and spelling fixes
> 
>  drivers/ide/Kconfig          |    6 +
>  drivers/ide/mips/Makefile    |    1 +
>  drivers/ide/mips/tx4939ide.c |  755 ++++++++++++++++++++++++++++++++++++++++++

Btw, I don't think architecture specific subdirectories in subsystems are
generally usefull.  Just as in this example this IDE controller happens
only to be in use on a particular MIPS-based SOC but there is nothing
really architecture specific in most such devices.

  Ralf
