Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2015 20:13:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5720 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010220AbbJPSNTjC32A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2015 20:13:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C774D16D24509;
        Fri, 16 Oct 2015 19:13:10 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 16 Oct
 2015 19:13:13 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Fri, 16 Oct
 2015 19:13:13 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 16 Oct
 2015 11:13:11 -0700
Message-ID: <56213E36.7060108@imgtec.com>
Date:   Fri, 16 Oct 2015 11:13:10 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <alex.smith@imgtec.com>
Subject: Re: [PATCH] MIPS64: signal: n64 kernel bugfix of MIPS32 o32 ABI sigaction
 syscall
References: <20151015185020.37483.82586.stgit@ubuntu-yegoshin> <5620B129.4020008@imgtec.com>
In-Reply-To: <5620B129.4020008@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 10/16/2015 01:11 AM, Markos Chandras wrote:
> On 10/15/2015 07:50 PM, Leonid Yegoshin wrote:
>> MIPS32 o32 ABI sigaction() processing on MIPS64 n64 kernel was incorrectly
>> set to processing aka rt_sigaction() variant only.
>>
>> Fixed.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> ---
>>   arch/mips/include/asm/signal.h |   15 ++++++++++++---
>>   arch/mips/kernel/signal.c      |    2 +-
>>   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/signal.h b/arch/mips/include/asm/signal.h
>> index 003e273eff4c..06fe599782df 100644
>> --- a/arch/mips/include/asm/signal.h
>> +++ b/arch/mips/include/asm/signal.h
>> @@ -11,11 +11,20 @@
>>   
>>   #include <uapi/asm/signal.h>
>>   
>> +#ifdef CONFIG_MIPS32_COMPAT
>> +extern struct mips_abi mips_abi_32;
>>   
>> -#ifdef CONFIG_TRAD_SIGNALS
>> -#define sig_uses_siginfo(ka)	((ka)->sa.sa_flags & SA_SIGINFO)
>> +#define sig_uses_siginfo(ka, abi)                               \
>> +	(config_enabled(CONFIG_64BIT) ?                         \
>> +		(config_enabled(CONFIG_MIPS32_COMPAT) ?         \
>> +			(abi != &mips_abi_32) : 1) :            \
>> +		(config_enabled(CONFIG_TRAD_SIGNALS) ?          \
>> +			((ka)->sa.sa_flags & SA_SIGINFO) : 1) )
>>   #else
>> -#define sig_uses_siginfo(ka)	(1)
>> +#define sig_uses_siginfo(ka, abi)                               \
>> +	(config_enabled(CONFIG_64BIT) ? 1 :                     \
>> +		(config_enabled(CONFIG_TRAD_SIGNALS) ?          \
>> +			((ka)->sa.sa_flags & SA_SIGINFO) : 1) )
>>   #endif
>>   
>>   #include <asm/sigcontext.h>
>> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
>> index bf792e2839a6..5f18d0b879e0 100644
>> --- a/arch/mips/kernel/signal.c
>> +++ b/arch/mips/kernel/signal.c
>> @@ -798,7 +798,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>>   		regs->regs[0] = 0;		/* Don't deal with this again.	*/
>>   	}
>>   
>> -	if (sig_uses_siginfo(&ksig->ka))
>> +	if (sig_uses_siginfo(&ksig->ka, abi))
>>   		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
>>   					  ksig, regs, oldset);
>>   	else
>>
> Is this similar to
>
> https://www.linux-mips.org/archives/linux-mips/2015-08/msg00449.html ?
>
It is similar but not exact copy - my patch follows an exact rules and 
for exam - doesn't check SA_SIGINFO for n32/n64 ABI. It checks only for o32.
