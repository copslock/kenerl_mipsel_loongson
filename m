Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 13:19:41 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33662 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011023AbcA0MTjrUXKO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 13:19:39 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOP4L-00079R-0B; Wed, 27 Jan 2016 12:19:29 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aOP4I-0004MS-6P; Wed, 27 Jan 2016 12:19:26 +0000
Date:   Wed, 27 Jan 2016 12:19:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>
Message-ID: <20160127121926.GJ6042@sirena.org.uk>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
 <1568100.dTeADjCOTa@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <1568100.dTeADjCOTa@wuerfel>
X-Cookie: Brain fried -- Core dumped
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 1/2] regmap: Add explict native endian flag to DT bindings
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51477
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


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2016 at 12:02:19PM +0100, Arnd Bergmann wrote:

> I think the rest of the file also needs to be changed, and we need some
> more explanation about native-endian, which people might think is the
> right one for them when it rarely is in reality (Broadcom MIPS being
> one notable exception).

I'm not sure it's *that* confusing at this point but this is definitely
a lot clearer.

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqLXNAAoJECTWi3JdVIfQzfUH/2blGgj2hpWPCXJ+mzEsmp99
+L4l9gr/KCY3BcrWyrpDDUJNAf1QVQKI+fLUSY+8jrdCF6WDUqhzAN+JjZgu1g4F
M9XPH8T0wpKaF9ELHatKdGQ1wFqZUlXB4uGwbzbamzyLDhPJRXWO0uniNvsCfovb
EFQ4pvthsbx2PgPWk1CauvhFisZtUgNPSE9tttB17ZlwhEMQYiOAXoAdLurhYimC
5exhXDh0E56LBBpi9TJDC97v84q+cNn2IaQN2yqVewmIRQl+pLH+xsyLTZj6T8Yj
OmpkzqZ5nGH8RtFtx8hhXONflz5S8jOq+xT1odQp714u/E+DVOMzRI7JIBcwh6I=
=TFng
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
