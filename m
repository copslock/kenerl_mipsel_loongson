Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 10:28:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60895 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991232AbcKAJ1xCMtUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 10:27:53 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9813D41F8E8E;
        Tue,  1 Nov 2016 09:26:54 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 01 Nov 2016 09:26:54 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 01 Nov 2016 09:26:54 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E867D1C912CF;
        Tue,  1 Nov 2016 09:27:43 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.179) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Nov
 2016 09:27:46 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Fix ISA I FP sigcontext access violation handling
Date:   Tue, 1 Nov 2016 09:27:39 +0000
Message-ID: <3679706.n1bQkNAIWn@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1610310325060.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk> <alpine.DEB.2.00.1610310325060.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2082248.U7eFgs0xAx";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.179]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55633
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

--nextPart2082248.U7eFgs0xAx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 31 October 2016 16:25:44 GMT Maciej W. Rozycki wrote:
> Complement commit 0ae8dceaebe3 ("Merge with 2.3.10.") and use the local
> `fault' handler to recover from FP sigcontext access violation faults,
> like corresponding code does in r4k_fpu.S.  The `bad_stack' handler is
> in syscall.c and is not suitable here as we want to propagate the error
> condition up through the caller rather than killing the thread outright.
> 
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  I guess it hardly ever triggers and code still builds, so it has aged so
> well...
> 
>   Maciej
> 
> linux-mips-isa1-sig-fp-context-fault.patch
> Index: linux-sfr-test/arch/mips/kernel/r2300_fpu.S
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/kernel/r2300_fpu.S	2016-10-22
> 02:36:46.000000000 +0100 +++
> linux-sfr-test/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:37:20.891186000
> +0100 @@ -21,7 +21,7 @@
>  #define EX(a,b)							\
>  9:	a,##b;							\
>  	.section __ex_table,"a";				\
> -	PTR	9b,bad_stack;					\
> +	PTR	9b,fault;					\
>  	.previous
> 
>  	.set	noreorder

Hi Maciej,

Looks good to me:

    Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks,
    Paul
--nextPart2082248.U7eFgs0xAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGGALAAoJEIIg2fppPBxl3WkQAI5HhsSeuvTTh3oKocYTAlLz
JwZlV7zWmG0P6yQrVtjdzlsRhlJoF2RLpRw2rKrwvgIWkEOJUlLG1swkM7JUWcIK
qK6oDSrfN/3Fo0q0P8l55XnmXB4iFx83i4Toec4OEcfl97Wp5Nlf09GTTbljP9zo
GWggGSIbEIUUg+oCe6zAdrjiXo4f1iQ2eMxp1Ym2XlSmjpdhkcVBtJucvFpRodNy
/VsZPZCeHcW5SFFb6wGu0U47JKfy6b7pkptzquQQpHqnH7JkSPeBO8v4ecRJTCpW
VVMo+difjo3HeARKlWIR0SBtwinpdgh2WcWUkPcvq3+sbFwEeLRE7lLENnGOCQqD
WoT2qhWWE293wDHdgMFGCr1CvYytJynTEdLNVLREM+Xu+0Utc4QOHVc7OvgO3eqR
09CgKuzkYzNI2DfdQaAVasKHs3qnfAq5slsjl2SYv3blIjmIvjUFkdzj82uvbune
KXV61yORDknFY9RQZLO5MPSbEUvw8vRfg271r93A6r540A6t/Opk9ekESQn8EEQV
E1MtVfZ6gY+c5v0v5XUksdInlePycjHcqBrP5D206C7JT22LXDHPzT11cvXmObUy
G9DDZKJ6gHHqdE9pJyZrvTpkGzg5e2UMGXFjORpSiC49yex/nRnyPXNRhttyEUjv
5igexToaU7KsAG72wKuD
=1ZQ6
-----END PGP SIGNATURE-----

--nextPart2082248.U7eFgs0xAx--
