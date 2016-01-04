Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 19:13:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50614 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009664AbcADSNHsHVJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 19:13:07 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 55B2841F8E88;
        Mon,  4 Jan 2016 18:13:02 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 04 Jan 2016 18:13:02 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 04 Jan 2016 18:13:02 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3FFFAC08F398C;
        Mon,  4 Jan 2016 18:12:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 18:13:02 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 4 Jan
 2016 18:13:01 +0000
Date:   Mon, 4 Jan 2016 18:13:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/3] MIPS: uaccess: Take EVA into account in
 [__]clear_user
Message-ID: <20160104181301.GH17861@jhogan-linux.le.imgtec.org>
References: <1438789299-1608-1-git-send-email-james.hogan@imgtec.com>
 <1438789299-1608-4-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <1438789299-1608-4-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50866
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

--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi stable folk,

On Wed, Aug 05, 2015 at 04:41:39PM +0100, James Hogan wrote:
> __clear_user() (and clear_user() which uses it), always access the user
> mode address space, which results in EVA store instructions when EVA is
> enabled even if the current user address limit is KERNEL_DS.
>=20
> Fix this by adding a new symbol __bzero_kernel for the normal kernel
> address space bzero in EVA mode, and call that from __clear_user() if
> eva_kernel_access().
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
> I've not Cc'd stable on this patch as eva_kernel_access() was only added
> in 4.2. I'll submit a backport once it is merged.

This is now merged, but a little later than anticipated. Please can
patch 2 & 3 be applied to stable >=3D v4.2.

The upstream commits are:

6f06a2c45d8d714ea3b11a360b4a7191e52acaa4
("MIPS: uaccess: Take EVA into account in __copy_from_user()")

d6a428fb583738ad685c91a684748cdee7b2a05f
("MIPS: uaccess: Take EVA into account in [__]clear_user")

As stated above, I'll provide backports for v3.15 <=3D version < v4.2.

Thanks
James

> ---
>  arch/mips/include/asm/uaccess.h | 32 ++++++++++++++++++++++----------
>  arch/mips/kernel/mips_ksyms.c   |  2 ++
>  arch/mips/lib/memset.S          |  2 ++
>  3 files changed, 26 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uacc=
ess.h
> index 5014e187df23..2e3b3991cf0b 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -1235,16 +1235,28 @@ __clear_user(void __user *addr, __kernel_size_t s=
ize)
>  {
>  	__kernel_size_t res;
> =20
> -	might_fault();
> -	__asm__ __volatile__(
> -		"move\t$4, %1\n\t"
> -		"move\t$5, $0\n\t"
> -		"move\t$6, %2\n\t"
> -		__MODULE_JAL(__bzero)
> -		"move\t%0, $6"
> -		: "=3Dr" (res)
> -		: "r" (addr), "r" (size)
> -		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
> +	if (eva_kernel_access()) {
> +		__asm__ __volatile__(
> +			"move\t$4, %1\n\t"
> +			"move\t$5, $0\n\t"
> +			"move\t$6, %2\n\t"
> +			__MODULE_JAL(__bzero_kernel)
> +			"move\t%0, $6"
> +			: "=3Dr" (res)
> +			: "r" (addr), "r" (size)
> +			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
> +	} else {
> +		might_fault();
> +		__asm__ __volatile__(
> +			"move\t$4, %1\n\t"
> +			"move\t$5, $0\n\t"
> +			"move\t$6, %2\n\t"
> +			__MODULE_JAL(__bzero)
> +			"move\t%0, $6"
> +			: "=3Dr" (res)
> +			: "r" (addr), "r" (size)
> +			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
> +	}
> =20
>  	return res;
>  }
> diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> index 291af0b5c482..e2b6ab74643d 100644
> --- a/arch/mips/kernel/mips_ksyms.c
> +++ b/arch/mips/kernel/mips_ksyms.c
> @@ -17,6 +17,7 @@
>  #include <asm/fpu.h>
>  #include <asm/msa.h>
> =20
> +extern void *__bzero_kernel(void *__s, size_t __count);
>  extern void *__bzero(void *__s, size_t __count);
>  extern long __strncpy_from_kernel_nocheck_asm(char *__to,
>  					      const char *__from, long __len);
> @@ -64,6 +65,7 @@ EXPORT_SYMBOL(__copy_from_user_eva);
>  EXPORT_SYMBOL(__copy_in_user_eva);
>  EXPORT_SYMBOL(__copy_to_user_eva);
>  EXPORT_SYMBOL(__copy_user_inatomic_eva);
> +EXPORT_SYMBOL(__bzero_kernel);
>  #endif
>  EXPORT_SYMBOL(__bzero);
>  EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index b8e63fd00375..8f0019a2e5c8 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -283,6 +283,8 @@ LEAF(memset)
>  1:
>  #ifndef CONFIG_EVA
>  FEXPORT(__bzero)
> +#else
> +FEXPORT(__bzero_kernel)
>  #endif
>  	__BUILD_BZERO LEGACY_MODE
> =20
> --=20
> 2.3.6
>=20

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWirYtAAoJEGwLaZPeOHZ6YIcQAIHUaorQsFqii/tARCtZOpBS
C21PK05Bq83Riqw2dE24sqrH027MgJw1N7XPVdXq4lDAZIrbuk3JI4Mm4+Num2Ci
zk3qFHlrcDRmGvKJ+HK7gmbjm2/A1hq/v10x0wS1Ot71tWH/1cPo7TCjY6PR7C+8
NjXv7T50eVbgY5++DD+K4qHHoNXeoWwC+GhllXvcC5K0aN8qRcl2+q68Jns65pkO
mFnatuFCFVY4yvwuLb9dMcge2xn4XB9yIP4Gb/bYE6+bXF0fNLnPW8VQtoJozz6Z
VwWr667meF+Ni63NwayvFD0Q5fvMawEM2XJ2USxBDYv+gaCsHii77vFz73+ITJE/
detyVGR23rcqv6tvaBmmtFPoMu5YpwYb4yN8qOmfXWZILeQo7+Rpts3lFnVCmIZm
+005XXtokDLaXESw1wex+Y0Y7LuazhWus9NTvMomrRD3juGnjXiJ7qNpcfMl63mG
XNG441XNtZJaR0BVtVlxsxR36RYJGdY1nzuVpL5iXc4aRfUg5AZuRNqFwuPEDAvU
t9KCfEq718ZSdsk+9j3KdkxloLHQRnLKAMfsdbAV44RHiWbxUP3xkjlB+3349a5N
7flwTtvX28ok5mondrhqEWZ92zo454ka1pYCdwAezV11D0iDGmXZAhwe4LbtcUFX
Zmu9X8DVG2w5bIDtUdDs
=9jRx
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
