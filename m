Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 12:28:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39278 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026994AbcDSK2ACBvh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 12:28:00 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id E3AE3A303D208;
        Tue, 19 Apr 2016 11:27:50 +0100 (IST)
Received: from [192.168.167.31] (192.168.167.31) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 11:27:53 +0100
Subject: Re: [PATCH] mips: pistachio: Determine SoC revision during boot
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Jonas Gorski <jogo@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1460989489-30469-1-git-send-email-james.hartley@imgtec.com>
 <57151260.1060300@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>
From:   James Hartley <james.hartley@imgtec.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <5716081C.9080506@imgtec.com>
Date:   Tue, 19 Apr 2016 11:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <57151260.1060300@cogentembedded.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.167.31]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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

Hi Sergei

On 18/04/16 17:59, Sergei Shtylyov wrote:
> Hello.
>
> On 04/18/2016 05:24 PM, James Hartley wrote:
>
>> Now that there are different revisions of the Pistachio SoC
>> in circulation, add this information to the boot log to make
>> it easier for users to determine which hardware they have.
>>
>> Signed-off-by: James Hartley <james.hartley@imgtec.com>
>> Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
>>
>> diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
>> index 96ba2cc..48f8755 100644
>> --- a/arch/mips/pistachio/init.c
>> +++ b/arch/mips/pistachio/init.c
> [...]
>> @@ -24,9 +26,28 @@
>>   #include <asm/smp-ops.h>
>>   #include <asm/traps.h>
>>
>> +/*
>> + * Core revision register decoding
>> + * Bits 23 to 20: Major rev
>> + * Bits 15 to 8: Minor rev
>> + * Bits 7 to 0: Maintenance rev
>> + */
>> +#define PISTACHIO_CORE_REV_REG    0xB81483D0
>> +#define PISTACHIO_CORE_REV_A1    0x00100006
>> +#define PISTACHIO_CORE_REV_B0    0x00100106
>> +
>>   const char *get_system_type(void)
>>   {
>> -    return "IMG Pistachio SoC";
>> +    u32 core_rev;
>> +
>> +    core_rev = __raw_readl((const void *)PISTACHIO_CORE_REV_REG);
>> +
>> +    if (core_rev == PISTACHIO_CORE_REV_B0)
>> +        return "IMG Pistachio SoC (B0)";
>> +    else if (core_rev == PISTACHIO_CORE_REV_A1)
>> +        return "IMG_Pistachio SoC (A1)";
>> +    else
>> +        return "IMG_Pistachio SoC";
>
>    How about the *switch* instead?
Yes, that would be slightly more readable - I'll do that in V2.

Thanks for the review! 

James.
>
> [...]
>
> MBR, Sergei
>
