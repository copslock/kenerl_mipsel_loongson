Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 21:26:05 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54006 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARUZ6IwwHN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 21:25:58 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 18 Jan 2018 20:25:31 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 18 Jan
 2018 12:24:19 -0800
Date:   Thu, 18 Jan 2018 20:24:17 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH] MIPS: use generic GCC library routines from lib/
Message-ID: <20180118202416.GD27409@jhogan-linux.mipstec.com>
References: <20180117065121.30437-1-antonynpavlov@gmail.com>
 <mhng-796aa108-a59e-433a-a037-925fbfaf905e@palmer-si-x1c4>
 <20180118230505.31af9784f543a2e067af5a39@gmail.com>
 <57124790-F7C9-4180-AE89-A7FAA3DBDC9A@albanarts.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2bJ57vwr75KGnr5s"
Content-Disposition: inline
In-Reply-To: <57124790-F7C9-4180-AE89-A7FAA3DBDC9A@albanarts.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516307130-637137-18861-69447-3
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
X-archive-position: 62242
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

--2bJ57vwr75KGnr5s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:54:49PM +0000, James Hogan wrote:
> On 18 January 2018 20:05:05 GMT+00:00, Antony Pavlov <antonynpavlov@gmail=
=2Ecom> wrote:
> >On Wed, 17 Jan 2018 17:34:59 -0800 (PST)
> >Palmer Dabbelt <palmer@sifive.com> wrote:
> >> Given that, I think you can also drop arch/mips/lib/libgcc.h -- if
> >it's used=20
> >> from anywhere else, it should be possible to use
> >include/linux/libgcc.h=20
> >> instead.
> >
> >I agree with you.
>=20
> actually theres a patch in mips-next which implements __multi3 for mips64=
r6, which uses that file, and in fact extends it for 128bit types.

More specifically, commit ebabcf17bcd7 ("MIPS: Implement __multi3 for
GCC7 MIPS64r6 builds"), which will find its way into v4.15. See also
https://patchwork.linux-mips.org/patch/17890/

Cheers
James

--2bJ57vwr75KGnr5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlphAkUACgkQbAtpk944
dnoEeA/5Abgw8aSGX+oNvikiL+21wIjgMGSY81y16r2qVRPCobGKkHL/avWWBddM
M33DygdSI67wZgcG7qq/SYASWrzuRd/co+AqhrCEvGXw40GO5RTmOaoIvBIbp72m
k7khiuS4Xy8iR8RpGR1P1QUx3PPlAUYY93GKU2TVHYLZdyXW4+z2/A6wpMc9TBPy
S6tpky+13v1uEvSqo2d9GkUJpUg6VqveA66HKpWphKLIQ7Ab1Dyy6YeyRIDs3aZi
AdYNqFJ1GUaUUFdDsuY1F6bvXCRxsALYI5TF8aLp4H+UlbNF9LrRNp9GDtLQnCfa
PS6UEKE9R3NUoZGXnvPwRmhgNAqIW0MoPfJS08LXAnu8j04Jgs1P+gJ3nPsZ/wGG
LMBvDuBzHXQ+UyzB2NSmWle17m05sKpYYJ3lXDE9gw03nBZXzGB55+tWpdCdJdzi
hYctMFuj0GvRbgF/erj4SHcPmC1pSTajzsB1fu4nIWwCxZT3sNtJ8WQM8uCMBZIe
eiKDc0CNud30AaAWprXHDYq2ByBxY1utktvU7/z54isg1UbI06aDRs+wyGvVixcP
PTgESnCmcK/MVG4wQpAm9+G/CpEUI9RQLF8czVZ2gwVLGFExxEGn5gkOrY2uKjP4
j0m0g1tcrFsMuaxTJYys/uqolZ9PVVTZfhegx11g/lNzxIR2Yc0=
=7k/N
-----END PGP SIGNATURE-----

--2bJ57vwr75KGnr5s--
