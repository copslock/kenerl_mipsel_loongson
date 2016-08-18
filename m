Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 20:12:03 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49830 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993135AbcHRSLzTqCw- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 20:11:55 +0200
Received: from debutante.sirena.org.uk ([2a01:348:6:8808:fab::3] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1baRn6-0007i3-QT; Thu, 18 Aug 2016 18:11:47 +0000
Received: from broonie by debutante with local (Exim 4.87)
        (envelope-from <broonie@sirena.org.uk>)
        id 1baRn2-0006xF-0M; Thu, 18 Aug 2016 19:11:40 +0100
Date:   Thu, 18 Aug 2016 19:11:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Message-ID: <20160818181139.GS9347@sirena.org.uk>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/OxAoNYcURhUkoHv"
Content-Disposition: inline
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
X-Cookie: I can't drive 55.
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: 2a01:348:6:8808:fab::3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 0/3] MIPS: TXx9: Common Clock Framework Conversion
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54660
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


--/OxAoNYcURhUkoHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2016 at 07:34:24PM +0200, Geert Uytterhoeven wrote:

> Patches 1 and 2 can be applied independently.
> Patch 3 has a hard dependency on patches 1 and 2.
> I don't know how you prefer to handle this?

I can sign a tag for pulling in easily enough for the SPI change.

--/OxAoNYcURhUkoHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtfpaAAoJECTWi3JdVIfQUZoH/iQFeSN75ptSllwhU4cxzmL3
GQuPrk70Ogkv5rX6oZs0n2lxoA5Ag+lECP7QxPIBSK7MMfFABUDr9uI7oNzTS8XY
Ww7eyY/gx1zha0MUgnjTAmcONgfibXZljnRggHpjvMNfZRrHEnEWAU/jlHksEv39
Q0aVntPDksyjKKkVv2x16uKZBubyr44axnPq7RltYEK8DH74coKcOeZwHQbslgjO
/Llj8kshJSsJ3IrEsNBiOCzoW2EFT82S7Cm7cFxmSVJf4Vx7vntR/AYtE85fW6RY
wEEHt+ObqlDvAPviCZe0Z+zxqG0o8qcXwJNm0lDyB95kJf5ulXOU0DhQDZB04Uc=
=IkHd
-----END PGP SIGNATURE-----

--/OxAoNYcURhUkoHv--
