Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 10:49:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16849 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011100AbbATJti59N7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 10:49:38 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8305FDC61E37E;
        Tue, 20 Jan 2015 09:49:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 09:49:32 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 20 Jan
 2015 09:49:30 +0000
Message-ID: <54BE24AA.30404@imgtec.com>
Date:   Tue, 20 Jan 2015 09:49:30 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 10/70] MIPS: asm: asmmacro: Drop unused 'reg' argument
 on MIPSR2
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-11-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200003060.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501200003060.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45358
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

On 01/20/2015 12:04 AM, Maciej W. Rozycki wrote:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
> 
>> The local_irq_{enable, disable} macros do not use the reg argument
>> so drop it.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  arch/mips/include/asm/asmmacro.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
>> index 6caf8766b80f..90f69c334a75 100644
>> --- a/arch/mips/include/asm/asmmacro.h
>> +++ b/arch/mips/include/asm/asmmacro.h
>> @@ -20,12 +20,12 @@
>>  #endif
>>  
>>  #ifdef CONFIG_CPU_MIPSR2
>> -	.macro	local_irq_enable reg=t0
>> +	.macro	local_irq_enable
>>  	ei
>>  	irq_enable_hazard
>>  	.endm
>>  
>> -	.macro	local_irq_disable reg=t0
>> +	.macro	local_irq_disable
>>  	di
>>  	irq_disable_hazard
>>  	.endm
> 
>  Their !CONFIG_CPU_MIPSR2 counterparts do however.

I know but ...

  Have you checked with
> GAS that it is acceptable to pass an extra argument to a macro that 
> doesn't expect one?

none of the calls in arch/mips/* to local_irq_enable or _disable pass
any argument to the macro.

To me it seems like it's ok to drop the reg argument even on
!CONFIG_CPU_MIPSR2 and simply use $t0 directly.

-- 
markos
