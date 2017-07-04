Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 17:39:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46351 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993859AbdGDPjXryYO7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 17:39:23 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F3AF641F8DF5;
        Tue,  4 Jul 2017 17:49:37 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 04 Jul 2017 17:49:37 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 04 Jul 2017 17:49:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ACB4EB0070424;
        Tue,  4 Jul 2017 16:39:14 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 4 Jul
 2017 16:39:18 +0100
Date:   Tue, 4 Jul 2017 16:39:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] MIPS16e2: Report ASE presence in /proc/cpuinfo
Message-ID: <20170704153917.GA6973@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230230220.2590@tp.orcam.me.uk>
 <20170703202323.GM31455@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1707041635000.3339@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SPLgQB0HFVQkxokU"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1707041635000.3339@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59017
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

--SPLgQB0HFVQkxokU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 04:35:51PM +0100, Maciej W. Rozycki wrote:
> On Mon, 3 Jul 2017, James Hogan wrote:
>=20
> > >  Submitted third in the series so that the presence of "mips16e2" in=
=20
> > > /proc/cpuinfo not only indicates the hardware feature, but our correc=
t=20
> > > unaligned emulation as well.
> >=20
> > This should be mentioned in the commit description (not the 3rd in the
> > series bit, the "it indicates both the hw feature and unaligned
> > emulation" bit).
>=20
>  Shall I repost the series with this piece amended?  Or will just 3/4 do?

Just 3/4 should do I think.

Thanks
James

--SPLgQB0HFVQkxokU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllbtpYACgkQbAtpk944
dnrELxAAvlJnsFZSBOCenwPzozpgtobSCQR2j33EWuaS1GmZHKCsOFa2FTJhcUxj
0WADH+020L8J0rOGF5RtOIepwtmqCcmBq3Da9sTLd2MHGzRoZZyaRPOILWgyeMWD
SSxzZGxxZ530eyPGTl3qTsHOBcXEuNW+iPJ7QcPKfRTHMBLCJab3SEc5696SDfPy
APDkBcZc+vP0HUPQ+tQ2Ihq4X9vQEKKomqExgNUOKho1ttfNVIBLxiL/gwFoCX4D
OILYLUzL6UjIe52T+StfOPl+Pux/jOBSUd/XtZ+FR09bYk03Jb3XVbI0RCpFGkTL
WlgJy01DIsQcxSH0swh5Ok/Z5sFVoSZYK0tLAK/HM1+RQEEVz81/zT/ZjG2kCIOP
8UsUNb6OApV8F8PzWMfaKnKxfrYA7gbbv1AXZWr0lJrawCnNV9s8Bx6irMLQdt2G
dVrxsnjwBVRKCJmGub3DKH6lz6tgNphkFszZTYKrXViFgO3WQfjQgj9ZAw+TgECg
R+2V/xJ6pni+v88V0aeA08rDin3sMak5GqKEkc/owDHx3FJrCzuAXV9ouYp9KKGe
5zSaMLbhw3rSPQdLH5saP7zxKjw5qbVxF96AzTpA6yyWpiTkFyEhu0jJOdMZ6wT7
baX88thBwMS6aM3l8pZcJDsIjLQcJVzs0C7o9k59tRR6/S3oI48=
=LQJ7
-----END PGP SIGNATURE-----

--SPLgQB0HFVQkxokU--
