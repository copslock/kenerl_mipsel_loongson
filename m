Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jun 2010 21:09:45 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:34772 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492137Ab0FETJl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jun 2010 21:09:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id D75244B6;
        Sat,  5 Jun 2010 21:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FqKkiA7B3FJQ; Sat,  5 Jun 2010 21:09:35 +0200 (CEST)
Received: from [192.168.37.30] (port-11083.pppoe.wtnet.de [84.46.43.118])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id C9DD44B5;
        Sat,  5 Jun 2010 21:09:29 +0200 (CEST)
Message-ID: <4C0AA0CA.9020808@metafoo.de>
Date:   Sat, 05 Jun 2010 21:08:58 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [RFC][PATCH 22/26] hwmon: Add JZ4740 ADC driver
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-6-git-send-email-lars@metafoo.de> <4C0A87F1.8000201@jic23.retrosnub.co.uk>
In-Reply-To: <4C0A87F1.8000201@jic23.retrosnub.co.uk>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3956

Hi

Jonathan Cameron wrote:
> On 06/02/10 20:12, Lars-Peter Clausen wrote:
>   
>> This patch adds support for the ADC module on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>>  drivers/hwmon/Kconfig      |   11 ++
>>  drivers/hwmon/Makefile     |    1 +
>>  drivers/hwmon/jz4740-adc.c |  423 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/jz4740-adc.h |   25 +++
>>  4 files changed, 460 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/hwmon/jz4740-adc.c
>>  create mode 100644 include/linux/jz4740-adc.h
>>     
> Hi, I'm just wondering of one wants the majority of this driver to sit in hwmon?
>
> Looks to me like a fairly classic case for something that might be best implemented
> as an mfd with the hwmon, touchscreen and battery drivers separately hanging off that.
> You might well have someone who needs the battery driver to work, but doesn't care
> about hwmon and so doesn't want to build that bit in... 
>
> Just an immediate thought.  Perhaps this is the best way to do things...
>   
I've thought about it before and rejected the idea at that time, because
I thought it will add more abstraction then actually needed.
But at that time the adc driver was not a hwmon driver yet and thus
didn't pull in the whole hwmon framework if you only wanted to use the
battery driver.
But the more I'm thinking about it now it might actually make sense to
move the common code to a MFD driver.
> Also after a quick look.  How is it used by the touchscreen driver?
> If not, please remove the reference from kconfig until it it is true.
>   
There is no touchscreen driver yet. But if I'm going to remove the
reference I'm pretty sure that someone will come up and ask why it
actually is necessary to have a separate driver instead of putting all
the code into the battery driver.
> Few other bits and bobs inline.
>   
>>
>> diff --git a/drivers/hwmon/jz4740-adc.c b/drivers/hwmon/jz4740-adc.c
>> new file mode 100644
>> index 0000000..635dfe9
>> --- /dev/null
>> +++ b/drivers/hwmon/jz4740-adc.c
>> @@ -0,0 +1,423 @@
>> + [...]
>> +static ssize_t jz4740_adc_read_adcin(struct device *dev,
>> +					struct device_attribute *dev_attr,
>> +					char *buf)
>> +{
>> +	struct jz4740_adc *adc = dev_get_drvdata(dev);
>> +	unsigned long t;
>> +	uint16_t val;
>> +
>> +	jz4740_adc_clk_enable(adc);
>> +
>>     
> Is there a possible race here?
>   
Where exactly?
>> +	jz4740_adc_enable_irq(adc, JZ_ADC_IRQ_ADCIN);
>> +	jz4740_adc_enable_adc(adc, JZ_ADC_ENABLE_ADCIN);
>> +
>> +	t = wait_for_completion_interruptible_timeout(&adc->adc_completion,
>> +							HZ);
>> +
>> +	jz4740_adc_disable_irq(adc, JZ_ADC_IRQ_ADCIN);
>> +
>> +	if (t <= 0) {
>> +		jz4740_adc_disable_adc(adc, JZ_ADC_ENABLE_ADCIN);
>> +		return t ? t : -ETIMEDOUT;
>> +	}
>> +
>> +	val = readw(adc->base + JZ_REG_ADC_ADCIN);
>> +	jz4740_adc_clk_disable(adc);
>> +
>>     
> Does this device really use units of milivolts? (standard in hwmon).
> I couldn't confirm either way via quick googling.
>   
Hm, right, it does not. Interestingly the datasheet does not tell the
unit of the returned data, but I found a formula in the datasheet for a
similar SoC.
>> +	return sprintf(buf, "%d\n", val);
>> +}
>> +
>> + [...]
>>     
Thanks for reviewing the patch.

- Lars
