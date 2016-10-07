Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 10:39:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1658 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990521AbcJGIjFT5bvK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 10:39:05 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E216641F8DF1;
        Fri,  7 Oct 2016 09:38:54 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 07 Oct 2016 09:38:54 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 07 Oct 2016 09:38:54 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 7FBE89000877F;
        Fri,  7 Oct 2016 09:38:56 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct 2016
 09:38:58 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct
 2016 09:38:58 +0100
Date:   Fri, 7 Oct 2016 09:38:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix -mabi=64 build of vdso.lds
Message-ID: <20161007083858.GK19354@jhogan-linux.le.imgtec.org>
References: <a226de28606d340f3e4cf0d6f6f4b4d12e766a69.1475791723.git-series.james.hogan@imgtec.com>
 <alpine.DEB.2.00.1610062349100.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1610062349100.31859@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55365
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

--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 12:52:32AM +0100, Maciej W. Rozycki wrote:
> On Thu, 6 Oct 2016, James Hogan wrote:
>=20
> > The native ABI vDSO linker script vdso.lds is built by preprocessing
> > vdso.lds.S, with the native -mabi flag passed in to get the correct ABI
> > definitions. Unfortunately however certain toolchains choke on -mabi=3D=
64
> > without a corresponding compatible -march flag, for example:
> >=20
> > cc1: error: =E2=80=98-march=3Dmips32r2=E2=80=99 is not compatible with =
the selected ABI
> > scripts/Makefile.build:338: recipe for target 'arch/mips/vdso/vdso.lds'=
 failed
> >=20
> > Fix this by including ccflags-vdso in the KBUILD_CPPFLAGS for vdso.lds,
> > which includes the appropriate -march flag.
> >=20
> > Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: <stable@vger.kernel.org> # 4.4.x-
> > ---
>=20
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
>=20
>  NB by default GCC is configured for the default of `-march=3Dfrom-abi',=
=20
> which is why saying `-mabi=3D64' only often works as such GCC implicitly=
=20
> switches to a compatible `-march=3D' setting (i.e. `mips3' vs `mips1' for=
=20
> o32).  However when configured with `-march=3D' set to a particular ISA=
=20
> level, such as `mips32r2' quoted above you need to select a compatible IS=
A=20
> explicitly when switching to a 64-bit ABI (arguably you could configure=
=20
> with `-march=3Dmips64r2' instead as with a 32-bit ABI such a setting woul=
d=20
> limit the instruction set to the 32-bit subset automatically).

Thanks Maciej for the description. The toolchain in question was a
buildroot toolchain, which does I believe default to a particular
-march, so that makes a lot of sense.

>=20
>  Also I've noticed $(aflags-vdso) duplicate `-I' and `-E' options already=
=20
> included with $(ccflags-vdso); I wonder if the duplicates should simply b=
e=20
> removed or whether $(cflags-vdso) ought to filter from $(KBUILD_CFLAGS)=
=20
> and $(aflags-vdso) -- from $(KBUILD_AFLAGS) instead (or $(ccflags-vdso)=
=20
> should just take the options from $(KBUILD_CPPFLAGS)).  Also why `-E' is=
=20
> supposed to take an argument?  Can you please have a look at it?

I think -E is to catch -EL / -EB. Removing the duplication is easily
fixed (I'll post a patch soon). As for whether it should filter from the
other KBUILD_ flags, I'm inclined to avoid changing it unless we can be
sure it will be more robust as a result.

Cheers
James

--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX918iAAoJEGwLaZPeOHZ6GskQAKsi9otBCHNS690EIxzm5S76
cw/5DFsQ60r/CnHPjTl999TXun6vLqDA7Ze3vGRmoynXA8b/MvIQlg+WE/kyn1je
yuZnWBmBM6gUzXwdNUkexOG6N8WF9zF4sTGTRQGcBEsrYeSvG9942ntAmpeVlNG8
mQl5SPRrQiQlTGPyLg7uN0VT1dD3yQ6LnNGcY1tjNn/n2sUhZ9NZqDtUVFMeOwLk
DDJW9Oq9unRGuLhCzxOY5rLtWoa/xgwjZkbrEead/a9YH2D9StXzbejP670Md//O
UUy4+wlW6LaTTv9MRiqye1NetXmXjTDO5pxIgriW9aV38Gz6CJpeZ6qXqsqN7aBF
+e7hhUUUjgkLRaygJWSbyevcnRW60a7dA03G5TBW6q04dv+oscH+J4yz3y2Z2DIe
J5yJwO7T+W+wYF9phABRdVcckekDRRaTQYo+5GBNQ7e4cp1rRRRKUONf1xA91xmE
M43ZhRvWcy9sEkM1qT1iWeQcr88AHFuf1yRo8OXQd9vU6pxqI/cUT45tJr5aSYl/
0ZWG+sZaKKbtULdq0prxlTb85E3s7Fvso92hjFvVIPYAHAXyQLMW5qi1K5jPaO3r
GUMwmLAY/tziTQobI3hQbqr1Sgd2bYGMFRADNSHQTNEuxXYLL5slPZHkTDkMjDo5
SdpH/D5VC6v0cxUQjmxs
=dEP9
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
