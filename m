Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 18:12:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13531 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27027167AbcELQMaR8k30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 18:12:30 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4508541F8E9D;
        Thu, 12 May 2016 17:12:24 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 12 May 2016 17:12:24 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 12 May 2016 17:12:24 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id AE88815465C84;
        Thu, 12 May 2016 17:12:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 12 May 2016 17:12:23 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 12 May
 2016 17:12:23 +0100
Date:   Thu, 12 May 2016 17:12:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/5] MIPS: Add defs & probing of extended CP0_EBase
Message-ID: <20160512161223.GQ23699@jhogan-linux.le.imgtec.org>
References: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com>
 <1462971053-25622-3-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1605120115470.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E50aLcSU4JxQSj/B"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605120115470.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53413
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

--E50aLcSU4JxQSj/B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 02:10:41AM +0100, Maciej W. Rozycki wrote:
> Hi James,
>=20
> > diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> > index a6ce1db191aa..c4795568c1f2 100644
> > --- a/arch/mips/kernel/cpu-probe.c
> > +++ b/arch/mips/kernel/cpu-probe.c
> > @@ -858,6 +858,41 @@ static void decode_configs(struct cpuinfo_mips *c)
> >  	if (ok)
> >  		ok =3D decode_config5(c);
> > =20
> > +	/* Probe the EBase.WG bit */
> > +	if (cpu_has_mips_r2_r6) {
> > +		u64 ebase;
> > +		unsigned int status;
> > +
> > +		/* {read,write}_c0_ebase_64() may be UNDEFINED prior to r6 */
> > +		ebase =3D cpu_has_mips64r6 ? read_c0_ebase_64()
> > +					 : (s32)read_c0_ebase();
> > +		if (ebase & MIPS_EBASE_WG) {
> > +			/* WG bit already set, we can avoid the clumsy probe */
> > +			c->options |=3D MIPS_CPU_EBASE_WG;
>=20
>  You may additionally check for bits 31:30 !=3D 0b10 as a satisfactory=20
> condition for WG's presence, under the assumption that 0b10 is not very=
=20
> likely if a truly 64-bit exception base has been loaded.  E.g.:
>=20
> #define MIPS_EBASE_SEG_MASK (3 << 30)
> 		s32 mask;
>=20
> 		/* Avoid the clumsy probe if contents indicate 64 bits.  */
> 		mask =3D MIPS_EBASE_SEG_MASK | MIPS_CPU_EBASE_WG;
> 		if ((ebase & mask) !=3D CKSEG0) {
> 			c->options |=3D MIPS_CPU_EBASE_WG;
>=20
> or so.

Yep, good idea (I was originally working under the mistaken assumption
MIPS32 wouldn't have WG :-) ).

>=20
>  NB I find the current description of EBase questionable to say the least=
=2E =20
> This statement:
>=20
> "The addition of the base address and the exception offset is performed=
=20
> inhibiting a carry between bits 29 and 30 of the final exception address.=
"=20
>=20
> is repeated twice as if a leftover from the days before WG support.  I=20
> think this needs to be clarified in the case of bits 31:30 !=3D 0b10.  Al=
so=20
> I think the effect on the Cache Error exception vector in this case has t=
o=20
> be better specified.  Can you please raise it with the architecture=20
> documentation maintainers?

I agree, and ISTR its also stated that it must be set such that the
vectored interrupt spacing doesn't make it cross that boundary either,
in which case the inhibited carry is redundant. How it is supposed to
behave in the presence of cache error exceptions is indeed also
confusing, can it even ensure it gets handled from uncached memory? I
did raise this a while back, but will chase it up.

>=20
>  Also the description of DMFC0 is inconsistent with the corresponding=20
> pseudo code.  As from r6.04 of the instruction set document the pseudo=20
> code has been updated to take into account the R6 semantics for 32-bit=20
> registers you rely on here, however the description still claims such=20
> operation is UNDEFINED.  Can you please raise it with the architecture=20
> documentation maintainers as well?

Yes, I'll chase this up too.

Thanks
James

--E50aLcSU4JxQSj/B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNKtnAAoJEGwLaZPeOHZ6QTgQAIAPBWqtgzrAXjuRBgaQ5mse
gCcO1+qLxsHiYqRx43hq1krPUbLksITfJigP4HZgPmMteZ5L7CfjCyNnrVadnfmc
pbgTn7orh2RJNHI1UAj1OftDhae9fx3dqkJOZWBmZ/tkGmH3fJ1gJj5/n5cWMAP5
9fqcZP2Lx1r29uYBDpj6BV1BvpkI+puFASbh/pzuMdeeWBGAqrdJ3pw6/J0D6YS9
pnsbnG7Oifa2aksX+9d4PSACRznTg+s7rVWjYpOvi0O0GM+9eN7bNbMowp42UChy
YdbGxA7n06Cl+zwe+TfDI5zwPRzIAGhN/qbgmkQTizp6ncqALjDtVkRAM9PEcfpX
U8r2BUH4BCiuwd8P9tEToCIIwcgWIzaMtE3IdUPhQ2NAUGWK0TGLj6Dx+PMasCwm
gs0q+BGmkm40jCguQ65MjWbmSdiF1shAFChtAh3fef/u5eD77sWON2GVLM6JKHJR
NX+8+wju/ES4G0jW+btC/dDJfLFJ8xN6aD+U7vwkt7G4b/fUj+Ln1k8Ibyxn4JQO
rTQmZRuyxs1M1XWcCI95ZQuIFNcrEleaZWZXYy4Rg8PJBcfFJsRbW2wcd3TtPeSp
l+FMNyoQDT77RsR0D8JWveZgHHW8TOqvMUQgcUz04H5zqxoIMxlur1Qs7IFUQk3Z
CkW81e0EQzfrP4O5T4CY
=mqF1
-----END PGP SIGNATURE-----

--E50aLcSU4JxQSj/B--
