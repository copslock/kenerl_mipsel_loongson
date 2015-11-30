Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 16:41:06 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:57256 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007213AbbK3PlE3GrtV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 16:41:04 +0100
Received: from p4fe25b9b.dip0.t-ipconnect.de ([79.226.91.155]:49054 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1a3QZb-0000sV-Ug; Mon, 30 Nov 2015 16:41:04 +0100
Date:   Mon, 30 Nov 2015 16:41:02 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 5/9] i2c: brcmstb: fix start and stop conditions
Message-ID: <20151130154102.GP1513@katana>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-6-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kOdvwer/5gjFgNo6"
Content-Disposition: inline
In-Reply-To: <1445395021-4204-6-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50180
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


--kOdvwer/5gjFgNo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 11:36:57AM +0900, Jaedon Shin wrote:
> Fixes conditions for RESTART, NOSTART and NOSTOP. The masks of start and
> stop is already in brcmstb_set_i2c_start_stop(). Therefore, the caller
> does not need a mask value.

Hmm, and what if that changes for some reason in the future (driver
refactoring)? I'd rather leave it as it is; it is a micro-optimization
after all.

>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-br=
cmstb.c
> index 53eb8b0c9bad..dcd1209f843f 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -464,7 +464,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapt=
er,
>  			pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
> =20
>  		if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
> -			brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
> +			brcmstb_set_i2c_start_stop(dev, 0);
>  		else
>  			brcmstb_set_i2c_start_stop(dev,
>  						   COND_RESTART | COND_NOSTOP);
> @@ -485,8 +485,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapt=
er,
>  			bytes_to_xfer =3D min(len, N_DATA_BYTES);
> =20
>  			if (len <=3D N_DATA_BYTES && i =3D=3D (num - 1))
> -				brcmstb_set_i2c_start_stop(dev,
> -							   ~(COND_START_STOP));
> +				brcmstb_set_i2c_start_stop(dev, 0);
> =20
>  			rc =3D brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
>  						       bytes_to_xfer, pmsg);
> --=20
> 2.6.1
>=20

--kOdvwer/5gjFgNo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXG4OAAoJEBQN5MwUoCm2SfgQAII/cyivEot2YOJJU16DofUH
XxMJJxgPB7SY9SVaQhdjiHiaMBqvdLKq/h6sFXdVfuAvij+BE1eY5sSR8djGs2Bc
eDj7sXFTSN1kZQ/1+WiC0TMwSNrGH9yEYIGwZl5n7SYm5oYWjRgZ9kIucMGVl7cI
KqVQv6DLvRNgeOePb9S4Bzw8QZQqI9cDDH4oLBMFhqhaYAATxY4B/UX7tg068uUL
sUBKZrZq1Gs0/vEBhDPpFTvJFZFNN3bbHEm10W0qolmBhxR+0paYA+/yy8tF2MBi
zkmsUNEEG+Yj5m4PyzOwjhXMD88BGKZ3VVVfV6nruKhMR1Rg0Mpelf6L1K/2Dr1S
90wmTa5594VVOwH7CQBV0FcSBW6AN6zuxzUNqIcgqGBFRsGIYTM39UKyKNWAvk73
AhWlX5FQ/8CiYdiRcu6Jj9+wUkOJokKPVd/Dbhf7eDI3+jt3nDzLetG2fyb4O46D
LiBjFxNObUlqJxZji2wGXwjIaFv8q/pnelLvzLL9DAzSkRy9tZc62UZHfSanwd24
E2jUlJSojiMnEW4RXF5kVnQVyRK2xw8t0LvGPDz5OdnqSj0snxePG+JdLgiK3sKj
x7JFlzoj6fEjBqgsgG3VitPRufy4zhs9LH3Y5Dsvcl+uWdPladwmWfSsOfJ7FAq0
wuOwtt2EEmuJ8ydB3Biq
=rvMD
-----END PGP SIGNATURE-----

--kOdvwer/5gjFgNo6--
