Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 14:52:31 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54152 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbcLNNwYJPByB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2016 14:52:24 +0100
Received: from [2001:470:1f1d:6b5::3] (helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cH9yk-0003jA-8q; Wed, 14 Dec 2016 13:52:20 +0000
Received: from broonie by debutante with local (Exim 4.88)
        (envelope-from <broonie@sirena.org.uk>)
        id 1cH9yg-0001LU-3a; Wed, 14 Dec 2016 13:52:14 +0000
Date:   Wed, 14 Dec 2016 13:52:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org
Message-ID: <20161214135214.osrlldhxvxzfwial@sirena.org.uk>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73qb2l33x3vvnctr"
Content-Disposition: inline
In-Reply-To: <58510536.04c7190a.4a2fb.ae5c@mx.google.com>
X-Cookie: I represent a sardine!!
User-Agent: NeoMutt/20161126 (1.7.1)
X-SA-Exim-Connect-IP: 2001:470:1f1d:6b5::3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82
 warnings (next-20161214)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56045
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


--73qb2l33x3vvnctr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 12:39:18AM -0800, kernelci.org bot wrote:

> mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
>=20
>     allnoconfig: FAIL
>     generic_defconfig: FAIL
>     ip27_defconfig: FAIL
>     tinyconfig: FAIL

These MIPS builds have been failing in kernelci ever since MIPS was
added.  This means that we've got a constant level of noise in the
results which makes them less useful for everyone - people get used to
ignoring errors.  Is there any plan to get these fixed?

--73qb2l33x3vvnctr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRTo0ACgkQJNaLcl1U
h9Av1Af+KcKhRgCq9Umy/FHchgZM7YBsZW4NmzAI7UIqe2dD0KeHiMnpVCHh/xVp
0+XVGJAcX1DJJGa5Ntvx0EqMS9ONTTgmw0z2mtr4S8NrKwhd8xgoPKlext6vChhn
tVMTyZBv+vps16GEJsbG8jRo4Oq4uwAoeOqK7z+GIAMtzvQ4jHCs+lyLW4WPpylY
SAmaCMZvYA3ge5L84TUaI6j+lfPk53JQ/4AmWtnKtS3x14NkVDXqhazMUZL88KvS
h35fVHg9O8bT+O5WbmbQrvgZ9b00BBPEZ7EM7EeYSGsNyFYI4x9+TYltN/reg+yA
ejCw9XmjzMoTJEMEU9p91N0oS99N4w==
=v9M+
-----END PGP SIGNATURE-----

--73qb2l33x3vvnctr--
