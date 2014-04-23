Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:19:45 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48358 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822311AbaDWLTWjX8c0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:19:22 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante.sirena.org.uk)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1WcvCw-0000MP-1X; Wed, 23 Apr 2014 11:19:18 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1WcvCt-0006gM-2P; Wed, 23 Apr 2014 12:19:15 +0100
Date:   Wed, 23 Apr 2014 12:19:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org
Message-ID: <20140423111915.GR12304@sirena.org.uk>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-6-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="48tF7E/GPXHbtDSk"
Content-Disposition: inline
In-Reply-To: <1398199596-23649-6-git-send-email-lars@metafoo.de>
X-Cookie: You will be successful in your work.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 6/6] ASoC: jz4740: Improve build test coverage
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39908
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


--48tF7E/GPXHbtDSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:46:36PM +0200, Lars-Peter Clausen wrote:
> Allow the jz4740 audio drivers to be build when CONFIG_COMPILE_TEST is selected.
> This should improve the build test coverage. There is one small piece of
> platform dependent code in the jz4740-i2s driver. It uses the DMA request type
> constants which are defined in a platform specific header. We can solve this by
> moving them from the platform specific header to the I2S driver.

Applied, thanks.

--48tF7E/GPXHbtDSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6GvAAoJELSic+t+oim9QNQP/3BJUmwUr6o+uu3krdMj9UTm
IbSLTXq9cT0JwG4IL2y+9vvy7zNiLIcRSgQTGbUAVCtftRGz/NnK+twD5idGCtDW
iU4esKJSM148DGfE6qExe7Ng8l/MhzPn/BvzTtKRGx4OwU7EcD3+qiHn2gL/Xjf0
4GYq6Ns/Ra2nkwNdFGB6bQ9aeWHbrQoGalpZpBvVR6NKLVbXeqQyG1U2x+GBJ01z
e2OEDEnR4IlGqlAChmiSF3JFgOl/tHz7krumHUFpaS943lUNvy3FK6r1AccXRvu2
/ipi6B8ebHS0DAF1lmAGOrdgdVwGhpCeZE0q1QH8oyWhnv+KqKw4x/9OJ1Xyo12j
JCG9WYMuaEDYzOMXhhQOd3bOK5KxEXr92M8X8hhQIS+biVGDmQfarhX+UwF19qlh
/6LQP2xwdsJCTPt4yZ3g+wLOl1mEtPqv39O0N6lk4u3w3KjtFo1W8vRvdlUjz0VG
yQobhiNZA73yOpw2fffTsnfluoLkVqpyKbsTxP8mzLDwEsKAkWesfChbJx/QNJSS
wemUnVIPTErMnVvxVJS7p2iH+2r3BiLQc/WlQulqhvq1y+QMn34RkeG3qtF68MUD
w/190gd5ElSuU5yQC+6ZiwYnlAhRr0hHgMojXapgt8F9aiLHSe7SO1uDIJ+xDwFD
FN39iOjLAaG4DzmNm+gN
=AmXx
-----END PGP SIGNATURE-----

--48tF7E/GPXHbtDSk--
