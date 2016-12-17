Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2016 19:29:14 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:41786 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991940AbcLQS3GYiKWr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Dec 2016 19:29:06 +0100
Received: (qmail 20991 invoked from network); 17 Dec 2016 19:29:05 +0100
Received: from p54b3386e.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@84.179.56.110)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 17 Dec 2016 19:29:05 +0100
Date:   Sat, 17 Dec 2016 19:29:05 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jan Glauber <jglauber@cavium.com>
Cc:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Message-ID: <20161217182904.GB27020@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-4-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-4-jglauber@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56062
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


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:57AM +0100, Jan Glauber wrote:
> Do not infinitely retry register readq and writeq operations
> in order to not lock up the CPU in case the TWSI gets stuck.
>=20
> Return -EIO in case of a failed data read. For all other
> cases just return so subsequent operations will fail
> and trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-current, thanks!


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVYPwAAoJEBQN5MwUoCm2cGwP/2qwvzqjasvY+TXxD7Jl9JbO
Qi0Kx0gm9TUJsISJZ68EeHIAjZwhHI+CjkUdvFKFwqcvMs7PviHAa/7PAEGGZBsg
SSOI+o4N+gRYt/h6tJpiKC93rE3DOBrxKyXk9OYqevxA6+b30CNmSstbWFJt613W
tDf9Pzl5U2Ay2gYZRozws1Q2e3Dmt86M3y79KNaGxiD/sh0kH1VbKG+iZ5pt9T+D
DnUCtcRmv5vJH3kWDSLF2vLp4vJoQ65XIoUyubFwkwOB0vCouNLfjkd9SwABcfSG
Jj6wRq99na5WLnc0teRMMWinqqV/HOmXGa2shM1Llvy9dM4vMPxUXrXXIUUMaLuP
A2P2WifF/xcI6lQpEaR9wFoRckgawm4cwwHY/LLz6yp4aYR1Z1CNJ5d72ettnPIh
bQmOeGanF3Q6Aow4Fw1aAyBrm7CrjhKcMaMOKdc86CWe4WnJSwqbWYPayC2QUJyX
eREdrO5YHUk9Bh/hhFnBWKCW2Xds41mzhF4tSpi+xWTwsvfcRnnhrb43m7XcPp/P
fzrTCSWOaD4QdmiLhF4laRz8UAl65z2MCbqo4ybar+kSHmxtTrCw/kZPiP1PbVN2
C61eij7fG5IGIdEn9zKFSd8sT+HpulTHyI6pFZRWKqbHY194JjjvcA11Yok++98W
uzRgxwY7Xih3vJFk1KnZ
=fEnR
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
