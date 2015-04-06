Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 18:39:16 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54445 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008528AbbDFQjOaVD-4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 18:39:14 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YfA3I-0005w6-4K; Mon, 06 Apr 2015 16:39:08 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YfA3F-0006JM-7x; Mon, 06 Apr 2015 17:39:05 +0100
Date:   Mon, 6 Apr 2015 17:39:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Message-ID: <20150406163905.GL6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/0D4jGRsNl8cPNu/"
Content-Disposition: inline
In-Reply-To: <1428285263-15135-1-git-send-email-bert@biot.com>
X-Cookie: I've been there.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46793
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


--/0D4jGRsNl8cPNu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 03:54:23AM +0200, Bert Vermeulen wrote:

> +	for (i = 0; i < t->len; ++i) {
> +		out = tx_buf ? tx_buf[i] : 0x00;

This looks like the driver needs to set SPI_MASTER_MUST_TX.

> +/* Deselect CS0 and CS1. */
> +static int rb4xx_unprepare_transfer_hardware(struct spi_master *master)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +
> +       rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
> +                   AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
> +
> +       return 0;
> +}

This seems broken - if chip select needs to be deasserted it should be
be deasserted before we get to unprepare, otherwise if more than one
SPI message is queued at once then presumably chip select won't be
deasserted between them which would break things.  This is what the
set_cs() operation is for...

> +		if (spi->chip_select == 1 && t->cs_change) {
> +			/* CPLD in bulk write mode gets two bits per clock */
> +			do_spi_byte_fast(rbspi, spi_ioc, out);
> +			/* Don't want the real CS toggled */
> +			t->cs_change = 0;
> +		} else {
> +			do_spi_byte(rbspi, spi_ioc, out);
> +		}

This is making very little sense to me and the fact that the driver is
messing with cs_change is definitely buggy, it'll mean that repeated use
of the same transfer will be broken.  What is the above code supposed to
do, both with regard to selecting "fast" mode (why would you want slow
mode?) and with regard to the chip select?

I queried this on a previous version and asked for the code to be better
documented...

> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +	if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
> +		dev_err(&spi->dev, "bits_per_word %u not supported\n",
> +			spi->bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

This should be removed, the driver should be setting bits_per_word_mask.

> +	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(ahb_clk))
> +		return PTR_ERR(ahb_clk);
> +
> +	err = clk_prepare_enable(ahb_clk);
> +	if (err)
> +		return err;

There's no error handling (or indeed any other code) disabling the
clock, probably this enable should happen later and those disables
definitely need adding.  I'd also expect to see runtime PM to keep the
clock disabled when the controller isn't in use in order to save power.

> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +	struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
> +
> +	spi_master_put(rbspi->master);

devm_spi_register_master().

--/0D4jGRsNl8cPNu/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIraoAAoJECTWi3JdVIfQYHkH/0003QIxxS5ZoezKuN4DZGvj
nEQVunmHx9KRdsp7wdzrxOVi/ZWW2SS7ijlLQFhYp6RDc9WujEqH7az77OayVl7c
CMaF0G3iTjV9RkfOM3eHIfVt4rL0glkPilCPTUMslqmLOeCM7/m3/fXhNq0gLi6F
Qp90zRKDpwAwPv6ldEUroAS5MplNtELimi5/hIS7h34Mc9aegmiFaRU8zWd0UME8
aHdv9Glq8QufliAThP3JmhyUXScC6h4y7/IA7uO9ZEQDLGJjyukyY8tQggx3w187
2br7zLtBtA89uuU5yEhlZGrGmMmd/wVS4jMAv69H5AGdU2TLP1Ov90IljaGPfBk=
=l5gX
-----END PGP SIGNATURE-----

--/0D4jGRsNl8cPNu/--
