Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2015 17:45:17 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35308 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011122AbbDJPpQGXP0P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2015 17:45:16 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ygb7F-0006PU-2C; Fri, 10 Apr 2015 15:45:09 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ygb7C-0004p5-0f; Fri, 10 Apr 2015 16:45:06 +0100
Date:   Fri, 10 Apr 2015 16:45:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Message-ID: <20150410154505.GM6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
 <20150406163905.GL6023@sirena.org.uk>
 <5526EFA0.2010108@biot.com>
 <20150409215047.GE6023@sirena.org.uk>
 <5527ECC3.1000209@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgP3ep6s6oWoM+py"
Content-Disposition: inline
In-Reply-To: <5527ECC3.1000209@biot.com>
X-Cookie: I've been there.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46854
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


--mgP3ep6s6oWoM+py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 05:31:15PM +0200, Bert Vermeulen wrote:
> On 04/09/2015 11:50 PM, Mark Brown wrote:
> > On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:

> > implementation of that standard API to the core.  It *sounds* like
> > you're just trying to implement two wire mode which does have a standard
> > API, please use that.

> Can you please advise what kind of solution would be acceptable then? I need
> to signal from an SPI protocol driver to an SPI master on a per-transfer basis.

Please refer to my reply above...

> Also, I have no idea what you mean by two-wire mode. This "fast mode" is SPI
> + one extra pin.

SPI_TX_DUAL.

--mgP3ep6s6oWoM+py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ/ABAAoJECTWi3JdVIfQHnkH/2RtnbZDBAPSWGyuBsbA7EP9
UAeU4TYPsx0VpZjzx6g7TAVIgnLaysxe4II0fI3Z9MZosxj5dTmCGWguNHtpWZE7
vFXWx/55JhazlWmCVdxFAdQKJ+pmQAHSQ/ymFooJ1ZxMly5DAiABPT58aPjYyqQr
wABLeWbQuAAMSaV2690FPa7ENPldsxipum4RCrfHMwGXLjyeeTw7NBvKvnrjsezV
Wxi91QqiuxRKjD7EZJ7nLlUebh55VWHv8FwprBQJMkZvu0amsSHLLBA3YY/76mm0
nwjpB3XiGAtxffbMeaVdqwxgCSaVT2oKBWWXn/Wou9JiSjroxryhy9jGZi/NH8w=
=6CLs
-----END PGP SIGNATURE-----

--mgP3ep6s6oWoM+py--
