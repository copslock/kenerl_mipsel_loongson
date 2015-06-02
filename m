Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 12:48:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65218 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006982AbbFBKspnmSp4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 12:48:45 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 25FD541F8E4F;
        Tue,  2 Jun 2015 11:48:36 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 02 Jun 2015 11:48:36 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 02 Jun 2015 11:48:36 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5859F3AFE386;
        Tue,  2 Jun 2015 11:48:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 2 Jun 2015 11:48:35 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 2 Jun
 2015 11:48:35 +0100
Message-ID: <556D8A03.9080201@imgtec.com>
Date:   Tue, 2 Jun 2015 11:48:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
In-Reply-To: <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="hRlPccWPtcLvwbSk95PIVbREniG07akAB"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47783
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

--hRlPccWPtcLvwbSk95PIVbREniG07akAB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On 02/06/15 01:09, Leonid Yegoshin wrote:
> This instructions were specifically designed to work for smp_*() sort o=
f
> memory barriers in MIPS R2/R3/R5 and R6.
>=20
> Unfortunately, it's description is very cryptic and is done in HW engin=
eering
> style which prevents use of it by SW. This instructions are not mandato=
ry but
> there is a mandatory requirement - if not implemented, then a regular M=
IPS
> SYNC 0 must be used instead.
>=20
> The reason for this change is - SYNC 0 is a heavvy-weighted in many CPU=
s, it may

heavy

> disrupt other cores pipelines etc.
>=20
> Due to concern about verification of old MIPS R2 compatible cores of ot=
her
> vendors it is enforced only for MIPS R6 and other MIPS32/64 R2/R5 proce=
ssors
> have it configurable.

Is it worth inverting the logic to exclude the platforms you're
concerned about (which also makes it explicit what hardware needs
verifying). For new platforms we don't need to worry about kernel
regressions so much, so it probably makes sense to have them used by
default.

>=20
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/Kconfig               |   22 ++++++++++++++++++++++
>  arch/mips/include/asm/barrier.h |    6 ++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index be384d6a58bb..c7d0cacece3d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1347,6 +1347,7 @@ config CPU_MIPS32_R2
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_MSA
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
>  	select HAVE_KVM
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
> @@ -1365,6 +1366,8 @@ config CPU_MIPS32_R6
>  	select GENERIC_CSUM
>  	select HAVE_KVM
>  	select MIPS_O32_FP64_SUPPORT
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	select WEAK_REORDERING_BEYOND_LLSC
>  	help
>  	  Choose this option to build a kernel for release 6 or later of the
>  	  MIPS32 architecture.  New MIPS processors, starting with the Warrio=
r
> @@ -1399,6 +1402,7 @@ config CPU_MIPS64_R2
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_HUGEPAGES
>  	select CPU_SUPPORTS_MSA
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
>  	  MIPS64 architecture.  Many modern embedded systems with a 64-bit
> @@ -1415,6 +1419,8 @@ config CPU_MIPS64_R6
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_MSA
>  	select GENERIC_CSUM
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	select WEAK_REORDERING_BEYOND_LLSC
>  	help
>  	  Choose this option to build a kernel for release 6 or later of the
>  	  MIPS64 architecture.  New MIPS processors, starting with the Warrio=
r
> @@ -1876,6 +1882,20 @@ config WEAK_ORDERING
>  #
>  config WEAK_REORDERING_BEYOND_LLSC
>  	bool
> +
> +config MIPS_LIGHTWEIGHT_SYNC
> +	bool "CPU lightweight SYNC instruction for weak reordering"
> +	depends on CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC && WEAK_ORDERING

Worth depending on SMP, so as not to give the user more options than
they need?

> +	default y if CPU_MIPSR6
> +	help
> +	  This option enforces a use of "lightweight sync" instructions
> +	  for SMP (multi-CPU) memory barriers. This instructions are much
> +	  more faster than a traditional "SYNC 0".
> +
> +	  If that instructions are not implemented in processor then it is
> +	  converted to generic "SYNC 0".
> +
> +	  If you unsure, say N here, it may slightly decrease your performanc=
e

"it" is ambiguous. "Saying N" or "this option"? (I guess "saying N", but
its not obvious to an uninformed kernel configurer).

>  endmenu
> =20
>  #
> @@ -1928,6 +1948,8 @@ config CPU_SUPPORTS_HUGEPAGES
>  	bool
>  config CPU_SUPPORTS_UNCACHED_ACCELERATED
>  	bool
> +config CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	bool
>  config MIPS_PGD_C0_CONTEXT
>  	bool
>  	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/ba=
rrier.h
> index 2b8bbbcb9be0..d2a63abfc7c6 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -96,9 +96,15 @@
>  #  define smp_rmb()	barrier()
>  #  define smp_wmb()	__syncw()
>  # else
> +#  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
> +#  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory"=
)
> +#  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory"=
)
> +#  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")=


binutils appears to support the sync_mb, sync_rmb, sync_wmb aliases
since version 2.21. Can we safely use them?

Cheers
James

> +#  else
>  #  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
> +#  endif
>  # endif
>  #else
>  #define smp_mb()	barrier()
>=20
>=20


--hRlPccWPtcLvwbSk95PIVbREniG07akAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVbYoDAAoJEGwLaZPeOHZ6teYP/1/M++2h3LYBKxcTdZzpTHBS
Fw+q/AFTzrUH6qu6V9vkgzm2qmfl9HSjNpVCWbQvKjQ1XbQP+qaevWBnAsXHoIpL
1eI7nguRI2SEThzZkpZuYX6qKwnQo2JqoNkJjnM2A0Fj5+bLrD4j4JjIxj+bIUjX
s7BRZFnTHpaq+cBnKeMXD/HAxr5bw9gutKvRmpMY9Gh/RDG4QYFuVMKGAUx7+FFa
Q15LGQxllB5y7a3hMzFn+exF3B+v+GdOgH6M6MppPVGtBAgLRzCtVWfblxDHS9nA
kvhABr5pCKdj/aRYegS39b+cFjdacuR5b8QXxGQMhfgwa3FbhWq26BQeeH3Qub17
sxOFsWsLgCNnFnutmG+L+e/IgpJv8KlKNzQpYuSKkzzAiqcMttZV7s8ZPPhYmJ/C
y1gcuPWhVfTankAhdUdtsII4wcCWes1NoYBu8+IkTBVlgw2MLMeDGxZoV+delqAC
hwiAgIqypdywS/x4q4IZOfZEo5JhLsnnriJq+rPTmVGSHD1Ph6LyEXQDdQEr3cvk
FEbJzzdiewJyy9O4LZc8C0PpNDh+UhJN/e8SP4O6Q+hTzAsM8bjCQyeEfybJmu7q
7nzYsaDS6FUELM/TdXRCZp7OtMAlTduruFVSZvOUun32j39E9d/RZIB0I2KRgKJ+
WvrUa1qBf4JnVPSBJ57Q
=MIb+
-----END PGP SIGNATURE-----

--hRlPccWPtcLvwbSk95PIVbREniG07akAB--
