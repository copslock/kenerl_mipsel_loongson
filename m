Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 13:42:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60824 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012003AbbFBLmvN0gn4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 13:42:51 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C20BE41F8D69;
        Tue,  2 Jun 2015 12:42:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 02 Jun 2015 12:42:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 02 Jun 2015 12:42:41 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D9D5D6AF6BEB6;
        Tue,  2 Jun 2015 12:42:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 2 Jun 2015 12:42:41 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 2 Jun
 2015 12:42:41 +0100
Message-ID: <556D96B0.3050409@imgtec.com>
Date:   Tue, 2 Jun 2015 12:42:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Subject: Re: [PATCH 3/3] MIPS: bugfix - replace smp_mb with release barrier
 function in unlocks
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000952.6668.82483.stgit@ubuntu-yegoshin>
In-Reply-To: <20150602000952.6668.82483.stgit@ubuntu-yegoshin>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="BUOk0tpjh3b3SKxRuMKslWrcXeCrNGoBj"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47787
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

--BUOk0tpjh3b3SKxRuMKslWrcXeCrNGoBj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/15 01:09, Leonid Yegoshin wrote:
> Repleace smp_mb() in arch_write_unlock() and __clear_bit_unlock() to

Replace.

> smp_mb__before_llsc() call which does "release" barrier functionality.
>=20
> It seems like it was missed in commit f252ffd50c97dae87b45f1dbad24f7135=
8ccfbd6
> during introduction of "acquire" and "release" semantics.
>=20
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/include/asm/bitops.h   |    2 +-
>  arch/mips/include/asm/spinlock.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bit=
ops.h
> index 0cf29bd5dc5c..ce9666cf1499 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -469,7 +469,7 @@ static inline int test_and_change_bit(unsigned long=
 nr,
>   */
>  static inline void __clear_bit_unlock(unsigned long nr, volatile unsig=
ned long *addr)
>  {
> -	smp_mb();
> +	smp_mb__before_llsc();
>  	__clear_bit(nr, addr);
>  }
> =20
> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/s=
pinlock.h
> index 1fca2e0793dc..7c7f3b2bd3de 100644
> --- a/arch/mips/include/asm/spinlock.h
> +++ b/arch/mips/include/asm/spinlock.h
> @@ -317,7 +317,7 @@ static inline void arch_write_lock(arch_rwlock_t *r=
w)
> =20
>  static inline void arch_write_unlock(arch_rwlock_t *rw)
>  {
> -	smp_mb();
> +	smp_mb__before_llsc();

arch_write_unlock appears to just use sw, not sc, and __clear_bit
appears to be implemented in plain C, so is smp_mb__before_llsc() really
appropriate? Would smp_release() be more accurate/correct in both cases?

Cheers
James

> =20
>  	__asm__ __volatile__(
>  	"				# arch_write_unlock	\n"
>=20
>=20


--BUOk0tpjh3b3SKxRuMKslWrcXeCrNGoBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVbZawAAoJEGwLaZPeOHZ69DUP/1vPsYAvYTqrU+eyuE9/6vaL
o5kqgWNGsdVKgfHaV9jRNU4n/FAWgapLBs+Xod7YgrKxhPFBepTtWTJxXvG7H7NT
xsf0xqew71nTczPBln6kA4CppUi4ia88BvHfiXFEtfu2s3Fc5FCnaEO7RQznoqVn
i3XtwYxYeS8JVhT7vqMMJJijlNUa0Hy0clpA/TM3UB9kWuN71SebuUeE1ZOWRha4
i1lp4HE8MWbUj3pkWrxdx/HUHrUWKgwDPH97JTjtXsq+lT6FLYMAZ0iZvWn74jPy
7fwrs5mY0yYcsjnGFaRG1yK8gGvzC3yZG7AKPj7Nx2Nlr84QYg/XpDbgc4gxdN+8
kYYtXQcLgnA6zX/lAJeuTcuymgUUNRl4DRJDiRvFU0W5ufp9MyUjHiIPyiO1R+QN
3T0uOj4KSGKkINIEp5hXI/qGrM+uHYE9FyP8qvRuNCi/I+C0kV5MkvVDBOyU43Mh
XKKmLIK2uK/k21LEXcUMJPiGiY7/Zd8WQguujNZo9YiD0K+NGMMzxYuZpZPmx6FK
kW38MmV9FgVg44yXQKqW+0z+JrgFNFy1BN/P3Kq2x5x7IH3eIxBNwOgBidMm8wDb
psK34fYmvqU5cnVZRgxdwdFn/ZEc76feuHp747qPCH/+/GC6W6qVWAMlH//HWtfG
fWhMUCEOsvb0SWBCi7pO
=Crqs
-----END PGP SIGNATURE-----

--BUOk0tpjh3b3SKxRuMKslWrcXeCrNGoBj--
