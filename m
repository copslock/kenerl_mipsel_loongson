Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 21:04:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50214 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993405AbcGKTD5iPxTY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 21:03:57 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2117E41F8E08;
        Mon, 11 Jul 2016 20:03:50 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 11 Jul 2016 20:03:50 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 11 Jul 2016 20:03:50 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1DD8EE9B9B0C6;
        Mon, 11 Jul 2016 20:03:45 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 20:03:49 +0100
Date:   Mon, 11 Jul 2016 20:03:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/12] MIPS: Fix definition of KSEGX() for 64-bit
Message-ID: <20160711190349.GB26799@jhogan-linux.le.imgtec.org>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
 <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
 <alpine.LFD.2.20.1607111543480.12953@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1607111543480.12953@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54287
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

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Mon, Jul 11, 2016 at 03:56:09PM +0100, Maciej W. Rozycki wrote:
> Hi James,
>=20
> > This will help some MIPS KVM code handling 32-bit guest addresses to
> > work on 64-bit host kernels, but will also affect KSEGX in
> > dec_kn01_be_backend() on a 64-bit DECstation kernel, and the SiByte DMA
> > page ops KSEGX check in clear_page() and copy_page() on 64-bit SB1
> > kernels, neither of which appear to be designed with 64-bit segments in
> > mind anyway.
>=20
>  Thanks for the heads-up!
>=20
>  This is not an issue however with `dec_kn01_be_backend', because the KN0=
1=20
> baseboard used with the DECstation 2100 and 3100 computers has an R2000=
=20
> processor mounted in a permanent manner (no CPU daugthercard as with some=
=20
> later baseboards) and will therefore never run a 64-bit kernel.  In fact =
I=20
> think kn01-berr.c would best only be built in 32-bit configurations.  I=
=20

Okay thanks, good to know.

> never got to making such a clean-up though; I may look into it sometime a=
s=20
> I have some 2100/3100 stuff outstanding.
>=20
>  As to the SiByte platform I have no clue offhand; there's surely some=20
> stuff there across the port asking for a clean-up.  I reckon using the=20
> data mover for page ops is a kernel configuration option and I may have=
=20
> never enabled it myself.

Indeed, one that defaults to no and isn't enabled in any defconfigs.

I think I'll update this patch to make that configuration depend on
32BIT, just in case any physical addresses of RAM have bits 31:29 =3D
0b100, which previously would have failed the test and fallen back to a
CPU copy, but with this change would have carried on and mistranslated
the pointer to a physical address on the assumption its in KSeg0.

Cheers
James

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXg+2VAAoJEGwLaZPeOHZ6y2gP/2wSkvLaoAVsRuIbHfr02qsD
BWrWhyo79GFsGL+Ce2ogeWlmTlU3ATsF3wnaivdFb75etHZzYqLhmuaMZRGuFmGv
MBaV2BcrHGvspzW45IIElMJv5l3PzY75TMQAAvtFW3Z4hhgIx92ZvEJa4O5ntuLv
f165AUaic4t8aIbFVWCfbg2maVeGTffFqynNr3CIHmpgeJFvFR+ETgzLySGlFnMq
kc3UduQlQ04gTswxTcHG9zwnT1W0UcbnfXExMqPkIPRkoGmN7DMO4TgVbsilKYR9
1XduVO8ZORqp1Qt/X5nhd6IstlIwc2E6/aLCePAzwaKWCeh3NHyo8Yv99MEcbcU7
0v0kHlBu/gYp4WuWT8E+O6sPyu509LxsYABwTf74zGmDss3YUdSy3WlcNYR0dOdQ
UsgQUJ43lDMS3XWWIAni0byBeLFW0x+lI/y6S7S97Egw+Fkcu4mWjb8sbwnOSCTz
zum4NqPiHA1iud7EF6RDYScTbl44L1sVrqAftqaQDgScGZTmss388r7XLrCnBpdd
eydYHhu7VWeQA9VAN+yzQIDuHM6U4W7hz0bPrfCzvxddo3cnWi8+o6Y8OmwvuODg
QKt52SRs54FkHSUrJXOHhN53wPm2lT7SJndX+ogk/+CNtUL+PB+hexlkdlL4NwiT
sTtF0YysR20sF02LtiAO
=bX1C
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
