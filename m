Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2008 11:35:03 +0100 (CET)
Received: from hydra.gt.owl.de ([195.71.99.218]:27619 "EHLO hydra.gt.owl.de")
	by lappi.linux-mips.net with ESMTP id S529939AbYC2Ke6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Mar 2008 11:34:58 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 3925A32ED3; Sat, 29 Mar 2008 11:34:27 +0100 (CET)
Date:	Sat, 29 Mar 2008 11:34:27 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	Nicolas Thill <nico@openwrt.org>, ralf@linux-mips.org
Subject: Re: [PATCH][MIPS][1/6]: AR7: core
Message-ID: <20080329103427.GA19501@paradigm.rfc822.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803121906.25546.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <200803121906.25546.technoboy85@gmail.com>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200803291103@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 12, 2008 at 07:06:25PM +0100, Matteo Croce wrote:
>=20
> Sorry but the linux-mips mailing list can't accept this patch for unknown=
 reasons.
> I'll send a gz file, that will work

i have a plattform AR7VWi which has a High Active reset for the
vlynq_low so the code is not sufficient to get the ACX up and running

+static struct plat_vlynq_data vlynq_low_data =3D {
+       .ops.on =3D vlynq_on,
+       .ops.off =3D vlynq_off,
+       .reset_bit =3D 20,
+       .gpio_bit =3D 18,
+};
+
+static struct plat_vlynq_data vlynq_high_data =3D {
+       .ops.on =3D vlynq_on,
+       .ops.off =3D vlynq_off,
+       .reset_bit =3D 16,
+       .gpio_bit =3D 19,
+};

The gpio_bit's are okay but they are high active so the generic code:

+static int vlynq_on(struct vlynq_device *dev)
+{
+       int result;
+       struct plat_vlynq_data *pdata =3D dev->dev.platform_data;
+
+       if ((result =3D gpio_request(pdata->gpio_bit, "vlynq")))
+               goto out;
+
+       ar7_device_reset(pdata->reset_bit);
+
+       if ((result =3D ar7_gpio_disable(pdata->gpio_bit)))
+               goto out_enabled;
+
+       if ((result =3D ar7_gpio_enable(pdata->gpio_bit)))
+               goto out_enabled;
+
+       if ((result =3D gpio_direction_output(pdata->gpio_bit, 0)))
+               goto out_gpio_enabled;
+
+       mdelay(50);
+
+       gpio_set_value(pdata->gpio_bit, 1);

Is not enough here - gpios might be reverse polarity ... The right thing
to actually reset a device would need a toggle not a static state.

+       mdelay(50);
+
+       return 0;


+static void vlynq_off(struct vlynq_device *dev)
+{
+       struct plat_vlynq_data *pdata =3D dev->dev.platform_data;
+       ar7_gpio_disable(pdata->gpio_bit);
+       gpio_free(pdata->gpio_bit);
+       ar7_device_disable(pdata->reset_bit);
+}

gpio_disable to gpio_bit will put the gpio to tristate or special function
which will lead to unpredicted results. So gpio_set_value would be needed
and then the same as for vlynq_on applies concerning the reverse polarity.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7hszUaz2rXW+gJcRAgFiAKCHUgxHWb+gKMtdoFVFPkWeO5XGVACgtSqI
XEmQ8hLk+gbC4nAJ63HnEP8=
=qLLm
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
