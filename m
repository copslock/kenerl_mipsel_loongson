Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 12:34:15 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55872 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007962AbcCFLeNKVdXA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 12:34:13 +0100
Received: from 110-170-137-3.static.asianet.co.th ([110.170.137.3] helo=finisterre)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1acWwe-0006t2-L1; Sun, 06 Mar 2016 11:33:57 +0000
Received: from broonie by finisterre with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1acWwZ-0003M6-Ia; Sun, 06 Mar 2016 18:33:51 +0700
Date:   Sun, 6 Mar 2016 18:33:51 +0700
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
Message-ID: <20160306113351.GL18327@sirena.org.uk>
References: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ggeZL9srFYs+Kb9b"
Content-Disposition: inline
In-Reply-To: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
X-Cookie: Adapt.  Enjoy.  Survive.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 110.170.137.3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [RESEND PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI
 peripheral
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52475
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


--ggeZL9srFYs+Kb9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 06, 2016 at 10:05:26AM +0530, Purna Chandra Mandal wrote:
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>=20
> ---
>=20
> Changes in v2:
>  - fix indentation
>  - add space after comma
>  - moved 'cs-gpios' section under 'required' properties.

Please send the *whole* series so I can keep track of which things go
together.  There's no need to put noise words like RESEND in the subject
line.

--ggeZL9srFYs+Kb9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3BWbAAoJECTWi3JdVIfQeNEIAISKzTeq9WaU+tNeO6UB474T
TFJTECa+atYwUu7Kp+ZgZg47tqEej+dkiZ5quwRl3z4vH6r6WXL+pPVqeSAJN9bb
PZIxCVlX6LbBsE2lMX/jk3wbyamDe9KNJDhgLluZIlb+pR2/sZpOKpFLYAlqAzMR
LQ/1XKu4YbcY4/RnqNBEwaC0iXovQoG9Ic+vw5aVywIuh+nzn5V1AuTq3sQxm9r8
Xjv6rW1gyGkIjW7EEkYl9CIT5JO33NoC+t0KZLTkaYTZ40Wr4uFNWKt/9lT79g3t
2q5jnuT/Qm2peoY4lHOcT3nPU/LC5iyV264qyCPJpYw775DyopdNfjqMQ7URSio=
=fk2t
-----END PGP SIGNATURE-----

--ggeZL9srFYs+Kb9b--
