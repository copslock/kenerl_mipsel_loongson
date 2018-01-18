Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 21:30:36 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:36510 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARUa1cyIuN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 21:30:27 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 18 Jan 2018 20:29:47 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 18 Jan
 2018 12:28:38 -0800
Date:   Thu, 18 Jan 2018 20:28:36 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Antony Pavlov <antonynpavlov@gmail.com>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: use generic GCC library routines from lib/
Message-ID: <20180118202835.GE27409@jhogan-linux.mipstec.com>
References: <20180117065121.30437-1-antonynpavlov@gmail.com>
 <20180117090348.GA20406@mredfearn-linux>
 <20180117163418.ba77b2f72298092fb843fda7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FMJTF8LVhUQkvsEb"
Content-Disposition: inline
In-Reply-To: <20180117163418.ba77b2f72298092fb843fda7@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516307384-321459-31040-6010-9
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189121
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62243
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

--FMJTF8LVhUQkvsEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 04:34:18PM +0300, Antony Pavlov wrote:
> On Wed, 17 Jan 2018 09:03:48 +0000
> Matt Redfearn <matt.redfearn@mips.com> wrote:
>=20
> > Hi,
> >=20
> > On Wed, Jan 17, 2018 at 09:51:21AM +0300, Antony Pavlov wrote:
> > > The commit b35cd9884fa5 ("lib: Add shared copies of
> > > some GCC library routines") makes it possible
> > > to share generic GCC library routines by several
> > > architectures.
> > >=20
> > > This commit removes several generic GCC library
> > > routines from arch/mips/lib/ in favour of similar
> > > routines from lib/.
> > >=20
> > > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > > Cc: Palmer Dabbelt <palmer@sifive.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: linux-mips@linux-mips.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  arch/mips/Kconfig       |  5 +++++
> > >  arch/mips/lib/Makefile  |  2 +-
> > >  arch/mips/lib/ashldi3.c | 30 ------------------------------
> > >  arch/mips/lib/ashrdi3.c | 32 --------------------------------
> > >  arch/mips/lib/cmpdi2.c  | 28 ----------------------------
> > >  arch/mips/lib/lshrdi3.c | 30 ------------------------------
> > >  arch/mips/lib/ucmpdi2.c | 22 ----------------------
> > >  7 files changed, 6 insertions(+), 143 deletions(-)
> > >  delete mode 100644 arch/mips/lib/ashldi3.c
> > >  delete mode 100644 arch/mips/lib/ashrdi3.c
> > >  delete mode 100644 arch/mips/lib/cmpdi2.c
> > >  delete mode 100644 arch/mips/lib/lshrdi3.c
> > >  delete mode 100644 arch/mips/lib/ucmpdi2.c
> > >=20
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 350a990fc719..9cd49ee848c6 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -73,6 +73,11 @@ config MIPS
> > >  	select RTC_LIB if !MACH_LOONGSON64
> > >  	select SYSCTL_EXCEPTION_TRACE
> > >  	select VIRT_TO_BUS
> > > +	select GENERIC_ASHLDI3
> > > +	select GENERIC_ASHRDI3
> > > +	select GENERIC_LSHRDI3
> > > +	select GENERIC_CMPDI2
> > > +	select GENERIC_UCMPDI2
> >=20
> > Please preserve alphabetical order
>=20
> Ok, I'll fix order in v2 patch.
>=20
> > > --- a/arch/mips/lib/ucmpdi2.c
> > > +++ /dev/null
> > > @@ -1,22 +0,0 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > -#include <linux/export.h>
> > > -
> > > -#include "libgcc.h"
> > > -
> > > -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long=
 b)
> >=20
> > The version of __ucmpdi2 in /lib/ is not marked notrace. We have seen
> > issues before with compiler intrinsics not being marked notrace - see
> > aedcfbe06558 ("MIPS: lib: Mark intrinsics notrace")
> >=20
> > Please ensure that the /lib/ version is equivalent before switching to
> > that version.
>=20
> Good shot! I have missed this 'notrace'.
>=20
> lib/ucmpdi2.c differ from other GCC library routines files from lib
> related to my patch (ashldi3.c, ashrdi3.c, cmpdi2.c, lshrdi3.c):
> only lib/ucmpdi2.c has no 'notrace' flag. In other details the files
> look equivalent. The files arch/mips/lib/libgcc.h and include/linux/libgc=
c.h
> have no fundamental differences.
>=20
> to Palmer:
> Can we add notrace to lib/ucmpdi2.c?

FWIW, with both matt's comments addressed:
Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> It looks like that nobody (even RISC-V code)
> uses GENERIC_CMPDI2 and GENERIC_UCMPDI2. Why?
> Do you use them in your local branches?
>=20
> --=20
> Best regards,
> =C2=A0 Antony Pavlov
>=20

--FMJTF8LVhUQkvsEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlphA3MACgkQbAtpk944
dnpMrBAAiEjWKmQtyKQcgFLZmCeARd8M4ObVE0Lfw2FfhcYoGg4m9BWIx1kuW06J
WfwQgYnpDohKfNwjywG+lDKXlv8le1WiPpBc/T6kZaA8W1QT08dL7CGIjJCoA8tk
YTI2sb3uC7EI+v6qwXUhSkFm+WLIjrhYtwFveMuGnPrTKOWW6ZPnQgldpeGdYGAp
nVOR9fEerslyYMx6S9dlwNGHmLAxIptqMRQc2MU20qZnu4PqcNAenfj0CkYnn2pB
sAiAglVTKtrGgLE5Wldq4VmDU4M/f5wPgvA3+agrSTgPMacWwfjfw2rNts0WNsp9
vxp5XJLoGV51XDUdAZq6TL+wPF2FCXWH4T2B3yzzTRs+po2l5TlbqNWhY8+FSYun
T59O7dWSwjKcuMxcjj4tAaJlVOXH5TsJ+X7IFEt/HWu4V1tcbOX5sbsHrO2yp6du
TWNaYW3X+0yd1BaYe1Uu13phDAFXfr0ibIkf96NzsAB/0EpcARmn+cCzcGmv//dO
NotF+URwySXq0buZWf4cntPZ7j1Vrmem2Z9h9Envv2ViaihRO5h0Ym10qsCJCnQ0
RLCm/mHREGKTTdB7fQpqfmPI7gDYQfALzwWGYUgYfFCza029v7C4Jyhls2OYUbQJ
YLX8h2Mazld0ScbsHu4t2DpzEDk/MKSLBLzL+plJwDQ2390kz5M=
=8Dsf
-----END PGP SIGNATURE-----

--FMJTF8LVhUQkvsEb--
