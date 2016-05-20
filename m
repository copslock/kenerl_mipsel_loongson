Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 01:18:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7983 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27032075AbcETXS2i3hLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 01:18:28 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1190F41F8D5E;
        Sat, 21 May 2016 00:18:23 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 21 May 2016 00:18:23 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 21 May 2016 00:18:23 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 8129CB067C1EE;
        Sat, 21 May 2016 00:18:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Sat, 21 May 2016 00:18:22 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Sat, 21 May
 2016 00:18:21 +0100
Date:   Sat, 21 May 2016 00:18:21 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Maciej W. Rozycki" <macro@imgtec.com>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
Message-ID: <20160520231821.GB1145@jhogan-linux.le.imgtec.org>
References: <573936E3.3050003@roeck-us.net>
 <alpine.DEB.2.00.1605161452100.6794@tp.orcam.me.uk>
 <20160520173139.GB12632@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20160520173139.GB12632@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53571
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

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Fri, May 20, 2016 at 10:31:39AM -0700, Guenter Roeck wrote:
> Builds with binutils 2.22 on recent kernels fail on and off (there was a =
failure
> in -next a few days ago which has since then be fixed). Overall using it =
as
> "default" builder is by now too fragile, which is why I dropped it as bas=
eline
> version. I now only build defconfig and allnoconfig with it as basic sani=
ty test.
>=20
> For qemu tests, I ended up using a combination of binutils 2.22, 2.24, an=
d 2.25
> depending on the kernel version. Previously I only used 2.22, but again t=
hat
> is by now too risky. I can not just use 2.25 since it isn't supported in =
older
> kernels (plus mips-gcc in Poky 2.0 seems to be buggy for mipsel64, or may=
be that
> compiler and qemu don't like each other), I can not just use 2.24 because=
 it
> isn't supported in 3.2 and 3.4, and I don't want to use 2.22 for recent k=
ernels
> since all tests may end up failing because some feature only available in=
 later
> versions of binutils was added to the kernel.=20

FWIW, we've already made some effort to make versions of binutils
lacking more recent features continue to work (with a very small
performance hit), so I do think there is still value in having at least
some build testing with these toolchain versions, e.g.:

- MSA (binutils < 2.25)
- XPA (binutils < 2.25, in fact we don't take advantage of binutils
  support at all right now)
- VZ (binutils < 2.24... sorry for breaking that btw!)

Certain configurations use more invasive features where no attempt is
made to support older toolcahin versions though, but these are normally
along the lines of needing a whole different/incompatible kernel, so
tends to be a very concious decision on the part of the user e.g.:

- EVA (binutils < 2.24, nothing technically preventing it though)
- microMIPS (binutils < 2.22, requires full toolcahin support)
- MIPS R6 (binutils < 2.25, requires full toolchain support)

Cheers
James

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXP5s9AAoJEGwLaZPeOHZ6G+AQAJGxTYQUrsr2VDMMtCOVafQ9
EaLpOrDlk4TAk0bHo5y1cS8WJQVsfuWwJg+3qD5zpaFyWk1uG1ZxTp0R/Yf5Awf5
szkF3XIHYlqYv9PbjEdmw46E6Y+cBycj5xUOXx8SJkcWysxXdKGrTPYA5ugj6sMO
sy9pQZqyceoETlfUukgbexvy9mbaWvaJBF7IJ3F91NFsigjPc2939BqaGzC0ThKJ
p7DJTRoR0vtKXO0iZ4iqKQzI49EukjWVIwwSYms9N6aSXQH9f+7ijlAwknOwkrZU
/itEEzkDqU6WxkUHcE7BcMcOZWE52v3I0T30JHMUq8hkntruyghaPz/VOt5lSJQT
hcz8VPh4t6xlSVwVjKcyKHyeYOLtG11nUKDa6Pc3uCpthqG1EsxvxlrG7D6Q3kyg
n+nK+cbwPz+HDrVUUE1bn9yLSEdGFYPovEufINVdjpzV+O1OduRBce/iUV0iHExE
fHyBH3ukWmnS2QhTcL7e8/EeQm+5ktUhUh7nk0gE0PJ0xShZCj866sTe1zrbxpkq
8pj/9xPTYUdnCnQYkgf3Xg5W8+3bEy1lx5hdrcMdOFf0+Lk7vjPHG8asHNKaq6QU
J4jcyxA/r1fO+VtKiHRpJkkuTVaEm1IyZz9HWsjpFf0hmzoyS7Exyux38bpAeCoM
0wgjO1mzYjzicO+2GWRM
=FnjV
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
