Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 11:18:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34675 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010822AbbA3KS43gXKg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 11:18:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F363B69CB1158
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 10:18:46 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 10:18:48 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 10:18:46 +0000
Message-ID: <54CB5A86.3010903@imgtec.com>
Date:   Fri, 30 Jan 2015 10:18:46 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 67/70] MIPS: kernel: process: Do not allow FR=0
 on MIPS R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-68-git-send-email-markos.chandras@imgtec.com> <20150129231340.GI6116@NP-P-BURTON>
In-Reply-To: <20150129231340.GI6116@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45557
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

On 01/29/2015 11:13 PM, Paul Burton wrote:
> On Fri, Jan 16, 2015 at 10:49:46AM +0000, Markos Chandras wrote:
>> A prctl() call to set FR=0 for MIPS R6 should not be allowed
>> since FR=1 is the only option for R6 cores.
>>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: Matthew Fortune <matthew.fortune@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  arch/mips/include/asm/fpu.h | 3 ++-
>>  arch/mips/kernel/process.c  | 4 ++++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
>> index 994d21939676..b96d9d327626 100644
>> --- a/arch/mips/include/asm/fpu.h
>> +++ b/arch/mips/include/asm/fpu.h
>> @@ -68,7 +68,8 @@ static inline int __enable_fpu(enum fpu_mode mode)
>>  		goto fr_common;
>>  
>>  	case FPU_64BIT:
>> -#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_64BIT))
>> +#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6) \
>> +      || defined(CONFIG_64BIT))
> 
> Hi Markos,
> 
> This change really seems like a separate one, since it has nothing to do
> with the prctl or disallowing FR=1, but rather with allowing FR=1 on r6.
> 
> Thanks,
>     Paul

Thanks I will move it to a separate patch

-- 
markos
