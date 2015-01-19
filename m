Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 22:31:03 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:34784 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011712AbbASVbCO6aQD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jan 2015 22:31:02 +0100
Received: from p4fe24a52.dip0.t-ipconnect.de ([79.226.74.82]:60846 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YDJuN-0003Y9-RP; Mon, 19 Jan 2015 22:30:52 +0100
Date:   Mon, 19 Jan 2015 22:30:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Jean Delvare <jdelvare@suse.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150119213050.GA32176@katana>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20150119190142.GA9451@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> > =20
> >  static void i2c_adapter_dev_release(struct device *dev)
> >  {
> > -	struct i2c_adapter *adap =3D to_i2c_adapter(dev);
> > -	complete(&adap->dev_released);
> > +	/* empty, but the driver core insists we need a release function */
>=20
> Yeah, it does, but I hate to see this in "real" code as something is
> probably wrong with it if it happens.
>=20
> Please move the rest of 'i2c_del_adapter' into the release function
> (what was after the wait_for_completion() call), and then all should be
> fine.

I was about to do this as a follow-up patch. But Russell's and
Lars-Peter's responses made this obsolete already.


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvXeKAAoJEBQN5MwUoCm2yU8P/jACuxrtfHb4yh+Tu47k8Iww
UkgEMRwaHGpm+uvg8lvWKYJgQqUdP7M7nVgZDrzezsnyvggYs8SnixTwoL3lA7+2
ovakYYGL/x1LTKjAzJvgkYrYs7BgZ4dAcHsG3M56YqW9pomSHnkqSoWM7eOIIH9X
NHxHXEWbrf9oTrUjy4EN9Y04ey7zh7//27L7eetNjYcu8eISc9wi4qVJShlLS3RA
qcrvLDo4kb4O+zPv1PxtSDXqv0OkrgmlmQoJ6vprm/6S+O4xSNcF3lkfJdp6Ud1Y
+z9zuCsn743dLw+WpmqAJKsa4aIYNF/1ut+JDIVy+Oc65jk96KDNYHecKhBswYwC
bzdK705MkdQmpzZ9hKTvHPN0/6qinBCoSJzl6S/4WLXM42Fa5D3WwdC/oFXy9CCs
/3Ti0XnK+hr3xAsU3UdeJBkLPA7D0NxYbs9RWyNojdyzTyx/DBilQFzZfyr+25qy
gULtb6WDSyLSDt/HzddpRCd3Q7uG3Kb5a17xhmLdhPllVyIlsju12tRgPskZ/9BC
/6desPhbEObHHo0l69hbRnkQPN/tNNiLHad/P6+uAS1zzmZJzqprhAgeVvnHkUaZ
92+U7sQMYfvm0jw1IIHJf2Vv71scblJw8rXL5PHvMifaIv2pIgwrz8RFr818d2W7
1kWMDN233l5vJQHrrd5o
=ZCzZ
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
