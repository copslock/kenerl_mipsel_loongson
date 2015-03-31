Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 10:44:34 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39458 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006802AbbCaIodNWq1K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 10:44:33 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ycrme-0005ds-M3; Tue, 31 Mar 2015 08:44:29 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ycrmb-00021A-S7; Tue, 31 Mar 2015 09:44:25 +0100
Date:   Tue, 31 Mar 2015 09:44:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com
Message-ID: <20150331084425.GI2869@sirena.org.uk>
References: <1427739857-13395-1-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k0ZRCT9yCxlKcKW0"
Content-Disposition: inline
In-Reply-To: <1427739857-13395-1-git-send-email-bert@biot.com>
X-Cookie: Wanna buy a duck?
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46642
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


--k0ZRCT9yCxlKcKW0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 08:24:16PM +0200, Bert Vermeulen wrote:
> Changes in v2:
> This is a near complete rewrite of the original OpenWrt driver. All comments
> were taken into account, and the spi_transfer.fast_write flag is gone.
> Instead, the cs_change flag is used. It's not too bad a hack, as it really
> does use CS.

Don't send cover letters for single patches, if there's anything that
needs saying it should either be in the changelog or after the ---.  A
separate cover letter adds to the mail volume and probably means that
the patch itself is inadequately described.

--k0ZRCT9yCxlKcKW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGl5pAAoJECTWi3JdVIfQINsH/2SYu3oaYferb6YG3DJM6BZz
p41HA/vLqkIQYOk1HZy9XuUWdj3A4hQ60sflTooqymPaxa1l3ibHor+43f67AmWf
QHGVX8O5BabytdZ3o+9k5kw8F6vs8CxciaHeZjrSmTGjWLS3/atEEKU88WM2u134
h/JeTHeskj6xU5hjRRi45DBWpqO5/U1dYtxkT3QKG8Aw91dRDdWScnSJBy2RwppS
gdoF+49y+fP2zR/rkWeo/EobANxFAvUzFlsbwcoUY/u/WNpWNeUSmp/j/ag9f8Ll
q7Pv6f1vgcLswJSF9xO/yT0iPRTMaKSxKnc25bDIE2zZT5Tgl1RjgtEZ2xNUL7M=
=CfCM
-----END PGP SIGNATURE-----

--k0ZRCT9yCxlKcKW0--
