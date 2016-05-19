Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 09:06:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13346 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030674AbcESHGpTOoie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 09:06:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 2060D32712F2B;
        Thu, 19 May 2016 08:06:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 19 May 2016 08:06:39 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 19 May
 2016 08:06:38 +0100
Subject: Re: [PATCH v2 2/2] MIPS: CPS: Copy EVA configuration when starting
 secondary VPs.
To:     Paul Burton <paul.burton@imgtec.com>
References: <1463587956-9160-1-git-send-email-matt.redfearn@imgtec.com>
 <1463587956-9160-2-git-send-email-matt.redfearn@imgtec.com>
 <20160518223457.GA1529@NP-P-BURTON>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <573D65FE.7050801@imgtec.com>
Date:   Thu, 19 May 2016 08:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160518223457.GA1529@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Paul,

On 18/05/16 23:34, Paul Burton wrote:
> On Wed, May 18, 2016 at 05:12:36PM +0100, Matt Redfearn wrote:
>> When starting secondary VPEs which support EVA and the SegCtl registers,
>> copy the memory segmentation configuration from the running VPE to ensure
>> that all VPEs in the core have a consistent virtual memory map.
>>
>> The EVA configuration of secondary cores is dealt with when starting the
>> core via the CM.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>>
>> Changes in v2:
>> - Skip check for config3 existing - we know it must to be doing
>> multithreading
>> - Use a unique lable name in the function
>>
>>   arch/mips/kernel/cps-vec.S | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
>> index ac81edd44563..f8eae9189e38 100644
>> --- a/arch/mips/kernel/cps-vec.S
>> +++ b/arch/mips/kernel/cps-vec.S
>> @@ -431,6 +431,21 @@ LEAF(mips_cps_boot_vpes)
>>   	mfc0	t0, CP0_CONFIG
>>   	mttc0	t0, CP0_CONFIG
>>   
>> +	/*
>> +	 * Copy the EVA config from this VPE if the CPU supports it.
>> +	 * CONFIG3 must exist to be running MT startup - just read it.
>> +	 */
>> +	mfc0	t0, CP0_CONFIG, 3
>> +	and	t0, t0, MIPS_CONF3_SC
> Tiny nit - I'd prefer "andi" here since we're using an immediate. The
> assembler will figure it out though, so it's not a big deal.
Yeah, I would have too, and I did have that to start off with, but the 
assembler gave me:
arch/mips/kernel/cps-vec.S: Assembler messages:
arch/mips/kernel/cps-vec.S:450: Error: operand 3 out of range `andi 
$8,$8,((1)<<25)'
So I fell back to letting the assembler generate the LUI and AND.
>
> For both in the series:
>
>      Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Thanks Paul,
Matt

> Thanks,
>      Paul
>
>> +	beqz	t0, 3f
>> +	 nop
>> +	mfc0    t0, CP0_SEGCTL0
>> +	mttc0	t0, CP0_SEGCTL0
>> +	mfc0    t0, CP0_SEGCTL1
>> +	mttc0	t0, CP0_SEGCTL1
>> +	mfc0    t0, CP0_SEGCTL2
>> +	mttc0	t0, CP0_SEGCTL2
>> +3:
>>   	/* Ensure no software interrupts are pending */
>>   	mttc0	zero, CP0_CAUSE
>>   	mttc0	zero, CP0_STATUS
>> -- 
>> 2.5.0
>>
