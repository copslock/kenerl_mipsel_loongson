Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 00:24:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64849 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007923AbcADXYLXi6My (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 00:24:11 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F221641F8E88;
        Mon,  4 Jan 2016 23:24:05 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 04 Jan 2016 23:24:05 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 04 Jan 2016 23:24:05 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id F3853834E95CD;
        Mon,  4 Jan 2016 23:24:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 23:24:05 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 4 Jan
 2016 23:24:04 +0000
Date:   Mon, 4 Jan 2016 23:24:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>, "Ingo Molnar" <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Andrey Konovalov" <andreyknvl@google.com>
Subject: Re: [PATCH v2 10/32] metag: reuse asm-generic/barrier.h
Message-ID: <20160104232404.GL17861@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-11-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <1451572003-2440-11-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50892
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

--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 31, 2015 at 09:07:02PM +0200, Michael S. Tsirkin wrote:
> On metag dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> the asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
>=20
> This is in preparation to refactoring this code area.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks good, and confirmed no text change (once patch 1 is applied that
is).

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/metag/include/asm/barrier.h | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/ba=
rrier.h
> index 172b7e5..b5b778b 100644
> --- a/arch/metag/include/asm/barrier.h
> +++ b/arch/metag/include/asm/barrier.h
> @@ -44,9 +44,6 @@ static inline void wr_fence(void)
>  #define rmb()		barrier()
>  #define wmb()		mb()
> =20
> -#define dma_rmb()	rmb()
> -#define dma_wmb()	wmb()
> -
>  #ifndef CONFIG_SMP
>  #define fence()		do { } while (0)
>  #define smp_mb()        barrier()
> @@ -81,27 +78,9 @@ static inline void fence(void)
>  #endif
>  #endif
> =20
> -#define read_barrier_depends()		do { } while (0)
> -#define smp_read_barrier_depends()	do { } while (0)
> -
> -#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); =
} while (0)
> -
> -#define smp_store_release(p, v)						\
> -do {									\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	WRITE_ONCE(*p, v);						\
> -} while (0)
> -
> -#define smp_load_acquire(p)						\
> -({									\
> -	typeof(*p) ___p1 =3D READ_ONCE(*p);				\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	___p1;								\
> -})
> -
>  #define smp_mb__before_atomic()	barrier()
>  #define smp_mb__after_atomic()	barrier()
> =20
> +#include <asm-generic/barrier.h>
> +
>  #endif /* _ASM_METAG_BARRIER_H */
> --=20
> MST
>=20

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWiv8UAAoJEGwLaZPeOHZ6hSwQAJCVQc5QdNomZOnrxJp5uv9r
iT+zYpXRNC4k29ENp5iDq29d07OM1zooI0szDvvKi351dsFwfOXrEBIcoKJjLRcm
VGVtFCCI0IffzBGaMa2u16xywqgCogk+uMnlOmyk2cSM6lx0BdWIb6sL4fzkocfT
a1sTWJnh45/sQG+VQQUUFokjUM0UFCXOV+77I556Khe9tS5qgZnObEsAIk+lrY/3
lRo2nd2wbZsybzqlQVKp3nKYbFNUpoCGT/myPpj8A3NQ/FBUOs6LtpZvD0i06CJh
E01ASo6Cr5SvTyOAYsty+zcZvFGZPB+2i9jyv/7vGDBgdiCwLEX25gXxz9aS8GB6
2Oa2E/5z/uCltUZyM3y3Yz/K8XwnhORh3PMpZR/b2Ze5MnguCLy2zWrcKWdZhCJ+
UkNkLe3rcbdLSfCcK6kCSAwHoqj78IeHmBG+96vEwePwsQh7YkAKIoKSMxbx88BU
gD/yn8y+dc7wSJGYgHM4eBw35H3o7HTB6bPRZsw8/ak1nG8ClOMtWkoLB7a+9wOA
J5tM/aHE0ixB02QphdN8lkvqMA+U9EKmq6hBHZeiyIxNx/mCAm+6dcGv484Hh2UF
tvsj4erVkGZa9EJ3KL49xvAJx23RTZcR+a2djcLUlzeLr32UDWh3zuVzSoNc+ZKD
Cnc7cQMIdlTlucxbu/OU
=IkXd
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
