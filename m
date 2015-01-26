Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 12:47:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32862 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010957AbbAZLrUVHhtj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 12:47:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6EB8E74BCC317;
        Mon, 26 Jan 2015 11:47:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 11:47:14 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 26 Jan
 2015 11:47:13 +0000
Message-ID: <54C62941.6060604@imgtec.com>
Date:   Mon, 26 Jan 2015 11:47:13 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
CC:     <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] MIPS: HTW: Prevent accidental HTW start due to nested
 htw_{start,stop}
References: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com> <1422265236-29290-3-git-send-email-markos.chandras@imgtec.com> <54C626CC.2070104@imgtec.com>
In-Reply-To: <54C626CC.2070104@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/26/2015 11:36 AM, James Hogan wrote:

> 
>> +		raw_current_cpu_data.htw_seq++;				\
> 
> not "if (!raw_current_cpu_data.htw_seq++)) {"?
Why?

on _stop() calls you just increment it. The _start() will do the right
thing then.

I think what you suggest it to move the if() condition from the _start()
to _stop().

> 
>>  		write_c0_pwctl(read_c0_pwctl() &			\
>>  			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
>>  		back_to_back_c0_hazard();				\
>> +		local_irq_restore(flags);				\
>>  	}								\
>>  } while(0)
>>  
>>  #define htw_start()							\
>>  do {									\
>> +	unsigned long flags;						\
>> +									\
>>  	if (cpu_has_htw) {						\
>> -		write_c0_pwctl(read_c0_pwctl() |			\
>> -			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
>> -		back_to_back_c0_hazard();				\
>> +		local_irq_save(flags);					\
>> +		if (!--raw_current_cpu_data.htw_seq) {			\
>> +			write_c0_pwctl(read_c0_pwctl() |		\
>> +				       (1 << MIPS_PWCTL_PWEN_SHIFT));	\
>> +			back_to_back_c0_hazard();			\
>> +		}							\
>> +		local_irq_restore(flags);				\
>>  	}								\
>>  } while(0)
>>  
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index dc49cf30c2db..5d6e59f20750 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -367,8 +367,10 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
>>  	if (config3 & MIPS_CONF3_MSA)
>>  		c->ases |= MIPS_ASE_MSA;
>>  	/* Only tested on 32-bit cores */
>> -	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT))
>> +	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT)) {
>> +		c->htw_seq = 0;
> 
> is that necessary, since cpu_data[] is global?

I checked and it is not placed in the .data instead of .bss section so i
was not sure if it is initialized properly.

-- 
markos
