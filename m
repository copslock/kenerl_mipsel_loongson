Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 01:27:03 +0200 (CEST)
Received: from mail-bl2on0098.outbound.protection.outlook.com ([65.55.169.98]:58656
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028799AbcEJX05DmzeB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 01:26:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pGh66H1+e3SBpb1Qu4xrRS2JNKyxAE/fRrByNVLmpNc=;
 b=B2GlySVHlUyR2CQKnNdPAvsT/zJJAI/e8bosVzB0s9OG6FEDmQ/Kdfv5CgoS3FoygqeA/PUgxBLKcrWq6S87WHAFk9boF3PVlPgMuhMwJJIlxNjgF8/n1vDinvGvdIIOKkfMDcLT6Yh4EmpQR7jh0jAfmXUH5Isx1O+h5sbaUVY=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from localhost.caveonetworks.com (64.2.3.194) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (TLS) id 15.1.492.11; Tue, 10 May 2016 23:26:49 +0000
Subject: Re: [PATCH v2] MIPS: Octeon: detect and fix byte swapped initramfs
To:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
References: <1462920603-17512-1-git-send-email-aurelien@aurel32.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <57326E36.6060708@caviumnetworks.com>
Date:   Tue, 10 May 2016 16:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1462920603-17512-1-git-send-email-aurelien@aurel32.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BN1PR07CA0047.namprd07.prod.outlook.com (10.255.193.22) To
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14)
X-MS-Office365-Filtering-Correlation-Id: b3efa354-e630-4e06-51ef-08d3792a8fdc
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;2:uogGNlNd9KXeziOUozfxRoNBVHFQfbPLVV7aWwclTJgdP0+TorbROkGY1kjYzBYuuf5780UU/09wRlMxKJKp/BuVNrTxga8otWV4nHZojXqnqlzMIr7tQJ2sasCtaFR9RuUH0xe1/5D2Za0CCZfvqdofold4aTEhtEcZzfjI67zdNMFGHyPUMhgDGfIAorvX;3:zs5WpKcGYZu4ycwS/xL0IxmV3vr3qudgNPTQ2Vfs1FAlM0iO++Z3fDm3fzpoam71ECi15nrJydbxk8aNRXzPMu/7poeyqZ4qZ7mk+beCr7GGvwgXwlcZeh5VpsiCG7hO;25:LyV/GOnND0mrdgKb/vA28p6OuVQdITauF6QN0tVJxkzNygv2Hbuqaq6dIL/lXu91/VoGOt+cLoaz/aMuNHl3tCcM3NVjQ+CwbrXspmqyp5mujlnu8gUYfYCEMDqqttc8mCkYmmbtM2qxPrSSeXnohYwxWGFea9SsW7fkCf1xbzZZkBytku494IJimjFAHbNQQb5UUI5D9S5FWjfeilR+zMEnolVe8DVgoVOPeS+y/A9EzIuMLMtXUTopR4Qxv9HT8qFIZ2YnV1B7+t6h9h0NbZ+lO95TjCcwbe4c+i+Pfy2vHfSeyHKecjsz5qPZjpIFXEg590pMNheQgVsy0DM143emhL+Cbh5SuyoMAZWEMXV//cS0ObJ4K0uwK9vNSP24E58eBmvr5FA1vBNrrTWSfaZmLGYWoAyBdwUNFW5s+8iD8Eo/xSs4BWpWlc5cJzUmYJhe9nrThsoWQutrzLsGzA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;20:VHUHSWM/VKrE8tD2+mlsssbfcTP6OLH7iikFcnedu5ul+KU7i0sh44n2upofOpUS6Yy1zYvAoDPwbTI7HpxaClW6L7kzed5AdCVA2j5SIAL8ZMSlNeCmZppdQjW3UyfI3WuB+rIouWiyzxorg+1Sp9Nv5fjCepF485l12bFOqEnR95hTHy+Esw/hwYr7ow7gF846Be0IfkyYzAdYTZ+XAs0a7jW7FVq1h2EeiQadYxjmoFXl8HOonW4vZsyKMcSkF6i5B7ymjsUQHVUHqDuMJKTgZ9HvPeUNs1wP1yJtlqSl23BmXmRhU38lOvJ+ntaUJ0WdMnMaGsZbTsqH0Dj/asPauNsXuYT9klhnSUrXPVp7rYL+RokqOLtB4P4Oh9PJMYHlmY9ArlDmrovt6tJaiy5sFig5dyHW2kC3SVca3fzUFO3rGmJBjDstGFBLEpiXioqPmRYEt9SQ7cuwCIvjHJWj1iW9aEFj5Jg1GB6waeVO7P6ZuZe2BZDpFcIv046pa965y3oeWg/BxP+fFObOg7P9XHLaeBe0bwP5sJF2rmDtRRiWPXXm9DpAP28QlkRVGPQZ40kkda1ExJv2u4qJvJqErkuzGMsFHbapBx7r6hA=
X-Microsoft-Antispam-PRVS: <SN1PR07MB214451B65D13B7B1922AE76197710@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:uamaR0qA0O3lVR1i7Rj2IX7nKH3W8UlG53LXynr2LFOon1Q75uLNHn2vIXCcN1X5CdylArNK4xTvWhFxlkRsneKIyZMPCsECFnrFH3NkwtR+Ru2aymMASjhyuUdW+gKfMPjudm1vTgaL0wvmR6PXfUUSzD9EZ0Mg2mFroZdcIHzyu/vcQaC37JC+gkit/gr/GFVE4YOaG20umsrivIL3M0QB4kRidXRIhI0t2j/zF7lh12HDZDEjjrV8pOq8H1AQaSPqTHoVXXZT14k09+1oQ8nx3zRyUCOsyRLsqFTWVSW1CoD4wAccGZZI53dl2M6rFO3BmnMdVQevXqlGfmOyL9ziRPoaMjKIskeWjRmL4w5F1hUyJVVw7N5OeQBVcRCw
X-Forefront-PRVS: 0938781D02
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6069001)(6009001)(24454002)(377454003)(4001350100001)(65956001)(66066001)(2950100001)(65806001)(36756003)(4326007)(23746002)(47776003)(42186005)(2906002)(5001770100001)(586003)(81166006)(92566002)(6116002)(3846002)(5008740100001)(59896002)(230700001)(33656002)(53416004)(76506005)(4001430100002)(107886002)(50466002)(65816999)(99136001)(189998001)(77096005)(50986999)(5004730100002)(54356999)(76176999)(87266999)(80316001)(19580405001)(19580395003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:localhost.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2144;23:pLgunGmJsGYmcHk4ccPVZlc4K6EAi2s3jxlx8?=
 =?Windows-1252?Q?CjP/KlNeBjBh9VI03y12OQsZY5dPUZNLAyFVEG6DTErg/Z6oQaG6vg9N?=
 =?Windows-1252?Q?p9HERrcr1jwfNA7MhWI2Vk+1bcml9Wu4X3nLAO1++IlzAPeAYyCe//YF?=
 =?Windows-1252?Q?9m2kLrzPKrODivsWZaftGYaSHAr/zOXwwsX4LOyx5tblX9ZNc/uSCRib?=
 =?Windows-1252?Q?1TB6VSCIw1XB2ksCFce6BEhdTvzC0u0CEMKFTWyr0xO7bjwRLnEvsslV?=
 =?Windows-1252?Q?IvA7DJFNkYT6Fne+fyLrMqKbZr7pXlQC4nNlNLQtnSsg284xuT0301UQ?=
 =?Windows-1252?Q?7iGm5TkD7mkxTYbRo1OyLzhS/bNDHrq7nBhzxhAa5bvFTRp/V8uItH8o?=
 =?Windows-1252?Q?k3Vz4i/WSu8Nq28ppgeEK18Qo3Z6usWCBIqYpwnR4vC3+OWpVOtoH/Lg?=
 =?Windows-1252?Q?fUDbLjTIXeKxgWzBk3sZE8ncLHUHZDSFVIKq8XRLdkUbBg2x0gHNsGpo?=
 =?Windows-1252?Q?a7Ht4qznfF7RAPVIy0h0V9idLyfwynVzJxcnAR/7pyinoEJ/UOmzrdCG?=
 =?Windows-1252?Q?RNHcOj5wMoyh2XnlzE7UW9Wnd80xtMektxlt+nruwTDWVq7M5nZOkHz6?=
 =?Windows-1252?Q?qLXjaxbLg7LpP9nPx81pX12LGfH5XCjG3MmJu4ht//VMmaH/9t0IDDeb?=
 =?Windows-1252?Q?YPg9pl70BBCjiheAY57oUe5iL2zi58EhJ2kGlTfzmQie7xtqPemhjvJ5?=
 =?Windows-1252?Q?yshYf/dy3j9e56s75n1pMvExghFsm4BNe5vWKUM49c5SPWaYCvVCcTQl?=
 =?Windows-1252?Q?B5TP/iJKLW3KWtcY33SlylfoGbizL9dcg2PQnRYkSSqO4meuGv5o9X3P?=
 =?Windows-1252?Q?mMl+jAqEHjwiM7YSHdgzzPHWiJyUxv6S4Z59w5y+Q/6SByHsDZvcAXAW?=
 =?Windows-1252?Q?5h/vbsVfOG3mBBwjlUuhEiBnhzk1FW/bRI5Zy7vsjcGPbvaVKtkzM/5c?=
 =?Windows-1252?Q?quxfQH6WnapT/YTs9FIjdA1uhInwXWCNXBMmyDLF8RHqf5qT2LGkIJKO?=
 =?Windows-1252?Q?k0JMP4UyqwXKqPCfTwRVbw0DBPrUkUpRqDz42wYUIj0mI/xxj1+Ab22z?=
 =?Windows-1252?Q?bEfrqmuQ73KV+CKqyQOmid47pEXbcjC13S6W21FDsswmQpPbofEjWS/t?=
 =?Windows-1252?Q?HO7g8qE9d+mF3BYwvHTjcbGpY0ZZjUFkzljEHLQa8tJcj9MuLFgxoMJR?=
 =?Windows-1252?Q?wWSx2n0jNUGCSczMA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;5:UOREAwtTZJNfo+P4GkycLLmNJNBRQz5O2CqqmGssOHye2Q3/CJdQCIyPtrVaZWulwyQ3Bef/Rm1e/y/PBJJYuW1h+L9WcppSLNsh9qWcs87dygU7sYYCzpmv8XBhLLhXEbvLSiAaUeKrXWkyYu60cA==;24:SvaTPUWu2jmkfINLiw5zKcn65pku4SxTpOgBL/2dZLtyoQ5+AwZ41seaFV1CeQyQlIrMChOWY0CSR0p2sRxoifamXmTbhB9HVPDKZuM/cqc=;7:yaL3uV2faCg0J8zvFGJrEDuQn8Rq1NpFR+RGg5Cb3QvAJ00tR4C9dhm59re4/DyaPtpMDCVPuskaOfhfotiZnl9ci+K3mslGdJ/+yiFHnYz8xQ6gNZbEJAe7qYbFwiRBTLEsPCqLaA8+lYXTMT9fK02oyK3exgyeSfys8y5Vo5WXZm30CUPt+02lhM3hzMJ+
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2016 23:26:49.2446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 05/10/2016 03:50 PM, Aurelien Jarno wrote:
> Octeon machines support running in little endian mode. U-Boot usually
> runs in big endian-mode. Therefore the initramfs is loaded in big endian
> mode, and the kernel later tries to access it in little endian mode.
>
> This patch fixes that by detecting byte swapped initramfs using either the
> CPIO header or the header from standard compression methods, and
> byte swaps it if needed. It first checks that the header doesn't match
> in the native endianness to avoid false detections. It uses the kernel
> decompress library so that we don't have to maintain the list of magics
> if some decompression methods are added to the kernel.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

I haven't tested it, but this looks good to me:

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/kernel/setup.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4f60734..8841d7982 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -26,6 +26,7 @@
>   #include <linux/sizes.h>
>   #include <linux/device.h>
>   #include <linux/dma-contiguous.h>
> +#include <linux/decompress/generic.h>
>
>   #include <asm/addrspace.h>
>   #include <asm/bootinfo.h>
> @@ -250,6 +251,35 @@ disable:
>   	return 0;
>   }
>
> +/* In some conditions (e.g. big endian bootloader with a little endian
> +   kernel), the initrd might appear byte swapped.  Try to detect this and
> +   byte swap it if needed.  */
> +static void __init maybe_bswap_initrd(void)
> +{
> +#if defined(CONFIG_CPU_CAVIUM_OCTEON)
> +	u64 buf;
> +
> +	/* Check for CPIO signature */
> +	if (!memcmp((void *)initrd_start, "070701", 6))
> +		return;
> +
> +	/* Check for compressed initrd */
> +	if (decompress_method((unsigned char *)initrd_start, 8, NULL))
> +		return;
> +
> +	/* Try again with a byte swapped header */
> +	buf = swab64p((u64 *)initrd_start);
> +	if (!memcmp(&buf, "070701", 6) ||
> +	    decompress_method((unsigned char *)(&buf), 8, NULL)) {
> +		unsigned long i;
> +
> +		pr_info("Byteswapped initrd detected\n");
> +		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
> +			swab64s((u64 *)i);
> +	}
> +#endif
> +}
> +
>   static void __init finalize_initrd(void)
>   {
>   	unsigned long size = initrd_end - initrd_start;
> @@ -263,6 +293,8 @@ static void __init finalize_initrd(void)
>   		goto disable;
>   	}
>
> +	maybe_bswap_initrd();
> +
>   	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
>   	initrd_below_start_ok = 1;
>
>
