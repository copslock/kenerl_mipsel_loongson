Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 13:51:48 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40145 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008701AbbCTMvqZ2mi9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 13:51:46 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwOr-0006en-Uv; Fri, 20 Mar 2015 12:51:42 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwOp-0005Oi-3Q; Fri, 20 Mar 2015 12:51:39 +0000
Date:   Fri, 20 Mar 2015 12:51:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Message-ID: <20150320125139.GJ2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-2-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kJCZHFqBEEYq/eA6"
Content-Disposition: inline
In-Reply-To: <1426853793-24454-2-git-send-email-bert@biot.com>
X-Cookie: Wanna buy a duck?
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46473
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


--kJCZHFqBEEYq/eA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 01:16:32PM +0100, Bert Vermeulen wrote:

> +#define DRV_NAME	"rb4xx-spi"
> +#define DRV_DESC	"Mikrotik RB4xx SPI controller driver"

Both of these are used exactly once, the defines aren't adding anything
except indirection.

> +#define DRV_VERSION	"0.1.0"

The kernel is already versioned, don't include versions for individual
drivers - nobody is going to update it anyway.

> +static unsigned spi_clk_low = AR71XX_SPI_IOC_CS1;

No global variables, use driver data.

> +#ifdef RB4XX_SPI_DEBUG
> +static inline void do_spi_delay(void)
> +{
> +	ndelay(20000);
> +}
> +#else
> +static inline void do_spi_delay(void) { }
> +#endif

Remove this, if it's useful implement it generically.

> +static inline void do_spi_init(struct spi_device *spi)
> +{
> +	unsigned cs = AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1;
> +
> +	if (!(spi->mode & SPI_CS_HIGH))
> +		cs ^= (spi->chip_select == 2) ? AR71XX_SPI_IOC_CS1 :
> +						AR71XX_SPI_IOC_CS0;

Please write this expression in a more legible fashion, I can't really
tell what it's supposed to do.

> +static void do_spi_byte(void __iomem *base, unsigned char byte)
> +{
> +	do_spi_clk(base, byte >> 7);
> +	do_spi_clk(base, byte >> 6);
> +	do_spi_clk(base, byte >> 5);
> +	do_spi_clk(base, byte >> 4);
> +	do_spi_clk(base, byte >> 3);
> +	do_spi_clk(base, byte >> 2);
> +	do_spi_clk(base, byte >> 1);
> +	do_spi_clk(base, byte);

This looks awfully like it's bitbanging the value out, can we not use
spi-bitbang here?

> +	pr_debug("spi_byte sent 0x%02x got 0x%02x\n",
> +		 (unsigned)byte,
> +		 (unsigned char)__raw_readl(base + AR71XX_SPI_REG_RDS));

dev_dbg().

> +static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1,
> +				   unsigned bit2)

Why would we ever want the slow version?

> +static int rb4xx_spi_msg(struct rb4xx_spi *rbspi, struct spi_message *m)
> +{
> +	struct spi_transfer *t = NULL;
> +	void __iomem *base = rbspi->base;
> +
> +	m->status = 0;
> +	if (list_empty(&m->transfers))
> +		return -1;
> +
> +	__raw_writel(AR71XX_SPI_FS_GPIO, base + AR71XX_SPI_REG_FS);
> +	__raw_writel(SPI_CTRL_FASTEST, base + AR71XX_SPI_REG_CTRL);
> +	do_spi_init(m->spi);
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		int len;

This is reimplementing the core message queue code, provide a
transfer_one() operation if there's some reason not to use bitbang.

> +static void rb4xx_spi_process_queue_locked(struct rb4xx_spi *rbspi,
> +					   unsigned long *flags)

Similarly all the queue code is reimplementing core functionality.

> +static int __init rb4xx_spi_init(void)
> +{
> +	return platform_driver_register(&rb4xx_spi_drv);
> +}
> +subsys_initcall(rb4xx_spi_init);
> +
> +static void __exit rb4xx_spi_exit(void)
> +{
> +	platform_driver_unregister(&rb4xx_spi_drv);
> +}
> +
> +module_exit(rb4xx_spi_exit);

module_platform_driver()

--kJCZHFqBEEYq/eA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDBfaAAoJECTWi3JdVIfQUDgH/jijJq+oLBdsPEXkvG5V6m0J
uVT74rmxOJxe8R1jiDlA/XLoEnxN9A2uczJyDCVIHfbUQ3ps/8xR/VCQqnQeb+ka
QR+PdsfSaDmmidwYiMy14wl/NctrLTJ9Sxo5GzWhFEf4hT1ru6/M9UbKtF+1MrRk
sfTT7EwYHqNRJIi24xXIcejNj8ALCnrJByeJrGKw/SsdIXhynQ7pcz6pCWV/Nr1f
KN0TOy11K7ZU9kMJzDliiCv5bJdX3pms/Mj+vZwvqksOQo6NiCaxlCo/fsnskSr4
IagsWXOSaP+JN52VzGTmYQN+FIQs6hO63HiICIjxRvfU6rQqCKbOWeB5XJ5HPN8=
=HgHw
-----END PGP SIGNATURE-----

--kJCZHFqBEEYq/eA6--
