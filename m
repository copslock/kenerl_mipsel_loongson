Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 06:02:50 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54695 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007068AbbCWFCtS43h3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 06:02:49 +0100
Received: from [12.104.145.3] (helo=soju)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YZuVh-0007mz-S3; Mon, 23 Mar 2015 05:02:46 +0000
Received: from broonie by soju with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YZiZF-0001md-Op; Sun, 22 Mar 2015 16:17:37 +0000
Date:   Sun, 22 Mar 2015 16:17:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Message-ID: <20150322161737.GE6643@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-2-git-send-email-bert@biot.com>
 <20150320125139.GJ2869@sirena.org.uk>
 <550EA6A4.6010206@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <550EA6A4.6010206@biot.com>
X-Cookie: Two heads are more numerous than one.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 12.104.145.3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46488
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


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2015 at 12:25:24PM +0100, Bert Vermeulen wrote:

> It is bitbanging, at least on write. The hardware has a shift register that
> is uses for reads. The generic spi for this board's architecture (ath79)
> indeed uses spi-bitbang.

> This "fast SPI" thing is what makes this one different: the boot flash and
> MMC use regular SPI on the same bus as the CPLD. This CPLD needs this fast
> SPI: a mode where it shifts in two bits per clock. The second bit is
> apparently sent via the CS2 pin.

Please make sure that all this is visible to someone looking at the
driver, it's really not at all clear what's going on just from reading
the code.

> So I don't think spi-bitbang will do. I need to see about reworking things
> to use less custom queueing -- I'm not that familiar with this yet.

Mostly it's just a case of deleting the loops and using the core ones
instead.

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDusgAAoJECTWi3JdVIfQF00H/1CX4uVd9kD+thBosHoEGVPU
vDmCiJ7Ctm1baIBF3I1zqC7IOSxuJC4oHiIK+I5FnEfnlZuToIC2IbBIFRRou1G/
z1AE2HX5lwIj1HgsdhOxzkmS9XszIE4jI4yvA7POlk4u0+mhn8mGwKwDLZQ3NGBF
9nmFp2RRXMeg1wM9139kfTPcfPlPG7rDLKin4LRBTBQd8gllZ8bv4xjForq5ewU3
AKrb00Mj3bfm4ia5Ai9zQKFa3oKdHWWP+HHGmS29Wgk3ICeGbxl3FRukiKPFrLmk
s/ljtrc6Jjst/WZaBSfsJ6IoXWE1Qg6o6DchokmKvvqCKqyrpjyIJ69T6JdxuM8=
=sXDW
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
