Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 10:13:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7463 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993045AbcKAJNoxyrG7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 10:13:44 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0727E41F8E8E;
        Tue,  1 Nov 2016 09:12:47 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 01 Nov 2016 09:12:47 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 01 Nov 2016 09:12:47 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5B485CF9B10C5;
        Tue,  1 Nov 2016 09:13:36 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.179) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Nov
 2016 09:13:38 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix max_low_pfn with disabled highmem
Date:   Tue, 1 Nov 2016 09:11:43 +0000
Message-ID: <3763478.aakXA3hVDP@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <2438a2e32ec8b5d9a8ea053ea483534bb63364a4.1477960419.git-series.james.hogan@imgtec.com>
References: <2438a2e32ec8b5d9a8ea053ea483534bb63364a4.1477960419.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5126388.4x4DOVvNpI";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.179]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55632
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

--nextPart5126388.4x4DOVvNpI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 1 November 2016 00:40:29 GMT James Hogan wrote:
> When low memory doesn't reach HIGHMEM_START (e.g. up to 256MB at PA=0 is
> common) and highmem is present above HIGHMEM_START (e.g. on Malta the
> RAM overlayed by the IO region is aliased at PA=0x90000000), max_low_pfn
> will be initially calculated very large and then clipped down to
> HIGHMEM_START.
> 
> This causes crashes when reading /sys/kernel/mm/page_idle/bitmap
> (i.e. CONFIG_IDLE_PAGE_TRACKING=y) when highmem is disabled. pfn_valid()
> will compare against max_mapnr which is derived from max_low_pfn when
> there is no highend_pfn set up, and will return true for PFNs right up
> to HIGHMEM_START, even though they are beyond the end of low memory and
> no page structs will actually exist for these PFNs.
> 
> This is fixed by skipping high memory regions when initially calculating
> max_low_pfn if highmem is disabled, so it doesn't get clipped too high.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/kernel/setup.c |  9 +++++++++
>  1 file changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 0d57909d9026..cb6e5895bb7e 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -368,6 +368,15 @@ static void __init bootmem_init(void)
>  		end = PFN_DOWN(boot_mem_map.map[i].addr
>  				+ boot_mem_map.map[i].size);
> 
> +#ifndef CONFIG_HIGHMEM
> +		/*
> +		 * Skip highmem here so we get an accurate max_low_pfn if low
> +		 * memory stops short of high memory.
> +		 */
> +		if (start >= PFN_DOWN(HIGHMEM_START))
> +			continue;
> +#endif
> +
>  		if (end > max_low_pfn)
>  			max_low_pfn = end;
>  		if (start < min_low_pfn)

Hi James,

Shouldn't this also clip any region which crosses the boundary from lowmem to 
highmem? (ie. start < PFN_DOWN(HIGHMEM_START) < end)

Thanks,
    Paul
--nextPart5126388.4x4DOVvNpI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGFxPAAoJEIIg2fppPBxlA/EQALM9WYBDOqwvanjwS9V2QtMS
j2JgBpmzW0W6qKqjbbFVJZes4OEwAW0eZ/IxyKQbdRXsEMFl41+JX0RAarZVePjI
RNFuz0Rt7Kd6dFqOFaBsaYnDIBCdh//30Zry5dnR4BGrT+qXTD7gGxQH5earvT99
g0YbJgTmYXjrgAtLuGGzM95EapLvIBN2mfJHuWmkcIvo/OSkTZI6rKLz+T51Nqt3
g1YrbCai0GZkM0glfBn4MdmdTcDcQE+Cp1H3JyAtmSKfjcdJHRBw9pJdBny+1K8S
4htWxpRpt79jUxJh/tT+O7Os7/Z/YSLHWnyp5Na1ZnOD39Lp340fPJiv/kZpYZ2s
gjhRGqfnwx9L7eOKzQdl/UHCyIo7nqGdnQoNfZSa3qWbol4tXktf4tARcQLsmXi+
FZbNN+WQszImcT/fQBpimVUfbhHvY/RxSqlYwyQ+D3r3/S33xCIQoX9ldVtQrJxz
EbQIbfdtLdKVyKD7mxtiWUWrPn7Sl++xUdLkGEP1drIgNyFbL7S+0zCrVnTxTxem
g2etzFwLOSmmpXvq28hV5v82Yywy1PlCNGhGtOkIB5/+b+nBDrYZ/V4HYyccCtQf
UB6hbXXrtP4dTtCUq5sgDPHpiwV+bkJ6eFnj7ew7YS0wa6r8pDVfkfXLesmeoKr9
ymNempkmC1S2vMtd0vwo
=XYqD
-----END PGP SIGNATURE-----

--nextPart5126388.4x4DOVvNpI--
