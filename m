Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2010 18:42:12 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41432 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491921Ab0KNRlt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Nov 2010 18:41:49 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 21F8E3FC018;
        Sun, 14 Nov 2010 18:41:44 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 878C91F0001;
        Sun, 14 Nov 2010 18:41:43 +0100 (CET)
Message-ID: <4CE01F56.8090304@openwrt.org>
Date:   Sun, 14 Nov 2010 18:41:42 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 05/18] MIPS: ath79: add initial support for the Atheros
 PB44 reference board
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-6-git-send-email-juhosg@openwrt.org> <4CDE7A92.8040602@mvista.com>
In-Reply-To: <4CDE7A92.8040602@mvista.com>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A17E12B3A37 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

> Hello.
> 
> On 13-11-2010 0:51, Gabor Juhos wrote:
> 
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> [...]
> 
>> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
>> index 32e2658..47a8af4 100644
>> --- a/arch/mips/ath79/Kconfig
>> +++ b/arch/mips/ath79/Kconfig
>> @@ -1,5 +1,17 @@
>>   if ATH79
>>
>> +menu "Atheros AR71XX/AR724X/AR913X machine selection"
>> +
>> +config ATH79_MACH_PB44
>> +    bool "Atheros PB44 reference board"
>> +    select SOC_AR71XX
>> +    default n
> 
>    That "default n" is assumed, so there's no need to specify it.

Ok. I will remove that.

Thank you,
Gabor
