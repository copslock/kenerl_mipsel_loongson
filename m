Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 14:38:40 +0100 (CET)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44007 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989Ab3LDNiiECN8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Dec 2013 14:38:38 +0100
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginm.net ([94.175.92.69] helo=debutante.sirena.org.uk)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoCem-0003YU-2Y; Wed, 04 Dec 2013 13:38:25 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoCel-0002tX-KI; Wed, 04 Dec 2013 13:38:23 +0000
Date:   Wed, 4 Dec 2013 13:38:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Message-ID: <20131204133823.GS29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Vy6UCbb9EK60RK4A"
Content-Disposition: inline
In-Reply-To: <1385811726-6746-6-git-send-email-jogo@openwrt.org>
X-Cookie: It's clever, but is it art?
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 94.175.92.69
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38635
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


--Vy6UCbb9EK60RK4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 12:42:06PM +0100, Jonas Gorski wrote:
> Add a driver for the High Speed SPI controller found on newer BCM63XX SoC=
s.
>=20
> It does feature some new modes like 3-wire or dual spi, but neither of it
> is currently implemented.

This is basically good so I've applied it but there are a few minor
things that could use improving, please send incremental patches for
these.

> +	clk =3D clk_get(dev, "hsspi");

Use devm_clk_get().

> +	clk_prepare_enable(clk);

You should check the return value here.

> +	/* register and we are done */
> +	ret =3D spi_register_master(master);
> +	if (ret)
> +		goto out_put_master;

devm_spi_register_master().

> +#ifdef CONFIG_PM

This should be CONFIG_PM_SLEEP.

> +static int bcm63xx_hsspi_suspend(struct device *dev)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +	struct bcm63xx_hsspi *bs =3D spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +	clk_disable(bs->clk);

This ought to be disable_unprepare().  It would also be better to move
this to runtime PM (you can set auto_runtime_pm to have the core manage
the enable and disable for you) since that will save a bit of power.

> +static int bcm63xx_hsspi_resume(struct device *dev)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +	struct bcm63xx_hsspi *bs =3D spi_master_get_devdata(master);
> +
> +	clk_enable(bs->clk);
> +	spi_master_resume(master);

Similar comments here, plus you should be checking errors.

--Vy6UCbb9EK60RK4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnzBMAAoJELSic+t+oim9w1UP/1LRGjzhrrNY9PqSaUkXo9sJ
jfcCG7gn6AlbrKJyQ0xNuvERTQbXdhT3WtvmQx2hbf18lPkCdXK4UA1mHzNykxym
pogCLM2GH3/+/FbQk75lvGwpZaWpL9CEjykVpd9e8rj5afND1vsCy9x826HFDMLR
Yj9sivZpt50YrxdQXK8yqfF9VveW+Pc+kaDc1DtxJQHCYkhPdLsrHfpC9w0SlzQJ
pi6O0vd33ihonCwoP+XvV8OykK9vZvIDc0zHtMOEVM++tKU+gi7GADdHANwUL7Hy
8V9j9+WruPHIZhyfw0exJf8tT5FlzwGPlKab89PzZZOMe0ScX2c7efr3JGizctz4
APMsgq4aRulzyrqPNqPkm/ZFhI1ujfJhkil6O6e4rpA89FA9CtKJM2aWeDw3X2Gz
4khPq4u4lYfo1N/AhVO4S7fD55WEygdK10KUnH3Lw/eZLgdG4eSR29WoxCzhaciL
4lCy7/ECThNsh0m09A0REwY9YopkNgLhR8LegS4I6EYq8tLfz4m/H7h5PWby3MRh
0/DuKO7mxTQZZ7kHhkDKZU9M0EOjzCw7BXnyeyJz4W5xTBQ4vlbl6Wv4wkshR1cJ
FrLVl/P7tiSBtS3AQgpl9SDbOP48hbKA7yzYeVoy/AFfaA0u5HniRLGoN8HrsUO1
eW5tlia/IgEcpruyfjWX
=FTNe
-----END PGP SIGNATURE-----

--Vy6UCbb9EK60RK4A--
