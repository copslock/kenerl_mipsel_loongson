Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 15:45:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58447 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991119AbdGXNpWDPq4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 15:45:22 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5CBD641F8E08;
        Mon, 24 Jul 2017 15:56:30 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Jul 2017 15:56:30 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Jul 2017 15:56:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0B861C8F240A8;
        Mon, 24 Jul 2017 14:45:14 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 14:45:16 +0100
Date:   Mon, 24 Jul 2017 14:45:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix
 quiet NaN propagation
Message-ID: <20170724134515.GV6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <20170721144504.GJ6973@jhogan-linux.le.imgtec.org>
 <EF5FA6C3467F85449672C3E735957B85015D9C3A72@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7TFYKOoUMIL+0w8y"
Content-Disposition: inline
In-Reply-To: <EF5FA6C3467F85449672C3E735957B85015D9C3A72@BADAG02.ba.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59226
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

--7TFYKOoUMIL+0w8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aleksandar,

On Mon, Jul 24, 2017 at 02:36:05PM +0100, Aleksandar Markovic wrote:
> > > diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fma=
x.c
> > > index fd71b8d..567fc33 100644
> > > --- a/arch/mips/math-emu/dp_fmax.c
> > > +++ b/arch/mips/math-emu/dp_fmax.c
> > > @@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, u=
nion ieee754dp y)
> > >       case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
> > >               return ieee754dp_nanxcpt(x);
> > >
> > > +     case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> > > +             return x;
> >=20
> > couldn't the above...
> >=20
> > > +
> > >       /* numbers are preferred to NaNs */
> > >       case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
> > >       case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> > > @@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, u=
nion ieee754dp y)
> >=20
> > ... go somewhere around here and fall through to the existing return x
> > case?
> >=20
>=20
> It could, but at the expense of code clarity and/or logical grouping of s=
pecial cases,
> which after this patch looks like:
>=20
>                . . .
>                  |
>   case of both inputs qNaN
>                  |
>   case of only x input qNaN
>                  |
>   case of only y input qNaN
>                  |
>                . . .
>=20
> If you agree, I suggest keeping the code the same as currently proposed in
> this patch, except that the following comments should be added in appropr=
iate
> places:
>=20
> 	/*
> 	 * Quiet NaN handling
> 	 */
> 	/* The case of both inputs quiet NaNs */
>    . . .
> 	/* The cases of exactly one input quiet NaN */
>=20
> Unfortunately, the code segment for handling of sNaN and infinity inputs =
do
> not follow the organization that I proposed. However, I think that my pro=
posal
> for case organization is the superior one - therefore I intend to keep it=
 in v4,
> unless you tell me not to do so.

Okay, I don't object.

Thanks
James

--7TFYKOoUMIL+0w8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll1+esACgkQbAtpk944
dnrSgw//XpLaZjf7mXHsG94fjZeki7JT2BrpfFlBbsV91XcgjVu+27O+kjW7Tgz9
5wc+bVEh4JuEYkdulEdMM4cWZgnlX0O3epuIakI+DNYs0w5dhmGB9IIgmxqOo33J
SJPA982HghaT3jB2AfiXbfHpg7WAfa7jYd44e3gn3w6zithtWpouWyJbvsM4HEF7
b6EBE4P6nK+drH6T93hraEbh9Wh1rkGCbWfc5lxp/XHyQJ0QmF3cRaa6duDiYpWw
dV7VuiN3GLziXb9BJelrE1uLdybeNGOkB9mOZV83UY+EWYQzkfO/lnHgz82RRL1R
a7JJ/OxpaeRdlFGXPWfeZEo8ArlbCxR+nej+uH6FnOhRnFHxMw2ESHNTrtcwxE5D
Z9VlFBIowt4mLzYsXRFXA//fVgiEvevDIxzYmb9ZEdXF+NB5TEfSlglMAMiqlcG6
60uq8ILMV2GhwVAHMatjlYYyXmMEpJKetd1qu37e5nhXSUFlUwo2Ii7/96kBE8de
OKvHOAUlTGjwom1KLwSEywe+rfX1+zjMJlILPWcfY07x8jBR9pmnGUuucykZERbJ
TsZAqO+hr6pyOHIxVfiRFpXt6WDOvTyFG59Ke81n/iNz81fN2gDGbRxSXDkkkEXg
86rsNBee7Q1pRtCNYhbMg3fBx08emnRC8FIRfkL1k3pTu2ZC7fA=
=T9xx
-----END PGP SIGNATURE-----

--7TFYKOoUMIL+0w8y--
