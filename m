Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 00:15:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11074 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492164Ab0G1WPt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 00:15:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c50ac2e0000>; Wed, 28 Jul 2010 15:16:14 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Jul 2010 15:15:46 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Jul 2010 15:15:46 -0700
Message-ID: <4C50AC0C.9010507@caviumnetworks.com>
Date:   Wed, 28 Jul 2010 15:15:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] OCTEON: workaround linking failures with gcc-4.4.x 32-bits
 toolchains
References: <201007290013.08797.florian@openwrt.org>
In-Reply-To: <201007290013.08797.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2010 22:15:46.0335 (UTC) FILETIME=[6D4A32F0:01CB2EA2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 07/28/2010 03:13 PM, Florian Fainelli wrote:
> When building with a gcc-4.4.x toolchain that is configured to produce 32-bits
> executables by default, we will produce __lshrti3 in sched_clock() which is
> never resolved so the kernel fails to link. Unconditionally use the inline
> assembly version as suggested by David Daney, which works around the issue.
>
> CC: David Daney<ddaney@caviumnetworks.com>
> Signed-off-by: Florian Fainelli<florian@openwrt.org>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
> diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
> index 0bf4bbe..36400d2 100644
> --- a/arch/mips/cavium-octeon/csrc-octeon.c
> +++ b/arch/mips/cavium-octeon/csrc-octeon.c
> @@ -53,7 +53,6 @@ static struct clocksource clocksource_mips = {
>   unsigned long long notrace sched_clock(void)
>   {
>   	/* 64-bit arithmatic can overflow, so use 128-bit.  */
> -#if (__GNUC__<  4) || ((__GNUC__ == 4)&&  (__GNUC_MINOR__<= 3))
>   	u64 t1, t2, t3;
>   	unsigned long long rv;
>   	u64 mult = clocksource_mips.mult;
> @@ -73,13 +72,6 @@ unsigned long long notrace sched_clock(void)
>   		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
>   		: "hi", "lo");
>   	return rv;
> -#else
> -	/* GCC>  4.3 do it the easy way.  */
> -	unsigned int __attribute__((mode(TI))) t;
> -	t = read_c0_cvmcount();
> -	t = t * clocksource_mips.mult;
> -	return (unsigned long long)(t>>  clocksource_mips.shift);
> -#endif
>   }
>
>   void __init plat_time_init(void)
>
>
>
