Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2012 12:22:27 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:45730 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903722Ab2BALWR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Feb 2012 12:22:17 +0100
Received: from [192.168.108.17] (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id CA5194C8379;
        Wed,  1 Feb 2012 12:22:10 +0100 (CET)
Subject: Re: [PATCH v4] spi: add Broadcom BCM63xx SPI controller driver
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
In-Reply-To: <1328091249-10389-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-10-git-send-email-florian@openwrt.org>
         <1328091249-10389-1-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:   Wed, 01 Feb 2012 12:22:09 +0100
Message-ID: <1328095329.4936.21.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 32382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


On Wed, 2012-02-01 at 11:14 +0100, Florian Fainelli wrote:

Hi Florian,

> +struct bcm63xx_spi {
> +	spinlock_t		lock;

this lock is never actually used

it is referenced only once in device removal path

> +	int			stopping;

this can be removed by changing device removal path to first call
spi_unregister_master. that way the spi stack cannot call spi_transfer
anymore and we don't need to abort these calls.


> +static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
> +{

> [...]

> +	bcm_spi_writew(bs, cmd, SPI_CMD);
> +	wait_for_completion(&bs->done);
> +

bcm63xx_txrx_bufs() is called by bcm63xx_transfer(), and according to
Documentation/spi/spi-summary:

    master->transfer(struct spi_device *spi, struct spi_message *message)
	This must not sleep.  Its responsibility is arrange that the
        transfer happens and its complete() callback is issued.  The two
        will normally happen later, after other transfers complete, and
        if the controller is idle it will need to be kickstarted.

So we cannot do a synchronous wait here, this must be pushed to a
workqueue or kthread.


-- 
Maxime
