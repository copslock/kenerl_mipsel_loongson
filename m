Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 00:00:36 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34442 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbcILWA3ecrka (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 00:00:29 +0200
Received: by mail-pf0-f193.google.com with SMTP id g202so8647190pfb.1;
        Mon, 12 Sep 2016 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=9pSHq9IliiklT+3/rrNLUZbsJgFLIRZEjVe6Ik8DLpo=;
        b=eUK+/J2ZdwqHcvM0tg+LnaoUJ2xHPl5z1MPRLcdf3rN3rMzb++tkxRfztCVnNwqqew
         j9AGU5KlUKEqAT0ubljI77eOcabp4oUIAlGle/JN2axpgOQERkbaN6kTGdMhdigpRpOo
         DT0SuF8+yzVglXhlDOV0Pt4pk2nrS+eq5vcGWr1UnhhbFutTg5SO7oWZlNZIct7NLSQm
         V+oVhaukJfdITueCXK+tmAABBPxovpLyQD0msF05LwwCy4tH2ckczDr8oWF5jS4DZrTx
         28x7naIHvq+pj2jiaJYS1kf9abWjUoZR12PvgiwvSULXGJH76tj2aitLPjO/qy2dAIDl
         yVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=9pSHq9IliiklT+3/rrNLUZbsJgFLIRZEjVe6Ik8DLpo=;
        b=YirF4DOZOyGvJG+c6t9ApUYv/BIdRei+4PmVM6Ew0WuQxJp6PL3RqWv8v+tKfPk75K
         Lv7mcs+hVLaMOHUDhlJgzNySQuET1uNpU9GwqHEP5e6GrCVZw80idqiCvz0DQ2qnS0LN
         u3ZTConhAR5RnJlwsqDqT5RPdaZc9vWalkjGYuc707C5FjYwPL24sasMO3wXRmnTqRQo
         l5KKl1Qg+WrsUC7tmSYvAVZmMJvITOc4fNysI2JPCoMMdD1PmnIFEWMdBqXmVu8JQ9SY
         doSBPbshYkFv1/PP0EOwzDyn+kW7i5//KHAmZW1FYFObmdBq6vyWqEg5q0HmirZ/BTvp
         qEuQ==
X-Gm-Message-State: AE9vXwMQzllajMbsiRpLd1t9hfW80WhY/Hygi7yZXEiVNyQ4zT91OVdCRmDCCxfAzY5Kvg==
X-Received: by 10.98.12.29 with SMTP id u29mr9940289pfi.80.1473717623682;
        Mon, 12 Sep 2016 15:00:23 -0700 (PDT)
Received: from dl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id g28sm7208885pfj.40.2016.09.12.15.00.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 15:00:22 -0700 (PDT)
Message-ID: <57D72575.8060506@gmail.com>
Date:   Mon, 12 Sep 2016 15:00:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Use defines instead of magic numbers
References: <20160912203343.26751-1-asbjorn@asbjorn.st>
In-Reply-To: <20160912203343.26751-1-asbjorn@asbjorn.st>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/12/2016 01:33 PM, Asbjoern Sloth Toennesen wrote:
> The patch will be followed by a similar patch to
> drivers/staging/octeon/ethernet.c
>
> Signed-off-by: Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 15 ++++++++++-----
>   arch/mips/include/asm/octeon/cvmx-ipd-defs.h    |  2 ++
>   2 files changed, 12 insertions(+), 5 deletions(-)
>

Nobody knows what the purpose of 
__cvmx_helper_errata_fix_ipd_ptr_alignment() is.  Since there are no 
commercially available devices with the effected hardware (cn30xx, 
cn31xx), perhaps we should just remove the whole thing.


> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index ff26d02..9b938c8 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -46,6 +46,8 @@
>   #include <asm/octeon/cvmx-smix-defs.h>
>   #include <asm/octeon/cvmx-asxx-defs.h>
>
> +#include <linux/if_ether.h>
> +
>   /**
>    * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
>    * priorities[16]) is a function pointer. It is meant to allow
> @@ -918,7 +920,8 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
>   		p64 = (uint64_t *) cvmx_phys_to_ptr(pkt_buffer.s.addr);
>   		p64[0] = 0xffffffffffff0000ull;
>   		p64[1] = 0x08004510ull;
> -		p64[2] = ((uint64_t) (size - 14) << 48) | 0x5ae740004000ull;
> +		p64[2] = ((uint64_t) (size - ETH_HLEN) << 48)
> +			| 0x5ae740004000ull;
>   		p64[3] = 0x3a5fc0a81073c0a8ull;
>
>   		for (i = 0; i < num_segs; i++) {
> @@ -954,11 +957,13 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
>   			       1 << INDEX(FIX_IPD_OUTPORT));
>
>   		cvmx_write_csr(CVMX_GMXX_RXX_JABBER
> -			       (INDEX(FIX_IPD_OUTPORT),
> -				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
> +				(INDEX(FIX_IPD_OUTPORT),
> +					INTERFACE(FIX_IPD_OUTPORT)),
> +				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
>   		cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
> -			       (INDEX(FIX_IPD_OUTPORT),
> -				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
> +				(INDEX(FIX_IPD_OUTPORT),
> +					INTERFACE(FIX_IPD_OUTPORT)),
> +				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
>
>   		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
>   					     cvmx_pko_get_base_queue
> diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> index 1193f73..a877917 100644
> --- a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> +++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> @@ -28,6 +28,8 @@
>   #ifndef __CVMX_IPD_DEFS_H__
>   #define __CVMX_IPD_DEFS_H__
>
> +#define CVMX_IPD_MAX_MTU 65392
> +
>   #define CVMX_IPD_1ST_MBUFF_SKIP (CVMX_ADD_IO_SEG(0x00014F0000000000ull))
>   #define CVMX_IPD_1st_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000150ull))
>   #define CVMX_IPD_2nd_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000158ull))
>
