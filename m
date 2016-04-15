Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 21:16:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13270 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026175AbcDOTQruH6JG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 21:16:47 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 41CB741F8EED;
        Fri, 15 Apr 2016 20:16:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 15 Apr 2016 20:16:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 15 Apr 2016 20:16:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id A5AD89B6B52F5;
        Fri, 15 Apr 2016 20:16:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 20:16:40 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 20:16:40 +0100
Date:   Fri, 15 Apr 2016 20:16:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, "Jonas Gorski" <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Alex Smith" <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 03/12] MIPS: Remove redundant asm/pgtable-bits.h
 inclusions
Message-ID: <20160415191640.GE7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-4-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <1460716620-13382-4-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53011
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

--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:36:51AM +0100, Paul Burton wrote:
> asm/pgtable-bits.h is included in 2 assembly files and thus has to
> in either of the assembly files that include it.

That could do with rewording :-)

Otherwise
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> Remove the redundant inclusions such that asm/pgtable-bits.h doesn't
> need to #ifdef around C code, for cleanliness & and in preparation for
> later patches which will add more C.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/include/asm/pgtable-bits.h | 2 --
>  arch/mips/kernel/head.S              | 1 -
>  arch/mips/kernel/r4k_switch.S        | 1 -
>  3 files changed, 4 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm=
/pgtable-bits.h
> index 97b3138..2f40312 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -191,7 +191,6 @@
>   */
> =20
> =20
> -#ifndef __ASSEMBLY__
>  /*
>   * pte_to_entrylo converts a page table entry (PTE) into a Mips
>   * entrylo0/1 value.
> @@ -218,7 +217,6 @@ static inline uint64_t pte_to_entrylo(unsigned long p=
te_val)
> =20
>  	return pte_val >> _PAGE_GLOBAL_SHIFT;
>  }
> -#endif
> =20
>  /*
>   * Cache attributes
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 4e4cc5b..b8fb0ba 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -21,7 +21,6 @@
>  #include <asm/asmmacro.h>
>  #include <asm/irqflags.h>
>  #include <asm/regdef.h>
> -#include <asm/pgtable-bits.h>
>  #include <asm/mipsregs.h>
>  #include <asm/stackframe.h>
> =20
> diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
> index 92cd051..2f0a3b2 100644
> --- a/arch/mips/kernel/r4k_switch.S
> +++ b/arch/mips/kernel/r4k_switch.S
> @@ -15,7 +15,6 @@
>  #include <asm/fpregdef.h>
>  #include <asm/mipsregs.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/pgtable-bits.h>
>  #include <asm/regdef.h>
>  #include <asm/stackframe.h>
>  #include <asm/thread_info.h>
> --=20
> 2.8.0
>=20

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXET4YAAoJEGwLaZPeOHZ6j5wP/AtoZM/60bHhaoMsXQSoAoPU
xO+TFwdF4tqwoyPQDx/K/CpzYYtViUMVuwISyDcDrefqFMrjGKtVKZU+GDBgeWjf
HPj6KoqmV5Uzqk7xV9/PKXRPvv3OdO+gNx+w731oh7xxWXUx+RZjVavfxcSgy/nb
1PmdVSH2RI8axpLRm4sKSJr9v+eW7XeLCfSpNSgKWP7qHQhYbwVH1peibWjL6fjl
bLZFxXrfufrF5EKKWKKI8uC7xwUfdRJY5fVOEe6TQnboxc9ScRrWgET0baj9Mn5s
Z23zakUxM9cxeB2RTF0tWzIfX7aNzvhoEGAOiCiVak/CN+zMEZuW/AQoDDUChMOu
NOUXgZ3qUxQeZ47HE9US52moTR/Q94OVONqNFEob79YwK3EmmS07UCJeFQqEF4rm
8EsP5eUpzaR1jtxhyeUYuG6Qw9qnyeQanBGh8eG6mwaFI1UXyudIcbqEkfB3tTQx
RUYHfgdt5Y7bgkBoQbWh89XiDPPuOUQrpTv6eyWOW9dyRqA2qWG8ASy6lg+37fMX
c/VqEUpO3AX5oWBS3APyXWqjUSNumQ3mvSe7yNfxjl8KSO0pzaYcYqQHCTaEwnNb
t320rlhNPVFSVJ00ao/xRy3mwnv5pprkU6UhsmxsMQpZwx1HtzKrHPXTaCxasKVv
Kiiy6osk+H0IscYM5aQD
=ETBt
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
