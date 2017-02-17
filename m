Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 14:39:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41611 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991672AbdBQNi6Q4cEM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 14:38:58 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 40E3541F8E51;
        Fri, 17 Feb 2017 14:42:58 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Feb 2017 14:42:58 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Feb 2017 14:42:58 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5B11CB4F576F6;
        Fri, 17 Feb 2017 13:38:49 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Feb
 2017 13:38:52 +0000
Date:   Fri, 17 Feb 2017 13:38:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Robert Schiele <rschiele@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] mips: vdso: Explicitly use
 -fno-asynchronous-unwind-tables
Message-ID: <20170217133851.GZ24226@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1701261445520.13564@tp.orcam.me.uk>
 <20170126150005.2621-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CjAlqr6ZqJYkDGFX"
Content-Disposition: inline
In-Reply-To: <20170126150005.2621-1-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--CjAlqr6ZqJYkDGFX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 04:00:05PM +0100, Alexander Sverdlin wrote:
> From: Robert Schiele <rschiele@gmail.com>
>=20
> Not every toolchain has -fno-asynchronous-unwind-tables per default on MI=
PS.
> This patch specifies the necessary option explicitly for VDSO library bui=
ld.
>=20
> This prevents the following build failure:
> GENVDSO arch/mips/vdso/vdso-image.c
> arch/mips/vdso/genvdso: 'arch/mips/vdso/vdso.so.dbg' contains relocation =
sections
> .../arch/mips/vdso/Makefile:84: recipe for target 'arch/mips/vdso/vdso-im=
age.c' failed
>=20
> Signed-off-by: Robert Schiele <rschiele@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: "Maciej W. Rozycki" <macro@imgtec.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: linux-mips@linux-mips.org

Applied

Thanks
James

--CjAlqr6ZqJYkDGFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpvzaAAoJEGwLaZPeOHZ6bfoP/3g48uJtsUi9+MeoM+eDIE/b
Wml3pKikX45r3V4dk3URLw38D2TAOS/1YUT70Ds6pqlxfGDe8pUoMOntDZViewpU
cySlLz1jd7dCNpli77oWL/e8u4G4E4M+PJZ617yKF5LI9VcF4r6CZr8PvNod8wH5
fpigI0tQWYnD+ILApT8Db/8D4r05ulzQBU7oY7xcPQT6warc6J1jHS2xd+lX/fB5
ZIpLE/g0EiIbT5AQtV54ey+hs7Vb/iMy1zw8gjyPO6iVDgQcJLGi4m1SnaN/8FE2
C4lICUkB4XWa8HST4vxawYAZgeXgrmxnziaWvp6nXFe11RPF1njR2Xt+0H1hCerq
m5VM6V789v1YV/JebsTUGfkca2gGjDx2AAAP2Cog56FgmrT9n1OAYfy9TjkAMuPk
KB5/6Wkg6JA/A57hviFxoZlfCyPaAwHZ3l9vHf6h2xJ8abgoDbSnvXF+Bv5juADP
cOPG59oi3n6yKLK6TpLN9kAWCYTwmgcNnK4I9KCp1aEWUVnsETvtN9sGtutR7XuU
UfDdU2CtiSCuRvzuzcCQzTYiW5b10QUwhwbTWRs938my1HEtQxPu1Zp078Z6b4a8
Rj0LKlzhfU+LgCvj2zg1wgpsmh6uwGkm+TUFm5WKWFhDhE5D55X2q48ypKoupI2U
20qtWOMKkKB6zy4a1csP
=N53x
-----END PGP SIGNATURE-----

--CjAlqr6ZqJYkDGFX--
