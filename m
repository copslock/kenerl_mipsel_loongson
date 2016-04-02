Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2016 18:35:24 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56214 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006613AbcDBQfXTEoa5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Apr 2016 18:35:23 +0200
Received: from [216.2.64.20] (helo=finisterre)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1amOVw-0001Q7-2k; Sat, 02 Apr 2016 16:35:08 +0000
Received: from broonie by finisterre with local (Exim 4.87)
        (envelope-from <broonie@sirena.org.uk>)
        id 1amOVu-0001uY-2L; Sat, 02 Apr 2016 09:35:06 -0700
Date:   Sat, 2 Apr 2016 09:35:06 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Message-ID: <20160402163506.GD2350@sirena.org.uk>
References: <1459509530-22716-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dds9jO4idXToq0wP"
Content-Disposition: inline
In-Reply-To: <1459509530-22716-1-git-send-email-purna.mandal@microchip.com>
X-Cookie: If anything can go wrong, it will.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 216.2.64.20
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v5 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52838
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


--dds9jO4idXToq0wP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 04:48:49PM +0530, Purna Chandra Mandal wrote:
> Document the devicetree bindings for the SPI peripheral found
> on Microchip PIC32 class devices.

Please use subject lines reflecting the style for the subsystem.

--dds9jO4idXToq0wP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW//S4AAoJECTWi3JdVIfQjfEH+weHKWmxXd0vqovgGShGg0Cd
lvdbe/YcGan7+wIQY4RfnbuEBgv7SCVDZETrTbKNTFDu/GSxYfzNZQBPCU8PPbzb
3OQhH3thPKGTsAWdmNGQMTn8B7vCh2HvcNUdDwDFQF8ooMklBNTd4NyjKifuNqto
PG3VtRHfzjDabfrLnvsuAjRJj9cT3xsYW+Q+/ztZFT2ree6kKwsUL7qL6pDgwhO6
0FjKVOVZCtUwhLAcMwCNQDovVVyDKcKfkdb9FZP8pIQyEvx4q6icygfeVbBinYk/
rb22jYg72YKvF+r14gCz6iimQh3GvSiowYoGSk5wOo6ADU8kuhXBNlxdXBBrrf8=
=+uPx
-----END PGP SIGNATURE-----

--dds9jO4idXToq0wP--
