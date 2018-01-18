Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 21:33:22 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:42359 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARUdNYnddN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 21:33:13 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 18 Jan 2018 20:31:39 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 18 Jan
 2018 12:30:55 -0800
Date:   Thu, 18 Jan 2018 20:30:53 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7 11/14] MIPS: ingenic: Initial JZ4770 support
Message-ID: <20180118203052.GF27409@jhogan-linux.mipstec.com>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
 <20180116154804.21150-12-paul@crapouillou.net>
 <20180117212853.GC27409@jhogan-linux.mipstec.com>
 <1516295670.1423.0@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline
In-Reply-To: <1516295670.1423.0@smtp.crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516307495-452059-11115-9228-3
X-BESS-VER: 2017.17.1-r1801152154
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189121
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
X-archive-position: 62244
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

--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 06:14:30PM +0100, Paul Cercueil wrote:
> Hi James,
>=20
> Le mer. 17 janv. 2018 =C3=A0 22:28, James Hogan <james.hogan@mips.com> a=
=20
> =C3=A9crit :
> > On Tue, Jan 16, 2018 at 04:48:01PM +0100, Paul Cercueil wrote:
> >>  Provide just enough bits (clocks, clocksource, uart) to allow a=20
> >> kernel
> >>  to boot on the JZ4770 SoC to a initramfs userspace.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> >=20
> >=20
> >>  diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> >>  index bb1ad5119da4..2ca9160f642a 100644
> >>  --- a/arch/mips/jz4740/time.c
> >>  +++ b/arch/mips/jz4740/time.c
> >>  @@ -113,7 +113,7 @@ static struct clock_event_device=20
> >> jz4740_clockevent =3D {
> >>   #ifdef CONFIG_MACH_JZ4740
> >>   	.irq =3D JZ4740_IRQ_TCU0,
> >>   #endif
> >>  -#ifdef CONFIG_MACH_JZ4780
> >>  +#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
> >>   	.irq =3D JZ4780_IRQ_TCU2,
> >>   #endif
> >>   };
> >>  --
> >>  2.11.0
> >>=20
> >=20
> > MACH_INGENIC selects SYS_SUPPORTS_ZBOOT_UART16550, so I wonder whether
> > arch/mips/boot/compressed/uart-16550.c needs updating for JZ4770 like
> > commit ba9e72c2290f ("MIPS: Fix build with DEBUG_ZBOOT and=20
> > MACH_JZ4780")
> > does for JZ4780.
> >=20
> > Otherwise the non-DT bits look reasonable (I've not really looked
> > properly at the DT):
> > Reviewed-by: James Hogan <jhogan@kernel.org>
> >=20
> > Cheers
> > James
>=20
> I will fix it in a separate patch, if you don't mind.

Sure,

Cheers
James

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlphA/wACgkQbAtpk944
dnqNrxAAiomxWwHL1ajIRwecdeAIRqKGOgMlRc2M9KjLXS2GCcKGP8ANL1SSiWby
VAyZVgDGQPgF08vo7/NBAMpS+tRkMyA5XYB4XRHvcxHZliM0/yPvwvQuxRlhNwXY
al8WhJrY4Hb+BMw32mJdrpAj7A5EIZchA4sX37Un5031dizWGeR42rZnLcCL9WHd
pbuEA9XeMNQ7DsCRI1+M+FKR9POXYOuQR1WW982uhNvPxqrQWuFQy89B1kRalDZG
b/zTpOCRFZ7v4uIoHXOuM8G7ZdUjDNp9thxkB0lhtxA2fGAFRzF3g55K2d8NW8VC
N2enEoJFTjPWi+gFGZusnLCk73vA8BlAA01RdpXuukUyDj7dTgmchXh26XY1WZhh
DtzOr3UnMpglaX3n5j/9cFI3IhxGLSIF9hWJLmffqMfYK3j70knR1BZCmI0x9kOu
vH9mTDD5pc1VRExwnACPsRw7bxEhTfB8pFsBP5A30pEzryGnMiMjRSeZ/Sbh72tQ
o5877Kbz5beXWJ5CWGiRJzmKr+z7qxHhdW2CEBcUSAN/LLlsQOcwXEHJWQMQ+yDE
dWt+t4le0gkFVm1/R5vsutg6U+uCJLJQ48Z+9vGm0sQHM6EGdw7E8Z086rZsoIfG
DeTfyQJqJvpNZ50gKff/oT/N4zw+3PRdyBH78yKet1WtnyKS/lc=
=aC0a
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--
