Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 19:58:50 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36575 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011844AbbDXR6sK7JtQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 19:58:48 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ylhry-0003Mi-PH; Fri, 24 Apr 2015 17:58:31 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ylhrv-0000Q6-Uo; Fri, 24 Apr 2015 18:58:27 +0100
Date:   Fri, 24 Apr 2015 18:58:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-ID: <20150424175827.GE22845@sirena.org.uk>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i528gjSbuG1KhLiw"
Content-Disposition: inline
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
X-Cookie: Your present plans will be successful.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 0/4] spi: spi-ath79: Devicetree support and misc fixes
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47080
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


--i528gjSbuG1KhLiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 04:19:20PM +0200, Alban Bedel wrote:
> Hello all,
>=20
> this serie add a DT support for the ATH79 SPI controller and fix a few
> trivial bugs. While adding DT support we also remove the unused custom
> controller data in favor of the generic GPIO based chip select.

Applied, thanks.  Please use subject lines reflecting the style for the
subsystem.

--i528gjSbuG1KhLiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOoRDAAoJECTWi3JdVIfQif0H/0KKbqgnJDCivWhl36IofnCd
HJ0tD5a71yuw1PM12plvUSuwc7DUAy+OxiyIgdsEQ34KAbPlsIFKIqmLNzfpRCpl
x6KSl63VRSTfp3trZm6kgT6lzLJyCcq660yUEXMk+WOYjfl14DEscmcMLxWpClNY
h6ZiAH4wGsJwJRTQmO3rhKMVeVLfGcbZ6iviRLtJSd6SHuvJN03IYz5mOd1LdCvI
9xcx/Mnjyof5NEPZJvfU59fofz/SzFvMTJp3A08a16buxzf0q8cPBakPoGUd1VGp
iOtoQkLl7EmSvk/yaFCoJxxu5Bae1OPm6c7+h5yQeQXSkQtTYflqQL4F2oKkns4=
=evpm
-----END PGP SIGNATURE-----

--i528gjSbuG1KhLiw--
