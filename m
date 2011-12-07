Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 00:04:33 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47436 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903682Ab1LGXE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2011 00:04:29 +0100
Received: from katana.hi.pengutronix.de ([2001:6f8:1178:2:221:70ff:fe71:1890] helo=pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <w.sang@pengutronix.de>)
        id 1RYQXB-00072o-Mh; Thu, 08 Dec 2011 00:04:17 +0100
Date:   Thu, 8 Dec 2011 00:04:17 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        spi-devel-general@lists.sourceforge.net, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller
 driver
Message-ID: <20111207230417.GG3744@pengutronix.de>
References: <1321906615-11392-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <1321906615-11392-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 32057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6334


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +static int __init bcm63xx_spi_probe(struct platform_device *pdev)
> +{
> +	struct resource *r;
> +	struct device *dev =3D &pdev->dev;
> +	struct bcm63xx_spi_pdata *pdata =3D pdev->dev.platform_data;
> +	int irq;
> +	struct spi_master *master;
> +	struct clk *clk;
> +	struct bcm63xx_spi *bs;
> +	int ret;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(dev, "no iomem\n");
> +		ret =3D -ENXIO;
> +		goto out;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no irq\n");
> +		ret =3D -ENXIO;
> +		goto out;
> +	}
> +
> +	clk =3D clk_get(dev, "spi");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no clock for device\n");
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	master =3D spi_alloc_master(dev, sizeof(*bs));
> +	if (!master) {
> +		dev_err(dev, "out of memory\n");
> +		ret =3D -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	bs =3D spi_master_get_devdata(master);
> +	init_completion(&bs->done);
> +
> +	platform_set_drvdata(pdev, master);
> +	bs->pdev =3D pdev;
> +
> +	if (!request_mem_region(r->start, resource_size(r), PFX)) {
> +		dev_err(dev, "iomem request failed\n");
> +		ret =3D -ENXIO;
> +		goto out_put_master;
> +	}

If you'd use managed devices here (devm_*), you would not leak the
mem_region in the error path :) If you use the shiny new
devm_request_and_ioremap() from linux-next, you'd save a few more lines.


> +#ifdef CONFIG_PM
> +static int bcm63xx_spi_suspend(struct platform_device *pdev, pm_message_=
t mesg)
> +{
> +	struct spi_master *master =3D platform_get_drvdata(pdev);
> +	struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> +
> +	clk_disable(bs->clk);
> +
> +	return 0;
> +}
> +
> +static int bcm63xx_spi_resume(struct platform_device *pdev)
> +{
> +	struct spi_master *master =3D platform_get_drvdata(pdev);
> +	struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> +
> +	clk_enable(bs->clk);
> +
> +	return 0;
> +}
> +#else
> +#define bcm63xx_spi_suspend	NULL
> +#define bcm63xx_spi_resume	NULL
> +#endif

dev_pm_ops?

> +
> +static struct platform_driver bcm63xx_spi_driver =3D {
> +	.driver =3D {
> +		.name	=3D "bcm63xx-spi",
> +		.owner	=3D THIS_MODULE,
> +	},
> +	.probe		=3D bcm63xx_spi_probe,
> +	.remove		=3D __exit_p(bcm63xx_spi_remove),
> +	.suspend	=3D bcm63xx_spi_suspend,
> +	.resume		=3D bcm63xx_spi_resume,
> +};
> +
> +

module_platform_driver?

> +static int __init bcm63xx_spi_init(void)
> +{
> +	return platform_driver_register(&bcm63xx_spi_driver);
> +}
> +
> +static void __exit bcm63xx_spi_exit(void)
> +{
> +	platform_driver_unregister(&bcm63xx_spi_driver);
> +}
> +
> +module_init(bcm63xx_spi_init);
> +module_exit(bcm63xx_spi_exit);
> +
> +MODULE_ALIAS("platform:bcm63xx_spi");
> +MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
> +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VER);

VERSION is not needed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7f8PEACgkQD27XaX1/VRujAACeMkAgaWlSMQdzWExVazH9ErEH
UNUAnjEpLkJMTyPDvPPiuSUSvrVmWazu
=XB1b
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
