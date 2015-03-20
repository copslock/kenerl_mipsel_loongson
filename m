Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 13:56:33 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40165 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008505AbbCTM4bpJ0Hg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 13:56:31 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwTV-0006hQ-Rx; Fri, 20 Mar 2015 12:56:30 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwTT-0005U7-3s; Fri, 20 Mar 2015 12:56:27 +0000
Date:   Fri, 20 Mar 2015 12:56:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Message-ID: <20150320125627.GK2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-2-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="09CsGkDdkTpDWDy8"
Content-Disposition: inline
In-Reply-To: <1426853793-24454-2-git-send-email-bert@biot.com>
X-Cookie: Wanna buy a duck?
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46474
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


--09CsGkDdkTpDWDy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 01:16:32PM +0100, Bert Vermeulen wrote:

> index 856d34d..0d55661 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -616,6 +616,7 @@ struct spi_transfer {
>  	struct sg_table rx_sg;
> =20
>  	unsigned	cs_change:1;
> +	unsigned	fast_write:1;
>  	unsigned	tx_nbits:3;
>  	unsigned	rx_nbits:3;
>  #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */

One other thing I just noticed: this is extending the core with no
documentation or other comment on what it's supposed to do (there's no
commit message at all).  Any changes to the core should be a separate
patch which makes it clear what the changes are supposed to do.

--09CsGkDdkTpDWDy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDBj6AAoJECTWi3JdVIfQ+0gH/3CSDV+t3aCoq0dmjFaFmxke
VI4J7E7lmrMLkzIUonknHHNr0ZBevgB+qVAVb2+D13cn9T3pdCC8rmrVyeP8AkbY
Zwt4TihTAw7KKUJGTFWRTOHguWRLQFSuTM8pQqqX+2Rj/AS1Ez7vW1P03pQkJviV
kTI3iiomN+iA9sdkcHHPINeRijtIVQh++cgJKYfRHLXxwuwNcBRox5c5AzDzEyKg
K9B3QRZupeyUVNZWRGiWSNSGLUxEF7qz/6fpC+i9131j6ybSr+Atg2x4D3nWJgFS
ph9LVVavMtkzDUgQRIzf+kGrfQA9FvC/XRhVZihMsTFDIn+dp8xmKlk5fyfhizM=
=4K//
-----END PGP SIGNATURE-----

--09CsGkDdkTpDWDy8--
