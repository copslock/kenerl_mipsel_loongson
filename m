Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 16:46:27 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:46902 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993035AbdJLOqTwy4sk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 16:46:19 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 12 Oct 2017 14:44:56 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 12 Oct
 2017 07:43:37 -0700
Date:   Thu, 12 Oct 2017 15:44:34 +0100
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
CC:     Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        "Raghu Gandham" <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Message-ID: <20171012144434.GF15235@jhogan-linux>
References: <20171012101753.GB15235@jhogan-linux>
 <683c-59df7500-1-10d973a0@9889400>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <683c-59df7500-1-10d973a0@9889400>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1507819495-452059-11690-92231-1
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185921
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 03:57:50PM +0200, Aleksandar Markovic wrote:
>=20
> > Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception st=
ats for certain instructions
> > Date: Thursday, October 12, 2017 12:17 CEST
> > From: James Hogan <james.hogan@mips.com>>@badag02.ba.imgtec.org>
> > > ...
> > > if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E)
> > > ...
> >
> > But just before that condition it does:
> >
> > ctx->fcr31 =3D (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
> > I.e. it clears the X bits used in the condition, and overrides them,
> > based on rcsr, which is initialised to 0 and is only set after the
> > copcsr label and in a couple of other cases I don't think we'd be
> > hitting for MADDF.
> >
>=20
> The code is odd and deceiving here. Let's see the whole "copcsr label"
> code segment:=C2=A0copcsr:if (ieee754_cxtest(IEEE754_INEXACT)) {=C2=A0 MI=
PS_FPU_EMU_INC_STATS(ieee754_inexact);=C2=A0 rcsr |=3D FPU_CSR_INE_X | FPU_=
CSR_INE_S;}if (ieee754_cxtest(IEEE754_UNDERFLOW)) {=C2=A0 MIPS_FPU_EMU_INC_=
STATS(ieee754_underflow);=C2=A0 rcsr |=3D FPU_CSR_UDF_X | FPU_CSR_UDF_S;}if=
 (ieee754_cxtest(IEEE754_OVERFLOW)) {=C2=A0 MIPS_FPU_EMU_INC_STATS(ieee754_=
overflow);=C2=A0 rcsr |=3D FPU_CSR_OVF_X | FPU_CSR_OVF_S;}=C2=A0 if (ieee75=
4_cxtest(IEEE754_INVALID_OPERATION)) {=C2=A0 MIPS_FPU_EMU_INC_STATS(ieee754=
_invalidop);=C2=A0 rcsr |=3D FPU_CSR_INV_X | FPU_CSR_INV_S;}=C2=A0ctx->fcr3=
1 =3D (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;if ((ctx->fcr31 >> 5) & ctx->fcr=
31 & FPU_CSR_ALL_E) {=C2=A0 /*printk ("SIGFPE: FPU csr =3D %08x\n",=C2=A0 c=
tx->fcr31); */=C2=A0 return SIGFPE;}

Note: thats the one in fpux_emu(), not fpu_emu() which this patch
modifies. In fpu_emu() the copying of bits from rcsr to fcr32 and the
SIGFPE checking takes place outside of the switch, after other stuff can
modify rcsr.

>=20
>=20
> Value of rcsr will be dictated by series of invocations to ieee754_cxtest=
(),
> which, in fact, means that exception bits will be copied from fcr31 to rc=
sr.
>=20
> Then, fcr31 exception bits are cleared and set to the values they had just
> before clearing.
>=20
> Obviously, this will not do anything in our scenarios.
>=20
> However, the patch is about correct setting of debugfs stats, and this co=
de
> segment correctly does this.

Right, but its not going to even get to copcsr until this patch, so the
SIGFPE handling is I think fixed by this patch, i.e. it isn't just about
the stats.

>=20
> May I suggest that we accept my patch as is, and if anybody for any reason
> wants to deal further with related code, this should be done in a separate
> fix/patch?

This patch fixes something, I think it should
a) be clear in the commit message what is fixed
b) be tagged for stable (though that can always be done
retrospectively).

Cheers
James

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnff9IACgkQbAtpk944
dnqZDw/9EmQHm147EC6ygbN7v+CRlHTu/v86ulpFPXyVGxcTvqL1W5lRn2R/kzOx
H1/O2Gm3ZDEwW+BtSqJzVK+fZGe1tqVyVSyTc8lTU144yftOY7W6IfoWUB01Uvgn
LleE78R3wky5GMQwFevg9Z84q2AuOec++hazuQJ0t4H/2s9ZLCcCviEiHSeLONDW
bKZGI20h4SOpf15cXBewEm+hI+NZfkF35a3uTFIkRqS0nQkQWOFy7Az8n5qmcaP4
5jMA/1B1tnFQPL1j2MAS2hlHEByflv6hIEyH0rQ8Y+492+omckKQmwkiHAdqi2uW
3/uqWnAG3ZowDOOJBwFEtlzpo3g97NpjAnrp0XTdZUOBlXhatv+Ed9VrmCRmQDoM
4Z1cu9mlatY6wFCLLRiigf1fV0ZySvqN0NH2PK/GkQS0WymZiddJbRy22bv0LmAB
fmAuVRDnmxJUEHVAePl0Zv7QN7BZ2Rkqzp8efGzyDohDUF/z5B28p96/2EUs7KYy
Ri++RStSWvE3n/Fu3ehXUzv/i6RW3/gsc9K2YgzRXMIDZ1Tz/kPfTN8Sdh7oBn4K
vEjOg5RZ4e5nSdQQmH8XPEYZGPqXQmkx9EUUjx0nH8dirn3f2zxJIq/d0kw/qbGn
7fOfFh4pChm8/13Fbq34nTkpc6wZitO0VzlR/geyEn9J/ee6fvk=
=tjTC
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
