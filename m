Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 14:50:57 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59051 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009746AbbJMMuzd2TFV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 14:50:55 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Zlz2E-0007Df-1i; Tue, 13 Oct 2015 12:50:30 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Zlz2A-000377-Vg; Tue, 13 Oct 2015 13:50:26 +0100
Date:   Tue, 13 Oct 2015 13:50:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Seiji Aguchi <seiji.aguchi@hds.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mike Waychison <mikew@google.com>,
        Matt Fleming <matt.fleming@intel.com>
Cc:     kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Message-ID: <20151013125026.GG14956@sirena.org.uk>
References: <E1ZlxDc-0000ea-U4@optimist>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <E1ZlxDc-0000ea-U4@optimist>
X-Cookie: Do you like "TENDER VITTLES"?
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: next-20151013 build: 1 failures 50 warnings (next-20151013)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49516
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


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 11:54:09AM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:30: error: macro "DIV_ROUND_UP" requires 2 arguments, but only 1 given
> ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:4: error: 'DIV_ROUND_UP' undeclared (first use in this function)

triggered by f6e734a8c16229 (MIPS: BCM47xx: Move NVRAM driver to the
drivers/firmware/).  Presumably this works due to an implicit inclusion
on MIPS.

I've CCed a lot of people listed in the changelog of the patch, though
the list there appears somewhat random - apologies if this is irrelevant
to you.

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHP4SAAoJECTWi3JdVIfQ+FkH+QETm0uoq8QzKkCB1+hL6nhz
OSnimOD7kPHYQhYoxtep3eA5jgSl5z/QtjdtLw7QItWmRpvkhnq71AfB0ulVes76
cs5seo5qnangpHKI/BA+PozcFVuiK9/4X4gR0A2jaHL6s4MP/d3mGxbWbm+cVRgt
3ij4avFF7aG6UP7YCJdtFNtnH8ih3+HC15ZyVPBacxphzhVxUBDC4w2FoEy/Z72i
IdlXgAWbdGKk+BLkhvAZSviJzORXBwwKsSZFPACWwuF39d7EZd86NUOjP+Vw6gKn
bExHLUrBmc2f3DVwBS1xNPiXKf6r8262FuCBzT8EI0SzT6v4eiy8zfJqVvo8IPg=
=IHqc
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
