Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 16:36:09 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:57170 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007213AbbK3PgGihSIV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 16:36:06 +0100
Received: from p4fe25b9b.dip0.t-ipconnect.de ([79.226.91.155]:49052 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1a3QUn-0000rB-Tt; Mon, 30 Nov 2015 16:36:06 +0100
Date:   Mon, 30 Nov 2015 16:36:04 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
Message-ID: <20151130153604.GN1513@katana>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
 <5628425C.5080104@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <5628425C.5080104@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50178
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


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 06:56:44PM -0700, Florian Fainelli wrote:
> Le 20/10/2015 19:36, Jaedon Shin a =C3=A9crit :
> > Add the necessary parenthesis for NOACK condition.
> >=20
> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>=20
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I wouldn't call them necessary?

>=20
> > ---
> >  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-=
brcmstb.c
> > index 6b8bbf99880d..2d7d155029dc 100644
> > --- a/drivers/i2c/busses/i2c-brcmstb.c
> > +++ b/drivers/i2c/busses/i2c-brcmstb.c
> > @@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_=
dev *dev,
> >  	}
> > =20
> >  	if ((CMD_RD || CMD_WR) &&
> > -	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> > +	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
> >  		rc =3D -EREMOTEIO;
> >  		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
> >  			cmd_string[cmd]);
> >=20
>=20
>=20
> --=20
> Florian

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGzkAAoJEBQN5MwUoCm2BRQP/3Jp7MtRO1DcmUk+TOVQ49y3
kvJgqGzocRCKPZzKr3a2MRRqvsRxODIjOWbM7tptNGMZVDbqBquhZB5tHfQFp7Ux
95MjyBV6pU0jMIWnR14LwKknrUXjBN7YPrr9hbUmjKm7QAxI8LZLc5cAdE+fqza6
uZ9qybujqnTO2eFlnXquFXPG3cnbZDx1zY9PkWmjF7sbEr7GdtcQSiq/S3tC+hJD
XuQIMI47sp0sdBE+BefiCLPp8cF8ly67fmQ7yHtBh2D5gLE8m7MPAT9u/wKStKYX
COCKmsyiW8jlbI5qksUq9+k8Xm3XNYaaFjXgqRWI/TSPuIC9DdSj2ZebI2AN/LCg
t9n2QqwZcPU15hpxsm8FITtkSlhY3w3ldtGwL0GfS12HfsG0iKRFW6faYUJ2jLkM
pQgAkD0bFcOEQN2y+O6cGw19AqU8kHjl66OpkIM+UNDBwVJxB7XHtlWJPq/7v5wO
pfILsiO1rm59aX05Kh3FJyDkMixv3tBGJogfIYOLcHNRDfih9qBX2U6dtAchEhlN
W4ZoDiHQdKKL6xGQch7nq2ap0WFXj693dCF0gCcXJYp4kzmoqaAesoG9el6Q2a1M
nNwlO6osnPgwmdmkD1uCRDjPxSXOJu20hzlPRpms7Wstafu5H4rJAoCtL9NI8brU
qnWOoBDAihktR/EOXG7V
=4IwD
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
