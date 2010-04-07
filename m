Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 18:49:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16882 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492476Ab0DGQtE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 18:49:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bbcb78b0000>; Wed, 07 Apr 2010 09:49:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 7 Apr 2010 09:48:21 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 7 Apr 2010 09:48:21 -0700
Message-ID: <4BBCB750.3000002@caviumnetworks.com>
Date:   Wed, 07 Apr 2010 09:48:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Wu Zhangin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Ralf_R=F6sch?= <roesch.ralf@web.de>
Subject: Re: [PATCH v2 1/3] MIPS: add a common mips_cyc2ns()
References: <cover.1270653461.git.wuzhangjin@gmail.com> <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
In-Reply-To: <9e1889ed5fa23dfaa1ad432ebb4b8f837f6668b4.1270655886.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2010 16:48:21.0693 (UTC) FILETIME=[21E7B6D0:01CAD672]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/07/2010 09:05 AM, Wu Zhangin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> Changes:
>
> v1 ->  v2:
>
>    o change the old mips_sched_clock() to mips_cyc2ns() and modify the
>    arguments to support 32bit.
>    o add 32bit support: use a smaller shift to avoid the quick overflow
>    of 64bit arithmatic and balance the overhead of the 128bit arithmatic
>    and the precision lost with the smaller shift.
>
> ----------------------
>
> Because the high resolution sched_clock() for r4k has the same overflow
> problem and solution mentioned in "MIPS: Octeon: Use non-overflowing
> arithmetic in sched_clock".
>
>      "With typical mult and shift values, the calculation for Octeon's
>      sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
>      calculations instead."
>
> To reduce the duplication, This patch abstracts the solution into an
> inline funciton mips_cyc2ns() into arch/mips/include/asm/time.h from
> arch/mips/cavium-octeon/csrc-octeon.c.
>
> Two patches for Cavium and R4K will be sent out respectively to use this
> common function.
>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   arch/mips/include/asm/time.h |   38 ++++++++++++++++++++++++++++++++++++++
>   1 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index c7f1bfe..898f0e0 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -96,4 +96,42 @@ static inline void clockevent_set_clock(struct clock_event_device *cd,
>   	clockevents_calc_mult_shift(cd, clock, 4);
>   }
>
> +static inline unsigned long long mips_cyc2ns(u64 cyc, u64 mult, u64 shift)
> +{
> +#ifdef CONFIG_32BIT
> +	/*
> +	 * To balance the overhead of 128bit-arithematic and the precision
> +	 * lost, we choose a smaller shift to avoid the quick overflow as the
> +	 * X86&  ARM does. please refer to arch/x86/kernel/tsc.c and
> +	 * arch/arm/plat-orion/time.c
> +	 */
> +	return (cyc * mult)>>  shift;
> +#else /* CONFIG_64BIT */
> +	/* 64-bit arithmatic can overflow, so use 128-bit.  */
> +#if (__GNUC__<  4) || ((__GNUC__ == 4)&&  (__GNUC_MINOR__<= 3))
> +	u64 t1, t2, t3;
> +	unsigned long long rv;
> +
> +	asm (
> +		"dmultu\t%[cyc],%[mult]\n\t"
> +		"nor\t%[t1],$0,%[shift]\n\t"
> +		"mfhi\t%[t2]\n\t"
> +		"mflo\t%[t3]\n\t"
> +		"dsll\t%[t2],%[t2],1\n\t"
> +		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
> +		"dsllv\t%[t1],%[t2],%[t1]\n\t"
> +		"or\t%[rv],%[t1],%[rv]\n\t"
> +		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
> +		: [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
> +		: "hi", "lo");
> +	return rv;
> +#else	/* GCC>  4.3 do it the easy way.  */
> +	unsigned int __attribute__((mode(TI))) t = cyc;
> +
> +	t = (t * mult)>>  shift;
> +	return (unsigned long long)t;
> +#endif
> +#endif /* CONFIG_64BIT */
> +}
> +
>   #endif /* _ASM_TIME_H */

It turns out that all GCC versions can handle the inline asm way.  It 
has also been noted that the default Debian compiler somehow has 
problems with the 'easy way'.

Therefore, I would recommend gitting rid of the GCC version conditionals 
and just leave the inline asm.

David Daney
