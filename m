Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 20:18:07 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:50967 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab1FUSSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 20:18:01 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 37261140192;
        Tue, 21 Jun 2011 20:17:56 +0200 (CEST)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id C49CF14021B;
        Tue, 21 Jun 2011 20:17:55 +0200 (CEST)
Message-ID: <4E00E02E.1060606@openwrt.org>
Date:   Tue, 21 Jun 2011 20:17:18 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu-HU; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
Subject: Re: [PATCH 02/13] MIPS: ath79: add revision id for the AR933X SoCs
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org> <1308597973-6037-3-git-send-email-juhosg@openwrt.org> <4E0070CA.1070102@mvista.com>
In-Reply-To: <4E0070CA.1070102@mvista.com>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 110621-0, 2011.06.21), Outbound message
X-Antivirus-Status: Clean
X-VBMS: A10E8FE9814 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17426

Hi Sergei,

> On 20-06-2011 23:26, Gabor Juhos wrote:
> 
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
>> ---
>>   arch/mips/ath79/setup.c                        |   12 ++++++++++++
>>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 ++++
>>   arch/mips/include/asm/mach-ath79/ath79.h       |    4 +++-
>>   3 files changed, 19 insertions(+), 1 deletions(-)
> 
>> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
>> index dea5af1..4cbd5e0 100644
>> --- a/arch/mips/ath79/setup.c
>> +++ b/arch/mips/ath79/setup.c
>> @@ -116,6 +116,18 @@ static void __init ath79_detect_sys_type(void)
>>           rev = id&  AR724X_REV_ID_REVISION_MASK;
>>           break;
>>
>> +    case REV_ID_MAJOR_AR9330:
>> +        ath79_soc = ATH79_SOC_AR9330;
>> +        chip = "9330";
>> +        rev = (id & AR933X_REV_ID_REVISION_MASK);
>> +        break;
>> +
>> +    case REV_ID_MAJOR_AR9331:
>> +        ath79_soc = ATH79_SOC_AR9331;
>> +        chip = "9331";
>> +        rev = (id & AR933X_REV_ID_REVISION_MASK);
> 
>    Hm, you've just removed such parens in the previous patch, why add more of
> them? :-O

Hm, you are right. I'm sure that I have removed the parentheses from this code
as well, but it seems that I lost that during a rebase process. I will fix this.

Thanks,
Gabor
