Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2007 18:13:47 +0100 (BST)
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:60796 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021961AbXF3RNp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 30 Jun 2007 18:13:45 +0100
Received: (qmail 63249 invoked from network); 30 Jun 2007 17:13:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QlbSt/67J1qHDtYHJJEaG2X3/ClqDwZbOymFoTpaGUrGxAjT3075u6WRpqUD5ysCXSOL2OpTL4mG7XeVhsP/gU0pnFA3NWjcErAW4DXaPWyRkhryPcGJ06lcqsx7VFZRCKltoj4P8mivPeztX1rOkwppYbLa3OHLrzWpSrvV9Sw=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp105.sbc.mail.mud.yahoo.com with SMTP; 30 Jun 2007 17:13:37 -0000
X-YMail-OSG: VlGWoR0VM1miL4IKRBa0sGpUf5FHu_VRZJSLKNKs0moDINKn3ROxmbMk_GMJPJkWymQn6W_gGA--
From:	David Brownell <david-b@pacbell.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
Date:	Sat, 30 Jun 2007 09:53:19 -0700
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
References: <20070627.222458.27955527.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070627.222458.27955527.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706300953.20156.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 27 June 2007, Atsushi Nemoto wrote:
> This is a driver for SPI controller built into TXx9 MIPS SoCs.
> This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> Changes from previous version:

Better, but still not there yet.
 
> * Whitespace cleanup.
> * spi->mode checking.
> * Remove I/O barrier after gpio_set_value()
> * Do not modify spi->max_speed_hz in _setup function.
> * Deselect chip in _setup function.
> * Check per-transfer parameters.

Checking these parameters is done at the wrong place though,
and is done incorrectly.  That's the main issue with this
patch.

> * Move all ndelay() into txx9spi_cs_func().
> * Fix cs_change hint handling.
> * Remove mapping hack, expecting ioremap() just works.
> * Use the clock framework (clk_get()) instead of abusing resource framework.
> * Initialize num_chipselect explicitly.

Yeah, but ... still not correctly!!


> * Use platform_driver_probe() instead of platform_driver_register().
> 
> ...
>
> +static int txx9spi_setup(struct spi_device *spi)
> +{
> +	...
> +
> +	/* deselect chip */
> +	spin_lock(&c->lock);
> +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);

You still use this confusing A/2/B syntax.  Please
rewrite that using one "/" and one "*".  (And there
is similar usage elsewhere.)


> +	spin_unlock(&c->lock);
> +
> +	return 0;
> +}
> +
> +...
> +
> +static int txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
> +{
> +	struct spi_device *spi = m->spi;
> +	struct spi_transfer *t;
> +	unsigned int cs_delay;
> +	unsigned int cs_change;
> +	int status;
> +	u32 mcr;
> +	u8 bits_per_word = spi->bits_per_word ?: 8;
> +	u32 speed_hz = 0, n;
> +

These checks here should be in txx9_spi_transfer(), where
returning EINVAL will do some good.  The single caller to
this routine doesn't even look at its return value ... and
returning without issuing the message's completion callback
is just a bug.


> +	/* check each transter parameters */
> +	list_for_each_entry (t, &m->transfers, transfer_list) {
> +		if (!t->tx_buf && !t->rx_buf && t->len)
> +			return -EINVAL;
> +		if (t->bits_per_word && t->bits_per_word != bits_per_word)
> +			return -EINVAL;
> +		if (t->len & ((bits_per_word >> 3) - 1))
> +			return -EINVAL;
> +		if (!speed_hz)
> +			speed_hz = t->speed_hz;
> +		else if (speed_hz != t->speed_hz)

That speed check is wrong.  There's no reason two transfers
shouldn't have different speeds ... e.g. flash chips often
have speed limits in certain bulk reads, which don't apply
to other operations.


> +			return -EINVAL;
> +	}
> +	if (!speed_hz)
> +		speed_hz = spi->max_speed_hz;
> +	if (!speed_hz || speed_hz > c->max_speed_hz)
> +		speed_hz = c->max_speed_hz;
> +	else if (speed_hz < c->min_speed_hz)
> +		return -EINVAL;

Also, you can't replace per-transfer speed checks with one
for the overall message... each transfer could have a
very different speed.


> +	...
> +}
> +
> +...
> +
> +static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> +	struct spi_master *master = spi->master;
> +	struct txx9spi *c = spi_master_get_devdata(master);
> +	unsigned long flags;
> +

Here's where the (corrected) checks for each spi_transfer in the
message belong:  if the message is invalid, don't even queue it,
just return -EINVAL.


> +	m->actual_length = 0;
> +	spin_lock_irqsave(&c->lock, flags);
> +	list_add_tail(&m->queue, &c->queue);
> +	queue_work(c->workqueue, &c->work);
> +	spin_unlock_irqrestore(&c->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int __init txx9spi_probe(struct platform_device *dev)
> +{
> +	struct spi_master *master;
> +	struct txx9spi *c;
> +	struct resource *res;
> +	int ret = -ENODEV;
> +	u32 mcr;
> +
> +	master = spi_alloc_master(&dev->dev, sizeof(*c));
> +	if (!master)
> +		return ret;
> +	c = spi_master_get_devdata(master);
> +	c->irq = -1;
> +	platform_set_drvdata(dev, master);
> +
> +	INIT_WORK(&c->work, txx9spi_work);
> +	spin_lock_init(&c->lock);
> +	INIT_LIST_HEAD(&c->queue);
> +	init_waitqueue_head(&c->waitq);
> +
> +	c->clk = clk_get(&dev->dev, "spi-baseclk");
> +	if (IS_ERR(c->clk)) {
> +		ret = PTR_ERR(c->clk);
> +		c->clk = NULL;
> +		goto exit;
> +	}
> +	if (clk_enable(c->clk)) {

Minor comment:  if power management is a concern, you might
consider leaving the clock disabled except when transfers
are active or you're accessing controller registers.  On
most chips, leaving a clock enabled all the time (like this)
means power is needlessly consumed.  (This isn't wrong, just
sub-optimal in terms of power reduction.)

> +	...
> +
> +	master->bus_num = dev->id;
> +	master->setup = txx9spi_setup;
> +	master->transfer = txx9spi_transfer;
> +	master->num_chipselect = 0;	/* unlimited: any GPIO numbers */

No, actually it means "no chipselects" as I said before;
the fact that this works right now is a bug that will be
fixed at some point.  INT_MAX would allow any GPIO.


... almost mergeable!

- Dave
