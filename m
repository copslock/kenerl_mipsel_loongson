Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 19:29:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10390 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992121AbdBQS3fI8WdM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 19:29:35 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B4ACC41F8EAD;
        Fri, 17 Feb 2017 19:33:35 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Feb 2017 19:33:35 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Feb 2017 19:33:35 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 881D0BF19EAA9;
        Fri, 17 Feb 2017 18:29:25 +0000 (GMT)
Received: from np-p-burton.localnet (10.20.1.33) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Feb
 2017 18:29:29 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Force o32 fp64 support on 32bit MIPS64r6 kernels
Date:   Fri, 17 Feb 2017 10:29:11 -0800
Message-ID: <1648905.7UokBy1sI6@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <01a9d2344224e76ea17ff62ffa7b75717f6f1100.1487248664.git-series.james.hogan@imgtec.com>
References: <01a9d2344224e76ea17ff62ffa7b75717f6f1100.1487248664.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1722585.54YOB3sE3y";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1722585.54YOB3sE3y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi James,

On Thursday, 16 February 2017 04:39:01 PST James Hogan wrote:
> When a 32-bit kernel is configured to support MIPS64r6 (CPU_MIPS64_R6),
> MIPS_O32_FP64_SUPPORT won't be selected as it should be because
> MIPS32_O32 is disabled (o32 is already the default ABI available on
> 32-bit kernels).

Nice catch!

> This results in userland FP breakage as CP0_Status.FR is read-only 1
> since r6 (when an FPU is present) but CP0_Config5.FRE won't be set to
> emulate FR=0.

Perhaps it would be worth clarifying that what it breaks is FPU emulation or 
pre-r6 FP code running atop MIPS32r6 kernels. Since FR=1 context switching 
should work fine for r6 user code, and it would only be impacted if it 
requires emulation for some reason (which is probably why we haven't hit this 
earlier in our CI testing).

> Force o32 fp64 support in this case by also selecting
> MIPS_O32_FP64_SUPPORT from CPU_MIPS64_R6 if 32BIT.
> 
> Fixes: 4e9d324d4288 ("MIPS: Require O32 FP64 support for MIPS64 with O32
> compat") Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.0.x-
> ---
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b969522feb97..e2890002d6d1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1531,7 +1531,7 @@ config CPU_MIPS64_R6
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_MSA
>  	select GENERIC_CSUM
> -	select MIPS_O32_FP64_SUPPORT if MIPS32_O32
> +	select MIPS_O32_FP64_SUPPORT if 32BIT || MIPS32_O32
>  	select HAVE_KVM
>  	help
>  	  Choose this option to build a kernel for release 6 or later of the

Besides possibly clarifying the commit message above this looks good to me so:

    Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks,
    Paul
--nextPart1722585.54YOB3sE3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlinQPcACgkQgiDZ+mk8
HGUvLw//Wsg6j/ftl46PwMiXb6Gk5oKyCfoslndYYusb0MtPTAXDmspoUBSKugVV
x0w4wNJ+tj2m3y6L+Pw55YFWSRTGb78OYcv/FQNooIJU5EzLaLAOCmdXWAtQJEA7
hetHrf0FnrWVmOnVPmzohRtNDWIs+yUJuf1CP6S/5mWsvqeOeQfeKjR9Cuctn6sE
7pWvv8mn11HmZ1ThHX5diIJWBDiOfGVcsIKFKvKEw60GcpHzMtKfLxPrj4gzKkIU
M8apBXOh4fUzxf5ahSjqfoAmhRnbNczSKZy6OpYAY0vKoWqXebJtaLrqQj+3cLz8
cIV/JRI3rx/lQluTTPiWIiL/CVk8SU5IlW+lrtu5u8Uc8fif0DC4VJKPeaURY55O
T7U+MAxSAM6XwsGK7UA1a+ZxE9XIgecQ4jdICH5Lye2FNt7dynMX+7/ssN8LkvKz
ciZxmHmcSIuFLBPF4QRQ6tBtGz0OMOZGlcxFqe+ESMadtfTYtbm6p1Buo5jAoF8H
1feA2tak/VTUb0SneZ6uuSTv7fHpMC19qWT4r/eZnezSSVc/eewaBZcjGbcbnIJn
nIupsqxU42F6VqppHcXTBCzb9FbCAATP89bM0qRyCvtSywJOdXa1UPvK1SetLFUw
eHdVs79izKEtvjY+epyoX4ePygCzSUrq8Xlh7YqmLCFPGIrgNAE=
=TvGJ
-----END PGP SIGNATURE-----

--nextPart1722585.54YOB3sE3y--
