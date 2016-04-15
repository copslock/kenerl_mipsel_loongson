Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:15:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61597 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026614AbcDOKPnT9FRq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:15:43 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D470641F8EE6;
        Fri, 15 Apr 2016 11:15:37 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 15 Apr 2016 11:15:37 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 15 Apr 2016 11:15:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id AB97818EB214E;
        Fri, 15 Apr 2016 11:15:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:15:37 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:15:36 +0100
Date:   Fri, 15 Apr 2016 11:15:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Use copy_s.fmt rather than copy_u.fmt
Message-ID: <20160415101536.GC7859@jhogan-linux.le.imgtec.org>
References: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
 <1460711246-4394-2-git-send-email-james.hogan@imgtec.com>
 <20160415095941.GI1524@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20160415095941.GI1524@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52995
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

--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:59:41AM +0200, Ralf Baechle wrote:
> On Fri, Apr 15, 2016 at 10:07:23AM +0100, James Hogan wrote:
>=20
> > From: Paul Burton <paul.burton@imgtec.com>
> >=20
> > In revision 1.12 of the MSA specification, the copy_u.w instruction has
> > been removed for MIPS32 & the copy_u.d instruction has been removed for
> > MIPS64. Newer toolchains (eg. Codescape SDK essentials 2015.10) will
> > complain about this like so:
> >=20
> > arch/mips/kernel/r4k_fpu.S:290: Error: opcode not supported on this
> > processor: mips32r2 (mips32r2) `copy_u.w $1,$w26[3]'
> >=20
> > Since we always copy to the width of a GPR, simply use copy_s instead of
> > copy_u to fix this.
> >=20
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: <stable@vger.kernel.org> # 4.1.x-
>=20
> Looking good but seems to apply only to 4.3+
>=20
>   Ralf

Yes, sorry. Without bf82cb30c7e58b3a9742f0a45962ebdf51befac7 I figured
the changes in r4k_fpu.S can be easily skipped, but actually I should
have looked deeper as the macros aren't even used until that commit.

Could you change the stable tag to 4.3 please.

Thanks!
James

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEL9IAAoJEGwLaZPeOHZ6SLEQAKTu1BCjGsC3866WXo7oLM9N
DpN0W1dZ4nL9Ehh7JhD0RzEJCGq/hEsj6NNUSzhWdSvU+Sa2caSiDaveOHO7ziUc
CsK5j9rB5ryvv1cKBt17xK/ITjBCInJiCtY+b4sILnqebConn3n492V2nCJhIbEE
+lZVh1Lic6a+AAb6lnL/V1RDxyjNDK5I0KLFY2eX7so2ienBewWd0kwiivfA8F19
6nSHGEGoVhveL3mphUXPhZEdWnqBn4kBSYlGhFpYNYxeHDuT2QFPL9EoD7I2nO34
Ux9fYPvM5TB0RF1x+neYGWre7iKXlO8MMMiUna5a9gHpznXH84nQNn0yc43djC6R
fNuhMZRmI821H7azZMt34fCZiYCsTd7Iy8hVyrJPt8Uli4UlT58UJBnuu+B264fA
zr/QyHxcAajJzon6HkBHxEB/PihQhNSP4a5OexCNE6Tajf5Fyg2UcErfjKpWkaah
gbq5cm4WgToC8yylp2VQhYts6Je9hfSIKumNUnEwi+YT1/1d3HOa3VYrc4+uKlnF
zMznKCCHw1beSoXPRIi8wByGDuQz+JPmN1JGtw5TJ0KRVz7w/gc86/IWmeA+4Gkl
Ex+YWA/UeM/ydCgxf2GLM3cy9+XIoNIdW3v+eI3HxNfVC8dEDSqTQGVw3DfFF41m
YpyKJvj1tr/dmk/BLP+6
=Qa4r
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
