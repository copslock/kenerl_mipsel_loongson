Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 10:51:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50416 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010875AbcBWJvOBjMVF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 10:51:14 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7F73641F8E4E;
        Tue, 23 Feb 2016 09:51:08 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 23 Feb 2016 09:51:08 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 23 Feb 2016 09:51:08 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A7BA6FE228C42;
        Tue, 23 Feb 2016 09:51:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 23 Feb 2016 09:51:07 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 23 Feb
 2016 09:51:07 +0000
Date:   Tue, 23 Feb 2016 09:51:07 +0000
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
Message-ID: <20160223095107.GC21143@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1667268.iM977TQnEK@wuerfel>
 <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
 <4206493.gjdgtfndZ8@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <4206493.gjdgtfndZ8@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52178
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

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, Jan 19, 2016 at 03:27:24PM +0100, Arnd Bergmann wrote:
> On Tuesday 19 January 2016 14:22:13 James Hogan wrote:
> > On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> > > On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > > > When a header file is removed from generic-y (often accompanied by =
the
> > > > addition of an arch specific header), the generated wrapper file wi=
ll
> > > > persist, and in some cases may still take precedence over the new a=
rch
> > > > header.
> > > >=20
> > > > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> > > > context") removed ucontext.h from generic-y in arch/mips/include/as=
m/,
> > > > and added an arch/mips/include/uapi/asm/ucontext.h. The continued u=
se of
> > > > the wrapper when reusing a dirty build tree resulted in build failu=
res
> > > > in arch/mips/kernel/signal.c:
> > > >=20
> > > > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=
=80=99:
> > > > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=
=E2=80=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> > > >   return &uc->uc_extcontext;
> > > >             ^
> > > >=20
> > > > Fix by detecting and removing wrapper headers in generated header
> > > > directories that do not correspond to a filename in generic-y, genh=
dr-y,
> > > > or the newly introduced generated-y.
> > >=20
> > > Good idea.
> > >=20
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> > Thanks Arnd
> >=20
> > > Can you merge this through the mips tree, or do you need me to pick it
> > > up through asm-generic?
> >=20
> > I was envisaging the kbuild tree tbh, but I don't really mind how it
> > gets merged. This patch depends on patch 1, which adds generated-y to
> > x86 so we don't delete their other generated headers, but other than
> > that it doesn't really have any dependencies.
>=20
> Ok, the kbuild tree works fine too, and I guess the x86 tree would
> also be fine if that helps avoid the dependency.

Were you okay to take these patches, or would you prefer they go via the
MIPS tree?

Thanks
James

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzCuLAAoJEGwLaZPeOHZ6y0QQAJL67+KgctHHDL1wPNksjxaR
fvBuO401HDcxEG3gSlbFHYseQoUoamOO/VnMOJuExDdI7Ni4smf3RLZSNCtq4Z3a
KmGIQKwUfqfZqaQUCqwSUM84wd5ZravahegTLiIO1eQD+KZAIJ1GJACm0i+PCf3R
FlhvoFaszx1wbPB9IquNJ56EEq+KW0UrmLdRBaJ8l1h1BKU5yKRNHWToQ8Y5c9wn
zrW59Rdo6ApU38KKjueycEw/vV4PUl0V3sd+TUhaFTNfnHvqyrEoq3UWPxYD/NFI
6xlkuwj5zw9pDRhSDQ/garAUBXxnzlSCs3ckp6Qn3zqXFbQfVVRYuifUVe6+2Ghw
Lo23XwXO1785ctY6Ucqbn+ayn+fJrp1HMDPSSh48njX/2pZzqRG6bCf2V7Y9nqmR
xelqodsIgBQLwaLhc2GHWCsomYC2nmyuWYc+62ejKWaJlZPzWcyPORqs6fbXrUKl
8wU1i9DcbyyPae2yMXb5U55vtLpk6s0ZJgA5eXnGGeWj6a6dm+9gXHvo+hEriWNG
ZhrDni2JPVDm5NzlpModcNEmeeRFSgJpe/+UVhP9krpQ8ehKxJybYToAQbUEug/i
Onzk6FlkFiLiOmJPUBsoDC0hWD0mAZ9cPEvPwxTPEeqq6bMi+MO7SCiTkTvB9P9u
q6ObpxlafO+ioYNFdHa8
=zDnk
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
