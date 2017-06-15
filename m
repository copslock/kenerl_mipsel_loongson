Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 18:38:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60976 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994786AbdFOQh4F2thI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 18:37:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0542F41F8DF9;
        Thu, 15 Jun 2017 18:47:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Jun 2017 18:47:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Jun 2017 18:47:18 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BDFFAFD519A3D;
        Thu, 15 Jun 2017 17:37:46 +0100 (IST)
Received: from [10.150.130.85] (10.150.130.85) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 15 Jun
 2017 17:37:50 +0100
Subject: Re: [PATCH v2 4/5] MIPS: Add support for eBPF JIT.
To:     <ralf@linux-mips.org>
References: <20170613222847.7122-1-david.daney@cavium.com>
 <20170613222847.7122-5-david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>
From:   James Cowgill <James.Cowgill@imgtec.com>
Message-ID: <1d9025c9-7e4a-551e-9937-a2439e11a852@imgtec.com>
Date:   Thu, 15 Jun 2017 17:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170613222847.7122-5-david.daney@cavium.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature";
        boundary="UQmGoB0P2dsTTWeItqoSdcNN5kTEH031O"
X-Originating-IP: [10.150.130.85]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

--UQmGoB0P2dsTTWeItqoSdcNN5kTEH031O
Content-Type: multipart/mixed; boundary="R5MJXauersSJCxMISOHLObXXcbs5gmemn";
 protected-headers="v1"
From: James Cowgill <James.Cowgill@imgtec.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Message-ID: <1d9025c9-7e4a-551e-9937-a2439e11a852@imgtec.com>
Subject: Re: [PATCH v2 4/5] MIPS: Add support for eBPF JIT.
References: <20170613222847.7122-1-david.daney@cavium.com>
 <20170613222847.7122-5-david.daney@cavium.com>
In-Reply-To: <20170613222847.7122-5-david.daney@cavium.com>

--R5MJXauersSJCxMISOHLObXXcbs5gmemn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On 13/06/17 23:28, David Daney wrote:
> Since the eBPF machine has 64-bit registers, we only support this in
> 64-bit kernels.  As of the writing of this commit log test-bpf is showi=
ng:
>=20
>   test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>=20
> All current test cases are successfully compiled.
>=20
> Many examples in samples/bpf are usable, specifically tracex5 which
> uses tail calls works.
>=20
> Signed-off-by: David Daney <david.daney@cavium.com>

I think you've misapplied this patch to upstream-sfr. I see the
following commit, but it's missing the ebpf_jit.c file.

commit bb45edc82b3c1608026b5a7aeb0876ec31735359
Author: David Daney <david.daney@cavium.com>
Date:   Tue Jun 13 15:28:46 2017 -0700

    MIPS: Add support for eBPF JIT.
   =20
    Since the eBPF machine has 64-bit registers, we only support this in
    64-bit kernels.  As of the writing of this commit log test-bpf is sho=
wing:
   =20
      test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
   =20
    All current test cases are successfully compiled.
   =20
    Many examples in samples/bpf are usable, specifically tracex5 which
    uses tail calls works.
   =20
    Signed-off-by: David Daney <david.daney@cavium.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Markos Chandras <markos.chandras@imgtec.com>
    Cc: Matt Redfearn <matt.redfearn@imgtec.com>
    Cc: netdev@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Cc: linux-mips@linux-mips.org
    Patchwork: https://patchwork.linux-mips.org/patch/16369/
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig      | 12 +++++++++++-
 arch/mips/net/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

This is causing my builds to fail with:
make[4]: *** No rule to make target 'arch/mips/net/ebpf_jit.o', needed by=
 'arch/mips/net/built-in.o'.  Stop.

James


--R5MJXauersSJCxMISOHLObXXcbs5gmemn--

--UQmGoB0P2dsTTWeItqoSdcNN5kTEH031O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+Ixt5DaZ6POztUwQx/FnbeotAe8FAllCt9kACgkQx/Fnbeot
Ae/C3xAAo6I7z9xUYiq1c6fKMXuEECSyiU2lqFOm9dwOssNwO43zd+NKZ1CJWENn
LeDLSsrLj43XYFoKoB7wCk6KnDccNELStOa1TRYVTHMwjw8ngCMxO5m8eO277WZY
/2LhNHKd1YtEwPES4DzjGotvYNfKw67ZbEUP5uuoTDm/Acrxq9rQhEplKmtTiDOr
nxUiOR9BUVgU6rVwDSIZIq1UHqkKUPrrq5DHuE5Ng0Zk6Ha+xcNy841cnkUubXsu
Fe4nEBNbQ1rTF3/5Ucet3C+SNGy6dHtIiPCGeP2Cjc2ozIMolopDuK3ftAyJjrLz
tBKTxlJ4M+rQCkQlcRwUibIdxJYYqD3/+P4aX/91pe5tjr7nZz10K5uW8SWSAENP
WMIZxEySCEA2EFn2fuBF+DuBFZ9ryUCqPPUtVXY0I6QUFNG10Go7HqvTDcP434f8
ktr/9Q2Sh5SQDVAMwKw2bMn0n+CaynOlZzdl4bNbNzGnyR4YmkTm773B4fYBe8sP
btvxL9EDRFa7vyYZxxnjlI89KzBbaxTPwEkdjd15Xpp/LYCOE2OiqGHJQn6MG1/4
2UTdqtE3fv4nMgatGrlSu8JI4n5+Sd0x3bQcXch8nMhWipC8bybnZGoBanc77Q2O
cjbyAd7eLXrv/lrHiKFuZpUoPN+ilCf5OqpB3MEu8N2ISAqWbco=
=4jcg
-----END PGP SIGNATURE-----

--UQmGoB0P2dsTTWeItqoSdcNN5kTEH031O--
