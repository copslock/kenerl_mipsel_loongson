Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 14:33:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48902 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008643AbcCQNdL3GBOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 14:33:11 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 45B9AC2CDF0C7;
        Thu, 17 Mar 2016 13:33:03 +0000 (GMT)
Received: from [192.168.154.40] (192.168.154.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 17 Mar
 2016 13:33:05 +0000
Subject: Re: [PATCH 3/5] rtc: rtc-jz4740: Add support for devicetree
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Paul Cercueil <paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-3-git-send-email-paul@crapouillou.net>
 <20160317120804.GD3362@piout.net>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <rtc-linux@googlegroups.com>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <56EAB210.70900@imgtec.com>
Date:   Thu, 17 Mar 2016 13:33:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160317120804.GD3362@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.40]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Hi Alexandre,

On 17/03/16 12:08, Alexandre Belloni wrote:
> On 05/03/2016 at 23:38:49 +0100, Paul Cercueil wrote :
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
>> index 47617bd..3914b1c 100644
>> --- a/drivers/rtc/rtc-jz4740.c
>> +++ b/drivers/rtc/rtc-jz4740.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/rtc.h>
>>   #include <linux/slab.h>
>> @@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
>>
>> +static const struct of_device_id jz4740_rtc_of_match[] = {
>> +	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
>> +	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
>
> ingenic is not in Documentation/devicetree/bindings/vendor-prefixes.txt,
> you have to add it there before using it.

Ingenic is in vendor-prefixes.txt - it was added by Commit f289cc7 
("devicetree/bindings: add Ingenic Semiconductor vendor prefix").

Thanks,

Harvey
