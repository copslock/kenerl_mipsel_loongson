Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 01:09:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57153 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009772AbcAEAJgfq3EV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 01:09:36 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F395F41F8D57;
        Tue,  5 Jan 2016 00:09:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 05 Jan 2016 00:09:31 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 05 Jan 2016 00:09:31 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D63E1431F91EA;
        Tue,  5 Jan 2016 00:09:26 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 5 Jan 2016 00:09:30 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 5 Jan
 2016 00:09:29 +0000
Date:   Tue, 5 Jan 2016 00:09:30 +0000
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
        Davidlohr Bueso <dbueso@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Message-ID: <20160105000929.GM17861@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <1451572003-2440-21-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50893
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

--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> This defines __smp_xxx barriers for metag,
> for use by virtualization.
>=20
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
>=20
> Note: as __smp_XX macros should not depend on CONFIG_SMP, they can not
> use the existing fence() macro since that is defined differently between
> SMP and !SMP.  For this reason, this patch introduces a wrapper
> metag_fence() that doesn't depend on CONFIG_SMP.
> fence() is then defined using that, depending on CONFIG_SMP.

I'm not a fan of the inconsistent commit message wrapping. I wrap to 72
columns (although I now notice SubmittingPatches says to use 75...).

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/metag/include/asm/barrier.h | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/ba=
rrier.h
> index b5b778b..84880c9 100644
> --- a/arch/metag/include/asm/barrier.h
> +++ b/arch/metag/include/asm/barrier.h
> @@ -44,13 +44,6 @@ static inline void wr_fence(void)
>  #define rmb()		barrier()
>  #define wmb()		mb()
> =20
> -#ifndef CONFIG_SMP
> -#define fence()		do { } while (0)
> -#define smp_mb()        barrier()
> -#define smp_rmb()       barrier()
> -#define smp_wmb()       barrier()
> -#else

!SMP kernel text differs, but only because of new presence of unused
metag_fence() inline function. If I #if 0 that out, then it matches, so
thats fine.

> -
>  #ifdef CONFIG_METAG_SMP_WRITE_REORDERING
>  /*
>   * Write to the atomic memory unlock system event register (command 0). =
This is
> @@ -60,26 +53,31 @@ static inline void wr_fence(void)
>   * incoherence). It is therefore ineffective if used after and on the sa=
me
>   * thread as a write.
>   */
> -static inline void fence(void)
> +static inline void metag_fence(void)
>  {
>  	volatile int *flushptr =3D (volatile int *) LINSYSEVENT_WR_ATOMIC_UNLOC=
K;
>  	barrier();
>  	*flushptr =3D 0;
>  	barrier();
>  }
> -#define smp_mb()        fence()
> -#define smp_rmb()       fence()
> -#define smp_wmb()       barrier()
> +#define __smp_mb()        metag_fence()
> +#define __smp_rmb()       metag_fence()
> +#define __smp_wmb()       barrier()
>  #else
> -#define fence()		do { } while (0)
> -#define smp_mb()        barrier()
> -#define smp_rmb()       barrier()
> -#define smp_wmb()       barrier()
> +#define metag_fence()		do { } while (0)
> +#define __smp_mb()        barrier()
> +#define __smp_rmb()       barrier()
> +#define __smp_wmb()       barrier()

Whitespace is now messed up. Admitedly its already inconsistent
tabs/spaces, but it'd be nice if the definitions at least still all
lined up. You're touching all the definitions which use spaces anyway,
so feel free to convert them to tabs while you're at it.

Other than those niggles, it looks sensible to me:
Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>  #endif
> +
> +#ifdef CONFIG_SMP
> +#define fence() metag_fence()
> +#else
> +#define fence()		do { } while (0)
>  #endif
> =20
> -#define smp_mb__before_atomic()	barrier()
> -#define smp_mb__after_atomic()	barrier()
> +#define __smp_mb__before_atomic()	barrier()
> +#define __smp_mb__after_atomic()	barrier()
> =20
>  #include <asm-generic/barrier.h>
> =20
> --=20
> MST
>=20

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWiwm5AAoJEGwLaZPeOHZ6mkAP/3YQI6/lhcfPobYD3pu4kEAQ
z0nCkToHmfvBNy9Co0YPt1414xnWLok0N7cgsAPlyXXVa7FT3hTKzTXjZkbftEZe
BpFH+bROYkPfL/XVd19qBgUKu6SBjxN2qWfvqH2vm9VBZAQnl0DHsoUemeVpU/Lj
ivQosKMEOyZJXdp9AuD39oj42M6UMDXaaHdJkdMvdW6CXxi69M9iZPJBR0memZ+V
NARSkhmzqvjVdCiClU2b7IE/0KxpZwUwRlA/Zl12OCr8HixOMczMRuN045PjmRab
4r0TROcE9Nw1GfrIBRI/M57Vz0lWNj3BubCa+RkMfWbVXHwt7Z3InwoS1FF5i3lw
h5BcTl9Eno6YQGtkLUfXVn0Ch2mstQALybpFkk6OB7G7YPtNf8Batz7z6EYZV1/Y
dvDOcSBDhnJzE2bp5DvPPbk4V+mgrDPRGHPYiO7V9Lo3wHHBCGi4ydqIW4fcT5EK
S6aCbRCuiKb1Ep218ZPvzOXIdLpfv0XXpWRpu9La2jBe6LKHD5YLfz9rL45hDTz9
Mt0ZRHz0zDDD2f4JpaX6jxDc+SRsJuHygASCI49srKREL48cTDcTEcFgIHLb0AG8
LqeUuL3AlWXC+nW4U2Wsl2zwKjjjb+rwnzFOgxM2+nhKpMUK6HmNxrvKy5S8ocSe
9b1u57tuLwrDfvWcbCkI
=0cTO
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
