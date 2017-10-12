Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 12:19:18 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:56389 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdJLKTLMpZwR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 12:19:11 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 12 Oct 2017 10:17:56 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 12 Oct
 2017 03:16:58 -0700
Date:   Thu, 12 Oct 2017 11:17:54 +0100
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Message-ID: <20171012101753.GB15235@jhogan-linux>
References: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1507310955-3525-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <20171009210923.GA20378@jhogan-linux>
 <EF5FA6C3467F85449672C3E735957B85015DA0AF13@badag02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <EF5FA6C3467F85449672C3E735957B85015DA0AF13@badag02.ba.imgtec.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1507803476-637138-902-91701-1
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185916
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
X-archive-position: 60379
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

--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 04:18:49PM +0000, Aleksandar Markovic wrote:
> Thanks, James, for the review.
>=20
> I've got a couple of points bellow that will, I hope, clarify several iss=
ues.
>=20
> > ________________________________________
> > From: James Hogan [james.hogan@mips.com]
> > Sent: Monday, October 09, 2017 2:09 PM
> > To: Aleksandar Markovic
> > Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Douglas Leung;
> > Goran Ferenc; linux-kernel@vger.kernel.org; Maciej Rozycki;
> > Manuel Lauss; Masahiro Yamada; Miodrag Dinic; Paul Burton;
> > Petar Jovanovic; Raghu Gandham; Ralf Baechle
> > Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP
> > exception stats for certain instructions
> >=20
> > On Fri, Oct 06, 2017 at 07:29:00PM +0200, Aleksandar Markovic wrote:
> > > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> > >
> > > Fix omission of updating of debugfs FP exception stats for
> > > instructions <CLASS|MADDF|MSUBF|MAX|MIN|MAXA|MINA>.<D|S>.
> > >
> > > CLASS.<D|S> can generate Unimplemented Operation FP exception.
> > > <MADDF|MSUBF|MAX|MIN|MAXA|MINA>>.<D|S> can generate Inexact,
> >=20
> > nit: s/>>/>/
>=20
> Will be fixed in v2.
>=20
> >=20
> > > Unimplemented Operation, Invalid Operation, Overflow, and
> > > Underflow FP exceptions. In such cases, and prior to this
> >=20
> > Well, according to the manual I'm looking at MAX|MIN|MAXA|MINA can't
> > generate inexact, overflow, or underflow FP exceptions
> >
>=20
> The "MIPS64=C2=AE Instruction Set Reference Manual" v6.00 mentions that a=
ll
> five FP exception are possible for MAX|MIN|MAXA|MINA, but in v6.05, the
> list was reduced to only two, as you hinted. I am going to sync the commit
> message with v6.05 of the document.
>=20
> > ... and in practice
> > the only FPE generated by emulating these instructions is invalid
> > operation for MADDF/MSUBF. So presumably that's the only case we really
> > care about.
> >=20
> > I.e. the MADDF/MSUBF invalid operation should be counted, but crucially
> > the setting of rcsr bits allows it to generate a SIGFPE which from a
> > glance it doesn't appear to do until this patch. The other changes are
> > redundant and harmless.
> >=20
> > Does that sound correct? (appologies if I'm missing something, I'm just
> > reading the code, and reading FPU emulation code late at night is
> > probably asking for trouble).
> >
>=20
> You are close, but not quite, I'll explain that in a moment.
>=20
> First, just to note that SIGFPE will be generated if the condition
>=20
> ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E)
>=20
> is met (the code is almost at the end of fpu_emu(), cp1emu.c, line 1557).
> ctx is one of the arguments of fpu_emu(), but, in the current state of the
> code, by analyzing several levels of invocations, it can be concluded
> that ctx will always be equal to &current->thread.fpu. So, the register
> current->thread.fpu->fcr31 is actually important here.
>=20
> Now, let's consider, for simplicity, the case of MADDF operation resulting
> in an overflow caused by addition of two large FP numbers. The "special"
> treatment of such case will be done within invocation of ieee754dp_format=
(),

Ah yes, obviously an MADDF can generate those other exception bits :-)

> which will in turn (in this particular example) execute
> ieee754_setcx(IEEE754_OVERFLOW), which will further execute
>=20
> 	ieee754_csr.cx |=3D flags;
> 	ieee754_csr.sx |=3D flags;
>=20
> and, since ieee754_csr is macro for &current->thread.fpu.fcr31, this will=
 result
> in setting tworelevant and correct bits in current->thread.fpu->fcr31.
>=20
> This means that condition from few paragraphs above will be met, and SIGF=
PE
> will be generated.

But just before that condition it does:
ctx->fcr31 =3D (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;

I.e. it clears the X bits used in the condition, and overrides them
based on rcsr, which is initialised to 0 and is only set after the
copcsr label and in a couple of other cases I don't think we'd be
hitting for MADDF.

Cheers
James

>=20
> Whole above scenario happens regardless of inclusion of this patch.
>=20
> Actually, setting exception bits within "copcsr label code" seems redunda=
nt.
> It though does no harm. I have some theory why is this code here, and why
> we even may want to keep it as is, but this would be too much for this ma=
il.
>=20
> >=20
> > Given the potential fixing of SIGFPE in that case should this be tagged
> > for stable?
> >=20
>=20
> As I explained above, SIGFPE behavior is already correct, without this pa=
tch.
> This patch fixes only debugfs stats. So, it is not that critical.
>=20
> Looking forward to your response.
>=20
> Aleksandar

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnfQVEACgkQbAtpk944
dnoI1g//bUJPTz4hVfI4hBRn5dfQHsZuys/fR6FEEtT86QMOfrizAvtxVLJawWlR
6b5CnSwN9L+y49cd6rsR36Pqk+PFthEOmpsQUOTtJ0NjW6Uc+nucz+D7gNQLJpxa
Qj7TmECkeSn32/0JPPjrBNoylriXSnBKJebhVu5CujQfAe8Hfn/OFsyYO9ahsWOP
CH0+MdgWxCAdA2TZTfb4X0ZClMou15fVqzLppl11CEe6lckJYbML3h2sdPY3MaUt
4ZDX/mloV7QA/RVhjM8wj57FWus1zp3rRCzb2ucd/c4w32UOAvn8BXHED3dlyGGS
1YNnTid6QoCfSA8WKliu8b7M3zXe8WgEXxqcripwduGDWVaC8a17KHW2mQzzX3VW
3+Rjsh2oJBzfKX3oEWFx29MRTTGT9tb/oseccVqrPylM+7uDoZR68ICJ569omdDS
/i4cCIOVIjtYkKGks25SsqkxVfoRdAIBYRmDqY9CwuzJVMM0xsAsKEtWG3i+CkAw
K1Z7zNinUa4yv+IhkvHLuVpBI8Jckq3PeCf0bO/ossmReEe/HslxODaX6Pc9N5vb
WZK3YtOwfOj9nRj4RBG69jxXNZIEUGveyzHbn+oIAb+Wu/xu/SHxNQ7NwICpSe5v
VPIS+m6Yjz5+8rE6YKH/7xRdBAf7I4+Mk2JpduSnYoo0aI1JjtA=
=HVy7
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
