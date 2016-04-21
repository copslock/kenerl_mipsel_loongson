Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 20:44:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31329 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026707AbcDUSoPBZM8e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 20:44:15 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DFD8941F8EBD;
        Thu, 21 Apr 2016 19:44:07 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 21 Apr 2016 19:44:07 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 21 Apr 2016 19:44:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id B37411B8AE6E;
        Thu, 21 Apr 2016 19:44:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 19:44:07 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 19:44:06 +0100
Date:   Thu, 21 Apr 2016 19:44:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Michal Marek <mmarek@suse.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kbuild@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Message-ID: <20160421184406.GG7859@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1667268.iM977TQnEK@wuerfel>
 <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
 <4206493.gjdgtfndZ8@wuerfel>
 <20160223095107.GC21143@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IRIOLc8eTv1AOxGv"
Content-Disposition: inline
In-Reply-To: <20160223095107.GC21143@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53187
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

--IRIOLc8eTv1AOxGv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 09:51:07AM +0000, James Hogan wrote:
> Hi Michal,
>=20
> On Tue, Jan 19, 2016 at 03:27:24PM +0100, Arnd Bergmann wrote:
> > On Tuesday 19 January 2016 14:22:13 James Hogan wrote:
> > > On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> > > > On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > > > > When a header file is removed from generic-y (often accompanied b=
y the
> > > > > addition of an arch specific header), the generated wrapper file =
will
> > > > > persist, and in some cases may still take precedence over the new=
 arch
> > > > > header.
> > > > >=20
> > > > > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for exten=
ded
> > > > > context") removed ucontext.h from generic-y in arch/mips/include/=
asm/,
> > > > > and added an arch/mips/include/uapi/asm/ucontext.h. The continued=
 use of
> > > > > the wrapper when reusing a dirty build tree resulted in build fai=
lures
> > > > > in arch/mips/kernel/signal.c:
> > > > >=20
> > > > > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=
=E2=80=99:
> > > > > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=
=E2=80=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> > > > >   return &uc->uc_extcontext;
> > > > >             ^
> > > > >=20
> > > > > Fix by detecting and removing wrapper headers in generated header
> > > > > directories that do not correspond to a filename in generic-y, ge=
nhdr-y,
> > > > > or the newly introduced generated-y.
> > > >=20
> > > > Good idea.
> > > >=20
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > Thanks Arnd
> > >=20
> > > > Can you merge this through the mips tree, or do you need me to pick=
 it
> > > > up through asm-generic?
> > >=20
> > > I was envisaging the kbuild tree tbh, but I don't really mind how it
> > > gets merged. This patch depends on patch 1, which adds generated-y to
> > > x86 so we don't delete their other generated headers, but other than
> > > that it doesn't really have any dependencies.
> >=20
> > Ok, the kbuild tree works fine too, and I guess the x86 tree would
> > also be fine if that helps avoid the dependency.
>=20
> Were you okay to take these patches, or would you prefer they go via the
> MIPS tree?

I'm keen for these two patches to make their way upstream one way or
another.

Ralf: Since it affects MIPS, would you be able to take them?

Cheers
James

--IRIOLc8eTv1AOxGv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGR92AAoJEGwLaZPeOHZ6I3AP/3QBag29Wj1XCKtCidDeCXl1
XYSd2inkBsRh0HVyjBsNtyBJdxJWHYrAHAtqceSkvL9IcZKwuObQ3zGdOjFgA64B
0X5KL+joj7fJL9v9coBMNSeWuIPkI4r4vFL6MQsPgJz+ZxHWDArNHQ8LF0ZEo4RR
Hfcu2tY9opIOkpZg4hrdGfiej3DBS+QR050SkpswNTySpwJPPuPjTl+uzWz6C+2m
HdLCpRKhR77O7ZL2XCbwyx41XfegoQjTwgWwbMlSXjKHuet//QLKs5QkQRvGIM1T
SWkAKVl7RlXLqcKtszVt+IScbABM/gFB7rgjBda4I3ewxCTHWiEzxvbTRVLeOluG
Nsicn1cs+D+CdhEQMiVIxKablmuRAg1i1fLPcQ0E5ZAjFbPWyUDtH9nQWOphU9Cd
N5V49kg8lkR1ygQx56cOqw1OdGdh8RaSk5d78aM7BDKbqh6SXvJ10e1t7eXeabux
WL/LAa+FT4c3oefHghWqJjI0+XMjJ2+A2MEM7xDXqMpebG9sraGv90X7ARF3d/Nf
9pyYMkhU/Mx0A7Jo3LHZ/XwRZQo9WU4Cwz7Se8zPTxB13kmG67WXQWCwOkzbe1fm
z0hGrDxargrmWyX9WTSHve2LNtwjRwttZng1eZJ/l436YEyLDcQRSia2mY4QG8y8
j9TK/jNJOu3Mprt63W2I
=fQxU
-----END PGP SIGNATURE-----

--IRIOLc8eTv1AOxGv--
