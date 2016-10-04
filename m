Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 11:10:03 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:35686 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992168AbcJDJJzyx0P9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Oct 2016 11:09:55 +0200
Received: from tock (unknown [78.54.106.158])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7883BB005AF;
        Tue,  4 Oct 2016 11:09:43 +0200 (CEST)
Date:   Tue, 4 Oct 2016 11:09:40 +0200
From:   Alban <albeu@free.fr>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Aban Bedel <albeu@free.fr>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
Message-ID: <20161004110940.57d112df@tock>
In-Reply-To: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/NV__COsg_+C4i9zmzUmdrqS"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/NV__COsg_+C4i9zmzUmdrqS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  3 Oct 2016 17:35:31 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Please use device tree instead of adding another board file.

Alban

--Sig_/NV__COsg_+C4i9zmzUmdrqS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX83HUAAoJEHSUmkuduC28Pa4P/0gTGAtAWCqqU/E0FwwQcr1S
ljD0B5LAfcidHvVRHof50H1xT7BFxlFUUXZHJNtSCpSH+3bm7TeC1ZxGIzxHTwUJ
hNV6eEDI1FtKOfX1K2y9+2G6gbyqr6J4YkCyoq9bqz3GFp+qIm6WqBG2XAIDrVZE
jI1Bxd3rB2I+BGy4+iA6vKZrV1cCaZVBj1TijuvffMBZRQi5EFBsVcteThwXqz6p
uuQ6Lu0k/c3yX5w8eByIh0Crw57lQzXxTIffx0Np4vfBgU5VVKWm5ZTwvgIs3PTA
5i1q2J94O6j9gkmuT3IItJRdz42u6Sv3WCxBTFlmM0zw58My0JWFZRDfjCfdCNWt
e8R/xq1/cueDsip/cLH8qpNT4/EPza6HWZVKtBoXOUaW1tkPyZnYXguRtcJ0kTTv
7UqOIqvJCIZVtlYlfyegSl58jxgujz7+vNlr/uekhtC9tceyUTM3pYcEFP+wXsun
C29OxkBTLaPOkJsAguPmL8Ts1CC7TIEVXKANleOhmUbDhGHiY+CoWp7a7dz+omG9
IsKL1KAs8vxCzQZ4UUm95J6Jnuf0CVpGltPsOfFBvOIV8Cfsz03Bvgw+KTr1NAnn
ldJ7AxRRaFAnZ1d2icEzawC+aamYLCbAS8Mp2rRZdJIv3Ft69frW5/BjjWsyX5Ai
/OkOo3Uv9Pb16j5aWd6F
=32BB
-----END PGP SIGNATURE-----

--Sig_/NV__COsg_+C4i9zmzUmdrqS--
