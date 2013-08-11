Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 15:27:06 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35311 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820116Ab3HKN0uXRmQs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Aug 2013 15:26:50 +0200
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginmedia.com ([94.175.92.69] helo=finisterre)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V8VfP-0000ta-5R; Sun, 11 Aug 2013 14:26:44 +0100
Received: from broonie by finisterre with local (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V8VfO-00085s-E1; Sun, 11 Aug 2013 14:26:42 +0100
Date:   Sun, 11 Aug 2013 14:26:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org
Message-ID: <20130811132642.GB6427@sirena.org.uk>
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
 <1376074288-29302-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/DKyarNrjr/gdwox"
Content-Disposition: inline
In-Reply-To: <1376074288-29302-2-git-send-email-blogic@openwrt.org>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 94.175.92.69
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 2/2] SPI: ralink: add Ralink SoC spi driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--/DKyarNrjr/gdwox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 08:51:27PM +0200, John Crispin wrote:

Looks fairly good, a few things below but most of them are just using
the core to do things instead of open coding them in the driver rather
than anything substantial.

> +#ifdef DEBUG
> +#define spi_debug(args...) printk(args)
> +#else
> +#define spi_debug(args...)
> +#endif

This shouldn't be driver specific if it's useful, though really it looks
like the driver should just be using dev_dbg() and friends.

> +static inline void rt2880_spi_setbits(struct rt2880_spi *rs, u32 reg, u32 mask)
> +{
> +	void __iomem *addr = rs->base + reg;
> +	u32 val;
> +
> +	val = ioread32(addr);
> +	val |= mask;
> +	iowrite32(val, addr);
> +}

Is this always called with a suitable lock held?

> +	if (bits_per_word != 8) {

You should be setting bits_per_word_mask in the master structure, then
you don't need to check for this.

> +static inline int rt2880_spi_wait_till_ready(struct rt2880_spi *rs)
> +{
> +	int i;
> +
> +	for (i = 0; i < RALINK_SPI_WAIT_RDY_MAX_LOOP; i++) {
> +		u32 status;
> +
> +		status = rt2880_spi_read(rs, RAMIPS_SPI_STAT);
> +		if ((status & SPISTAT_BUSY) == 0)
> +			return 0;
> +
> +		udelay(1);
> +	}

A cpu_relax() here would be nice.

> +static unsigned int
> +rt2880_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
> +{
> +	struct rt2880_spi *rs = spidev_to_rt2880_spi(spi);
> +	unsigned count = 0;
> +	u8 *rx = xfer->rx_buf;
> +	const u8 *tx = xfer->tx_buf;
> +	int err;
> +
> +	spi_debug("%s(%d): %s %s\n", __func__, xfer->len,
> +		  (tx != NULL) ? "tx" : "  ",
> +		  (rx != NULL) ? "rx" : "  ");
> +
> +	if (tx) {
> +		for (count = 0; count < xfer->len; count++) {
> +			rt2880_spi_write(rs, RAMIPS_SPI_DATA, tx[count]);
> +			rt2880_spi_setbits(rs, RAMIPS_SPI_CTL, SPICTL_STARTWR);
> +			err = rt2880_spi_wait_till_ready(rs);
> +			if (err) {
> +				dev_err(&spi->dev, "TX failed, err=%d\n", err);
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	if (rx) {

There is presumably a maximum transfer size here from the FIFO that is
holding the data?

> +		if (bits_per_word != 8) {
> +			dev_err(&spi->dev,
> +				"message rejected: invalid transfer bits_per_word (%d bits)\n",
> +				bits_per_word);

Like I say set bits_per_word_mask...

> +		if (t->speed_hz && t->speed_hz < (rs->sys_freq / 128)) {
> +			dev_err(&spi->dev,
> +				"message rejected: device min speed (%d Hz) exceeds required transfer speed (%d Hz)\n",
> +				(rs->sys_freq / 128), t->speed_hz);
> +			status = -EIO;
> +			goto msg_done;
> +		}

Set min_speed_hz in the spi_master and the core will check this for you.

> +	if (spi->max_speed_hz < (rs->sys_freq / 128)) {
> +		dev_err(&spi->dev, "setup: requested speed is too low %d Hz\n",
> +			spi->max_speed_hz);
> +		return -EINVAL;
> +	}
> +
> +	if (spi->bits_per_word != 0 && spi->bits_per_word != 8) {
> +		dev_err(&spi->dev,
> +			"setup: requested bits per words - os wrong %d bpw\n",
> +			spi->bits_per_word);
> +		return -EINVAL;
> +	}

Again the core can do this for you.

> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_request_and_ioremap(&pdev->dev, r);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

devm_ioremap_resource().

> +	status = clk_enable(clk);
> +	if (status)
> +		return status;

clk_prepare_enable(), and it'd be nice to use runtime PM and enable the
clock only when doing transfers though that's not essential.

> +static int rt2880_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master;
> +	struct rt2880_spi *rs;
> +
> +	master = dev_get_drvdata(&pdev->dev);
> +	rs = spi_master_get_devdata(master);
> +
> +	clk_disable(rs->clk);
> +	clk_put(rs->clk);

No clk_put if you've used devm_clk_get().

--/DKyarNrjr/gdwox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB5EPAAoJELSic+t+oim9CO4P/1bCI9kHq/QwZLVScJalWj88
2WsyXhPqNLndFWOqU3fKhjR0VO2KdShUQCBKEOdSXNC1Tz2f5m0lDZa+yYL+sJbV
gxiLgNaHamPOYq4I6RSs2OBi4jmrJhZR2+cjACZRTkbHzD4zfCQqq9wst1PzqIpZ
ApXDRJgf7BebxAAlBzbvXZ9llUtBL7v/mIRruNiT4grE1wUpXpjCt+feFyJS6pVt
FdEr8DtpPgi3sIk4TTJJiVgXOB1I44dm1TLURvk7mdtfvh6xS7aXeiGDoGZv8BiV
05N7jAN97Na7As+eRp/mXAt5Q3UPShKTR5J3O9bsx6fBYs+wqjR4QGOX4vBA/61y
MZdSzZ6Cz162qxjoHvnqpUeCo1C6jiI2+uRiBsgx7U6HAV/UUuRbmatrn5rwxtog
M5R3Z4Yx5VnJEGs4HmM6xZRMgfnQvtcCUysv/JZVSRnwg0ytoNlyMql8J/s5fxX8
Nkugwfuvel3QqlrhzGirxVpvw9KqO3DeXd3yvL/rzG7g2/t3JvpJDp+R/VCMudsd
De0D/kFHSRZqxvAZdIwEgY69HkjrYr0QgXZTdQ0ik8X8W1hVNGsRAt2gTWMsWd1d
jq3bGR0Gz2WsulZOCqlEGpXuz3Ko8Mc0UmfbuJuFdfV6JHhOviyYSMmC8wb5bATG
yPZwEvN4w/KYyGtThSO6
=snqH
-----END PGP SIGNATURE-----

--/DKyarNrjr/gdwox--
