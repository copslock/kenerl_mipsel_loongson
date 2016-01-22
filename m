Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 14:54:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8955 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014857AbcAVNyLfgqo5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 14:54:11 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1D93F41F8DEE;
        Fri, 22 Jan 2016 13:54:06 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 22 Jan 2016 13:54:06 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 22 Jan 2016 13:54:06 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id E2D958FD5AAD4;
        Fri, 22 Jan 2016 13:54:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 22 Jan 2016 13:54:05 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 Jan
 2016 13:54:05 +0000
Date:   Fri, 22 Jan 2016 13:54:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
Message-ID: <20160122135405.GA13515@jhogan-linux.le.imgtec.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
 <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
 <56A22936.8050601@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <56A22936.8050601@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51306
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

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Fri, Jan 22, 2016 at 08:05:58AM -0500, Joshua Kinard wrote:
> On 01/22/2016 07:19, James Hogan wrote:
> > On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
> >> Hi James,
> [snip]
> >=20
> > Thanks Manuel.
> >=20
> > FWIW, attached is the test program I mentioned, which hits the first
> > part of this patch (flush_cache_range) via mprotect(2) and checks if
> > icache seems to have been flushed (tested on mips64r6, but should be
> > portable).
>=20
> Here's the output on my Octane, R14000 CPU (mips4):
>=20
> # ./mprotect
> Initial mprotect SUCCESS
> Looped { mprotect RW, modify, mprotect RX, test } SUCCESS
>=20
> This is without your patch applied.  That look good?

Yep, that looks good.

> I'm assuming this CPU is too old to be affected.  I can test with your
> patch after the blizzard is over later this weekend.

Unless you set MIPS_CACHE_IC_F_DC for your core (only ALCHEMY does,
until patch 2 adds I6400 to the list), then cpu_has_ic_fills_f_dc =3D=3D 0
and everything should already work, as evidenced by the successful
result.

Thanks
James

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWojR9AAoJEGwLaZPeOHZ6AYcQAJqcI4DjvylDtwICsOK4UakD
703ud0gWjIA6B3FjdtODJOcH0j5r4a5JcK2NlfHC8gN193/ju2Jr46P2p2x9MNMx
bkI2IAUMT6BG4LfeYLh9f4FGNfC7ryWNtbnaNOZgtGfMFSAIVFbwZjKgwFeCFj8C
7iGLl/mYXryfoWLiZorB4Ig7ZLoKhe1XgMsjRNIV7HpTM5VCFTBplhOVysQ3/DZB
XpdorbxSOMe+RgAW9JXR4yokSmlvxAoYv/VPGO4MxPonO6hiNRAEVzl9KR1MK9xY
bXSsVJ+tOAAe5vs5A9svg3TWc50ndJR0mTFi/Sb4t55W4Q411kSLZvGIzNWYFEs1
QVDRNGCgJt+mZoyQyD6VRMmTZ4KKmO9fHh1sCT2IeQ9beOmYUboGlJIPaGnqXsXU
oY5dezBABJGU3Pk55MvRJySJCg/ZVFcdAUC9uAF8QrCT+bp9rtKViVRpfwaGez3N
VKUZB7VoTqQkuRhJuEqn5x6chsQTd5TiCJb6e7UZKhd0ww/HrT+ESW+ibrarap8z
+l+nL/57fh/aGY6EoM5MkvFyaJjWlolJ2hbKmTPF+bSZ+qXdloJgxuVeMUTHGYq8
RHr8E5tPM7PWUgl0xOyYYlBUwO+G9L80sAXNrx1a/vrRT1mcNoxiO2kqH+mnPMhm
/86Q0rVcaH6qEO7/SZ3B
=XuV0
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
