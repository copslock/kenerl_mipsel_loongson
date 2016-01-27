Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 19:51:35 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34507 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011772AbcA0SvdukzFv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 19:51:33 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOVBb-00028Z-9f; Wed, 27 Jan 2016 18:51:23 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOVBY-0000Yx-Cb; Wed, 27 Jan 2016 18:51:20 +0000
Date:   Wed, 27 Jan 2016 18:51:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20160127185120.GB25316@sirena.org.uk>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
 <1453848410-24949-2-git-send-email-broonie@kernel.org>
 <56A7FE3F.5090909@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <56A7FE3F.5090909@gmail.com>
X-Cookie: How come wrong numbers are never busy?
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian
 behaviour for syscon
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51482
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


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2016 at 03:16:15PM -0800, Florian Fainelli wrote:

> v4.5-rc1 now contains an arch/mips/boot/dts/brcm/bcm6368.dtsi which
> copied the 6328.dtsi and therefore needs this hunk to be added to your
> patch series:

Folded that in, thanks.

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqRGnAAoJECTWi3JdVIfQ0t0H/3pKFB+V7ThI+IyAfvBz7my/
3u5jQOWhFcfhdBm9t+DYEzvait3iSEWX6PY9U65uthyJ+IH3riz+vSGkrih0dacp
8Cab6KGlVJK4kz0MZTucumCj+jho0Ocfqzgvc8duHk9dnHr3aLpaa/Qu2+SGYLBw
x/l5TIMWczfTZXl55AR/+Ad4D6cd26qsEqb7FxhijUTQWrKBSH0PXvOnRFn/SbB7
YboeBTWGaQY5owA38BLZ8qAMh73UqbFjNNTvi8IEqWbzZWo9MPccm0oEnCRKc4Ej
odaz/SS5SRBVce76WFmodkmnm2AFWVvgkuDDzR0KABr5f0f1HR4nrMyCNwk9epU=
=o+ju
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
