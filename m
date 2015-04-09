Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 23:50:56 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33804 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010894AbbDIVuzFYEQd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2015 23:50:55 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YgKLa-00016U-C9; Thu, 09 Apr 2015 21:50:50 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YgKLX-0005CB-HI; Thu, 09 Apr 2015 22:50:47 +0100
Date:   Thu, 9 Apr 2015 22:50:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Message-ID: <20150409215047.GE6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
 <20150406163905.GL6023@sirena.org.uk>
 <5526EFA0.2010108@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gkncWFjxA+un9L7+"
Content-Disposition: inline
In-Reply-To: <5526EFA0.2010108@biot.com>
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
X-archive-position: 46848
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


--gkncWFjxA+un9L7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:
> On 04/06/2015 06:39 PM, Mark Brown wrote:> On Mon, Apr 06, 2015 at

> > I queried this on a previous version and asked for the code to be better
> > documented...

> I documented it in the commit message:

I'm asking for the *code* to be better documented.  Right now it's just
raising obvious questions which are at best going to cost people time
digging for the reasons.

>  The m25p80-compatible boot flash and (some models) MMC use regular SPI,
>  bitbanged as required by the SoC. However the SPI-connected CPLD has
>  a "fast write" mode, in which two bits are transferred by SPI clock
>  cycle. The second bit is transmitted with the SoC's CS2 pin.

>  Protocol drivers using this fast write facility signal this by setting
>  the cs_change flag on transfers.

> The cs_change flag is used here instead of the openwrt version's
> spi_transfer.fast_write flag. The CPLD driver sets this flag on a
> per-transfer basis.

No, this is broken - it's abusing a standard API in a way that's
completly incompatible with the meaning of that API which is obviously a
very bad idea, especially since good practice is to offload the
implementation of that standard API to the core.  It *sounds* like
you're just trying to implement two wire mode which does have a standard
API, please use that.

--gkncWFjxA+un9L7+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJvQ2AAoJECTWi3JdVIfQ690H/2PjnawZ5UsBCvUeNspUcNPX
jcowu4muM67lLh3z2KQBour+N+6dKNjl7IQn3FTzTIiSxPsXCeWZF3HcfeEoC2hd
GDOdk+JytWk4zehN9jnvtVw51LJC83IptdFEn6PRgkWlmmyus2fgwEfBoAlmS0uX
/6x4FGPSu7X5Zf8GBFpjTHLa9oBESdL1AfaXAVhAosCcC6YsUGndmub/cBjWzAfs
96hdh51x+s1uR7EDtfn4LjVCesqxvQ/1M8N3GqykZCqlucVRfz/DqLGROFo4XZYp
BBoMmNnHZxWNs4CHRvcIg0MEOyRXoC5HSO95M7LlJkV5QgqzZucWp1XZVyGad7Y=
=kqIm
-----END PGP SIGNATURE-----

--gkncWFjxA+un9L7+--
