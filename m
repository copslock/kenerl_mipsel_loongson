Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 02:34:10 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:50961 "EHLO
        tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491798Ab0GEAeG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 02:34:06 +0200
Received: from mailgate4.nec.co.jp ([10.7.69.184])
        by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o650Y07L015324;
        Mon, 5 Jul 2010 09:34:00 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o650Y0R04374; Mon, 5 Jul 2010 09:34:00 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64]) by vgate02.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o650Xx902560; Mon, 5 Jul 2010 09:33:59 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay61.aps.necel.com with ESMTP; Mon, 5 Jul 2010 09:33:59 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Mon, 5 Jul 2010 09:33:59 +0900
Message-ID: <4C312860.3020005@renesas.com>
Date:   Mon, 05 Jul 2010 09:33:36 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Shinya Kuribayashi <skuribay@pobox.com>,
        David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static optimization
 is required
References: <4C2755A3.3080600@pobox.com> <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com> <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net> <4C2F49D0.60200@pobox.com> <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi.px@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips

Hi,

On 7/4/2010 2:03 AM, Maciej W. Rozycki wrote:
>  Malta also supports a couple of MIPS IV processors too, so please be 
> careful about such assumptions.

Ah, that's the answer I'm looking for, thanks!  So current irq_ffs()
form (clz() is enabled only when CONFIG_CPU_MIPS32/64 is selected) is
well-suited for Malta platform, and it seems better to leave them as
they are.  I'll drop the patch from my list.

>> +	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
>> +		int x;
>> +		__asm__(
>> +		"	.set	push					\n"
>> +		"	.set	mips32					\n"
>> +		"	clz	%0, %1					\n"
>> +		"	.set	pop					\n"
>> +		: "=r" (x)
>> +		: "r" (pending));
>> +
>> +		return -x + 31 - CAUSEB_IP;
>> +	}
> 
>  Hmm, ".set mips32" looks dodgy here.  For pre-MIPS32/64 platforms this 
> code should never make it to the assembler and if it did, then a 
> build-time error is better than a run-time problem.

I see, cpu_has_clo_clz doesn't work well for platforms such as Malta.
Malta can support several ISAs at a time, which is very valuable, but
hard to be optimized :-)

>  It might be simpler just to use __builtin_ffs() for this variant though.  
> Inline assembly is better avoided unless absolutely required.  Not even 
> mentioning readability.

Hm.  It might be simpler, but it's not the purpose of irq_ffs(), IMHO.

-- 
Shinya Kuribayashi
Renesas Electronics
