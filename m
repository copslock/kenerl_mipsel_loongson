Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 16:37:16 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:57178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007213AbbK3PhObyOPV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 16:37:14 +0100
Received: from p4fe25b9b.dip0.t-ipconnect.de ([79.226.91.155]:49053 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1a3QVt-0000rY-Sp; Mon, 30 Nov 2015 16:37:14 +0100
Date:   Mon, 30 Nov 2015 16:37:12 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4/9] i2c: brcmstb: enable ACK condition
Message-ID: <20151130153712.GO1513@katana>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lCFQJunhLz1tFGpX"
Content-Disposition: inline
In-Reply-To: <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50179
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


--lCFQJunhLz1tFGpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 11:36:56AM +0900, Jaedon Shin wrote:
> Removes the condition of a message with under 32 bytes in length. The
> messages that do not require an ACK are I2C_M_IGNORE_NAK flag.

Makes me wonder why it worked before? Kamal?

>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-br=
cmstb.c
> index 2d7d155029dc..53eb8b0c9bad 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -330,7 +330,7 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i=
2c_dev *dev,
>  	int no_ack =3D pmsg->flags & I2C_M_IGNORE_NAK;
> =20
>  	/* see if the transaction needs to check NACK conditions */
> -	if (no_ack || len <=3D N_DATA_BYTES) {
> +	if (no_ack) {
>  		cmd =3D (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
>  			: CMD_WR_NOACK;
>  		pi2creg->ctlhi_reg |=3D BSC_CTLHI_REG_IGNORE_ACK_MASK;
> --=20
> 2.6.1
>=20

--lCFQJunhLz1tFGpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXG0oAAoJEBQN5MwUoCm2YUcQAINvkVvLKN1gK978wqwFcCdN
NGSnXk4xAPLUZt/UdUl/90Ieib1GzJlhy7gDFQ/U4XJ/zrjLc4nSsCyAr6ze4wRT
z/GrM7OxMUmIORoVkYnTAu/opN3zfFcLw7tajmGRwTiN7U7RdJ0DLEX406VxpJqj
jupXzOEKkNl5Pa+KU1mKKp201o9eOEkCS5m3fxxrz9HwkydGaWvAXjBpJ7kMRDrY
Uro+lxy6zrD3xLwuPhwla9huCyww9mNiPrTSHbkvPMmqjVsVWTXopfTVBnzGRz3N
5GFuY9QD/NL21x00j3QoRA7sQr9lr+RxkcsregIhLIdjdYpsc5jHoApdTj3E31wW
m2H+0uGRsoBDlzC+XLhCaWRq8x0rVSMzFI9PKNlX3rEZrw4Mo5CJGuzgXzQcNM1v
lALwa3xqil1QJoSf4/PT+eSccOOHSjZ4I3gymQ7K/kNl61lKy5i7NbTNzctiI/HV
7nlrihZ85lMyLQ0jSouL/YBhUlLMG3AeASuo+InhFZc0A6ZwJxEGM+YM9FArPmEX
afe+xcZwErjZV9cRH3JAgDc6aPR9cyd2YB8wHOB4ZAPvqz/5kILizTwGOnM6yOm+
VJ2m837tIijYzA3F+gSrcWxwz2rV0mVbNQ/CbXQbiq6rwjqfHmulwKnauIJ322bQ
9XCSGVMv+FzmPcyBjXvJ
=MUjC
-----END PGP SIGNATURE-----

--lCFQJunhLz1tFGpX--
