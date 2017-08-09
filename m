Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 13:45:29 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([IPv6:2400:8900::f03c:91ff:fedb:4f4]:44164
        "EHLO mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995200AbdHILomX7Rn3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 13:44:42 +0200
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dfPPT-0006SB-Hs; Wed, 09 Aug 2017 11:44:25 +0000
Received: from broonie by debutante with local (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dfPPR-0006Tp-1G; Wed, 09 Aug 2017 12:44:21 +0100
Date:   Wed, 9 Aug 2017 12:44:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com, p.zabel@pengutronix.de, kishon@ti.com,
        mark.rutland@arm.com
Message-ID: <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="76oohoz2fusi4hjt"
Content-Disposition: inline
In-Reply-To: <20170808225247.32266-4-hauke@hauke-m.de>
X-Cookie: You will lose an important tape file.
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 2001:470:1f1d:6b5::3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59455
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


--76oohoz2fusi4hjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:

> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.

Why?  Is this assumption reliably true?

--76oohoz2fusi4hjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmK9ZQACgkQJNaLcl1U
h9AHSwf9Fq1OGMyZ9pNQve/uU1k7zR3YCjYuG4FAiLJ7uyu52Gbu6Jhy2kZNIn4Z
CthKUBdR/SdY6Qfhm0kk82z5Q2Jg6gc0FNzVPjXHe0nRL6oFvGyO8Zs8UL0hfJsn
8TMv7S+ApJMSjM7Aayj/Gx1bCq1GBG2s9LLhllMVfOgY0JVh5ofTzy4Egt1cfY26
SK/DTBgpOJc66xrLAOV7Z6GluBSvyOpFvoobbH8YvKEM+iV+QALKZ4u4UjKI8UJG
BNUTEqnljsgLIL8wvoEHFSwh9DSenQbKdzI1sUNkFF0cA7MnrrSez3vfuigi0nZo
Cwhde95F1WGQNdz3R2Cf83JlTMrOBw==
=fsAd
-----END PGP SIGNATURE-----

--76oohoz2fusi4hjt--
