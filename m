Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 09:45:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57666 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816671AbaGPHpfuQ7oO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 09:45:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A5E5DF488FA0C;
        Wed, 16 Jul 2014 08:45:27 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 16 Jul
 2014 08:45:28 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 08:45:28 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 16 Jul
 2014 08:45:28 +0100
Message-ID: <53C62D98.6010307@imgtec.com>
Date:   Wed, 16 Jul 2014 08:45:28 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 1/3] MIPS: Add new option for unique RI/XI exceptions
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com> <1405429797-18281-2-git-send-email-markos.chandras@imgtec.com> <53C5523E.7060503@cogentembedded.com>
In-Reply-To: <53C5523E.7060503@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41214
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

Hi Sergei,

On 07/15/2014 05:09 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/15/2014 05:09 PM, Markos Chandras wrote:
> 
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
>> MIPSr5 added support for unique exception codes for the Read-Inhibit
>> and Execute-Inhibit exceptions.
> 
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> [...]
> 
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index 8219c0a5f77e..be13f2879c84 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -364,6 +364,7 @@ enum cpu_type_enum {
>>   #define MIPS_CPU_SEGMENTS    0x04000000ull /* CPU supports
>> Segmentation Control registers */
>>   #define MIPS_CPU_EVA        0x80000000ull /* CPU supports Enhanced
>> Virtual Addressing */
>>   #define MIPS_CPU_HTW        0x100000000ull /* CPU support Hardware
>> Page Table Walker */
>> +#define MIPS_CPU_RIXIEX        0x200000000ull /* CPU has unique
>> exception codes for {Read, Execute}-Inhibit exceptions */
> 
>    I think this conflicts with the MAAR patchset.
> 
> WBR, Sergei
> 

Well yes, but it's easy to resolve these conflicts.

-- 
markos
