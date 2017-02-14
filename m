Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 11:12:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57320 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993543AbdBNKM25jpvh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 11:12:28 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 814FC41F8EB7;
        Tue, 14 Feb 2017 11:16:20 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 11:16:20 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 11:16:20 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E4A2517076F39;
        Tue, 14 Feb 2017 10:12:20 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 10:12:23 +0000
Date:   Tue, 14 Feb 2017 10:12:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Wei Yongjun <weiyj.lk@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] MIPS: sysmips: Remove duplicated include from
 syscall.c
Message-ID: <20170214101222.GT24226@jhogan-linux.le.imgtec.org>
References: <20170206162650.16320-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tbn31orTZdSAVHoc"
Content-Disposition: inline
In-Reply-To: <20170206162650.16320-1-weiyj.lk@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56805
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

--tbn31orTZdSAVHoc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 04:26:50PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Remove duplicated include.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied

Thanks
James

> ---
>  arch/mips/kernel/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 735733f..c86ddba 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -36,7 +36,6 @@
>  #include <asm/sim.h>
>  #include <asm/shmparam.h>
>  #include <asm/sysmips.h>
> -#include <linux/uaccess.h>
>  #include <asm/switch_to.h>
> =20
>  /*
>=20
>=20
>=20
>=20

--tbn31orTZdSAVHoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYotgGAAoJEGwLaZPeOHZ6TNMQAKklNJfnwRcKnE/bRx8ULae7
tOokhu/RDuA7fnpYRX06fkY/37veolN8OiAvGNSt7ZagyRwmLonc9GfxHDne/jHR
vMb0gL9TytXVQPVS7+HwD+xlWeHsId+4DrmTeARhmpDd9NABAxNxhcJ780BqE7L2
jwPtYPV0NhmAA7/RD28w3t442vjfLssSava/9XM3kWzkokQpHzj57lTemFLvSFCD
MP6hhKR3+BU5RWE9ri4UzEEm1UmQnQAybSSmOLWfvXy2tyi5tTkvDi2LDPB3VtPl
pMjHgFS+C395Ptgw0xj6bVBfYmILtH4+gSmbZXjB5f/7ahhLjwqDDdni3l/kYHJ2
fE/UhyjIrYMtq56kjzE/d9QLmAGN14P1ZDBeGGgXjIYRwVz8qcHQrbHRT0S9qT1B
lIkxJuZuOnSoTqHGAW/W51NhY5/V4nTTA3oY79xuVMJ7PFEfGtcoumxZtvdOM74L
ug8LXlYPfCi1LpcCgJuaYa+ngEHHEzba1CAYyHiRK2F/ztlBTUSV+hgPnijx5zOV
5AKwOyK8nr4t5XlmzuQZH7cPMQFRvum77iIsj873XbUnodxbWP+W/Dt1LGe96T4r
t47JhIEB4JwK2UQHW5SjzZ87vOz9zPgev6BHtOV6wpcWdjZYNBzF1yqRNHL6Hdgg
52/ERr+Jvi4G55/UVsqM
=tCy9
-----END PGP SIGNATURE-----

--tbn31orTZdSAVHoc--
