Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 19:28:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbeCES2dgzdWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Mar 2018 19:28:33 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BBA721486;
        Mon,  5 Mar 2018 18:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBA721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 5 Mar 2018 18:28:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 7/8] MIPS: qi_lb60: Enable the jz4740-wdt driver
Message-ID: <20180305182821.GH4197@saruman>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20171230135108.6834-7-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 02:51:07PM +0100, Paul Cercueil wrote:
> The watchdog is an useful piece of hardware, so there's no reason not to
> enable it.

Presumably this is important for restart to work after the change in the
next patch? Probably worth mentioning that too if thats the case.

>=20
> This commit enables the Kconfig option in the qi_lb60 defconfig.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

The change looks good to me though

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James
=20

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdjEQACgkQbAtpk944
dnpRnxAAoEQxrhZDUqJpdLEym/nqSZ24dEWfXloChiM4PcKwSpxyNIgCPr0Xj7aT
Ec9v6SxIR9ChLkqtDxa0nkt+XM6vubmCsFlCpp57yFwobg8C6jOl+A/c4MtICsj0
p3ec9IB5Uh/Od5zrXYLo62OQauO7h7oUC6pHXsNyND8LMhxoXlHIQ5L6OujNSMZs
ZV8zR+fo46iaj+zGdSVTaZynGh8oW2VxMzzwu47Zntv3YYYa00OqDvuaQGF89WNJ
WZme4o2tCVcqZk6E4z4Ax3L0eU46c0W4ZAknRto7pfoi4UmghMqEJ7sGj1syriwS
OQsLzwzIV2+OGyPQd5EKdZhJxEQ1BUZXAoovF9AieImvsn+l59VmYtpxcm6mT8JO
fJJDkazoKJMsbX64k/dYFsRSfCqUo0jUX3ZJoBUSsCaWJTxwYeWwVUHUYpBoGdU4
lSjLgEWtgKEy9JtjQZl34QXMmcqvPar8pnMF/egWK8vKi7HVa6YxJg8eJ5zezBRk
QgpXFxa1YpybVi/00Z9vuFUFg2TXXoNd3vOZnSoX/Mr40Fg5K04yvHZEiaJn/3/Q
SIUfpYHU3h+IXZDftAC+TD3k9iJetNyUZ5S8I2L5dtf4fmYzIGLmJVfHIW/dqduf
6pkqTEkLgaLx5LRRTZwk0cgtFuK00rQ/9RJndl5qSLiKTq+8FZI=
=Fr2u
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
