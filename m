Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 22:58:58 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:8424 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20277514AbYIQV6w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 22:58:52 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Kg52r-0004n4-Rd; Wed, 17 Sep 2008 21:58:47 +0000
Message-ID: <48D17D95.6050008@garzik.org>
Date:	Wed, 17 Sep 2008 17:58:45 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080916.
> 
> Changes since v1:
> * rework IO accessors
> * rework pio/dma timing setup
> * use ide_get_pair_dev
> * do not do ATA hard reset
> * and so on  (Many thanks to Sergei)
> 
>  drivers/ide/Kconfig          |    6 +
>  drivers/ide/mips/Makefile    |    1 +
>  drivers/ide/mips/tx4939ide.c |  744 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 751 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ide/mips/tx4939ide.c

I hope a libata driver is coming, too?
