Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 18:06:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9341 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992110AbdBJRGhfEF3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 18:06:37 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DEA8141F8D87;
        Fri, 10 Feb 2017 18:10:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 10 Feb 2017 18:10:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 10 Feb 2017 18:10:18 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0280B3E18D157;
        Fri, 10 Feb 2017 17:06:28 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 10 Feb
 2017 17:06:31 +0000
Date:   Fri, 10 Feb 2017 17:06:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <john@phrozen.org>
CC:     =?utf-8?B?QW5kcsOp?= Draszik <git@andred.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: ralink: fix mt7628 alternative functions names
Message-ID: <20170210170631.GD24226@jhogan-linux.le.imgtec.org>
References: <20170210090659.21873-1-git@andred.net>
 <17885154-71f7-2d1e-7046-757e092de508@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <17885154-71f7-2d1e-7046-757e092de508@phrozen.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56758
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

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 10:12:24AM +0100, John Crispin wrote:
>=20
>=20
> On 10/02/2017 10:06, Andr=C3=A9 Draszik wrote:
> > They're all referenced as utif in the datasheet, not util.
> >=20
> > Fixes: 53263a1c6852 ("MIPS: ralink: add mt7628an support")
> > Fixes: 2b436a351803 ("MIPS: ralink: add MT7628 EPHY LEDs pinmux support=
")
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <git@andred.net>
>=20
> I was under the impression that I had sent this patch already, maybe it
> got lost somewhere along the line

Yep:
https://patchwork.linux-mips.org/patch/14899/
Applied as commit 58181a117d353427127a2e7afc7cf1ab44759828

Though without Fixes or stable tag, so if that matters we'll have to
explicitly request backports.

Cheers
James

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnfMPAAoJEGwLaZPeOHZ6IUwP/AgoeQ6NWnNuPCAOMV4QL9mc
4GrV53CHITIAQj02RhurYISHfQ6Hi50QAfGXqYqclxu6wb5OB3V1ssPSuJepCyeU
14h6RZqFGUgQlP/U732Vb9bWCZXWk3+pECrBwZIgLzzVe10Dd9pMJ2D7B3fkymvT
vhF0Vx/CLp4YBGxJpDFnzlMV2ArXSCV4oV6OHDABYf7Sp4fQa+hYr6brcgK/7Tte
oPp/vZ3+N4DjxmDNuI58718OyxLxtH5XYdrqzUIpGkFiYblkg4AuHtXnFiwbpyaC
sXSxAqE+iNUhOZBGLczHdDDrVIJZ8ftvV/oQzEWU+uR9KqF85/M0OEcNNtYQbudR
s+Vxh8+Xc1x/EoILXUScCv5izbA18fS60gZ+D7uBFN1H07LHcMlWixt93bNGv8lb
H6W9u0iz/0JnXZtKbLkVVjLyCYA+kBTfQ7mt2Utr6alecu97W8m9g/ZV2Th2cPz8
WOxH/U2IgyFty243ASUbzR7jMHa6pyjvlfUtUfwAgRmARhLDZ5maC5xPAL3RN9a6
H/c8Zp7PxtmUjPuJJh+u5IM6tgankGLheGJzuM/mT3c4bq0NBPMK16l8XgkZDFMU
732vA0+8z2jdqJxxZDtqZIjTKKa3fxiBIag+3cvDiCY/QzIQ+4c6Xaoasmuluqj8
N/JQzTSExrAhVFoZAfgr
=J6ea
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
