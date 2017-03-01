Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 14:51:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53955 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993637AbdCANv0UdzHl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 14:51:26 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id ABB9E997667C3;
        Wed,  1 Mar 2017 13:51:17 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 1 Mar
 2017 13:51:20 +0000
Subject: Re: [PATCH 2/4] MIPS: microMIPS: Fix decoding of addiusp instruction
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com>
 <1488296279-23057-3-git-send-email-matt.redfearn@imgtec.com>
 <alpine.DEB.2.00.1702282153030.26999@tp.orcam.me.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <1a543316-79bc-3443-4469-1aa0d29f3cc6@imgtec.com>
Date:   Wed, 1 Mar 2017 13:51:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1702282153030.26999@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56940
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

Hi Maciej,


On 28/02/17 22:04, Maciej W. Rozycki wrote:
> On Tue, 28 Feb 2017, Matt Redfearn wrote:
>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index 5b1e932ae973..6ba5b775579c 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -386,8 +386,9 @@ static int get_frame_info(struct mips_frame_info *info)
>>   
>>   					if (ip->halfword[0] & mm_addiusp_func)
>>   					{
>> -						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
>> -						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
>> +						tmp = (ip->halfword[0] >> 1) & 0x1ff;
>> +						tmp = tmp | ((tmp & 0x100) ? 0xfe00 : 0);
>> +						info->frame_size = -(signed short)(tmp << 2);
>   Ugh, this is unreadable -- can you please figure out a way to fit it in
> 79 columns?  Perhaps by factoring this piece out?

Yeah, it's not pretty. I've got a v2 which refactors this into 
is_sp_move_ins, which makes it work the same way as is_ra_save_ins and 
perform the immediate interpretation there, instead.
But I've kept that as a separate patch so as to keep the functional fix 
and refactor separate.

>
>   Also this:
>
> 	tmp = (ip->halfword[0] >> 1) & 0x1ff;
> 	tmp = tmp | ((tmp & 0x100) ? 0xfe00 : 0);
>
> will likely result in better code without the conditional, e.g.:
>
> 	tmp = (((ip->halfword[0] >> 1) & 0x1ff) ^ 0x100) - 0x100;
>
> (the usual way to sign-extend).
>
>    Maciej

Yes, that looks nicer.

Thanks,
Matt
