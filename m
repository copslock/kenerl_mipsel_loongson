Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 13:16:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28128 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011451AbbAUMQ2NRyZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 13:16:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0734FC3853DB;
        Wed, 21 Jan 2015 12:16:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 12:16:22 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 12:16:21 +0000
Message-ID: <54BF9895.5000200@imgtec.com>
Date:   Wed, 21 Jan 2015 12:16:21 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 18/70] MIPS: asm: spram: Add MIPS R6 related definitions
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-19-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200009520.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501200009520.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45404
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

On 01/20/2015 12:13 AM, Maciej W. Rozycki wrote:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
> 
>> MIPS R6, just like MIPS R2, can use the spram_config() function
>> in spram.c
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  arch/mips/include/asm/spram.h | 4 ++--
>>  arch/mips/kernel/Makefile     | 1 +
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/spram.h b/arch/mips/include/asm/spram.h
>> index 0b89006e4907..e02a1961c542 100644
>> --- a/arch/mips/include/asm/spram.h
>> +++ b/arch/mips/include/asm/spram.h
>> @@ -1,10 +1,10 @@
>>  #ifndef _MIPS_SPRAM_H
>>  #define _MIPS_SPRAM_H
>>  
>> -#ifdef CONFIG_CPU_MIPSR2
>> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
>>  extern __init void spram_config(void);
>>  #else
>>  static inline void spram_config(void) { };
>> -#endif /* CONFIG_CPU_MIPSR2 */
>> +#endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
>>  
>>  #endif /* _MIPS_SPRAM_H */
>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>> index 92987d1bbe5f..0862ae781339 100644
>> --- a/arch/mips/kernel/Makefile
>> +++ b/arch/mips/kernel/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
>>  obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
>>  obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
>>  obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
>> +obj-$(CONFIG_CPU_MIPSR6)	+= spram.o
>>  
>>  obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
>>  obj-$(CONFIG_MIPS_VPE_LOADER_CMP) += vpe-cmp.o
> 
>  It looks to me like this should be a separate CONFIG_MIPS_SPRAM option 
> selected by CPU_MIPSR2 and CPU_MIPSR6.  This will avoid the need to list 
> `spram.o' twice which may be asking for troubles.  Also this will keep 
> simple the `#ifdef' condition above.
> 
>   Maciej
> 
ok i will do that instead. thanks

-- 
markos
