Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 01:18:09 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:15834 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S23916756AbYKZBR6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 01:17:58 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAQ1Hh5X001644;
	Tue, 25 Nov 2008 17:17:48 -0800 (PST)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Nov 2008 17:17:43 -0800
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 26 Nov 2008 02:17:40 +0100
Message-ID: <492CA410.70202@windriver.com>
Date:	Wed, 26 Nov 2008 09:19:12 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Support RTC on Malta
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com> <20081030120510.GH26256@linux-mips.org>
In-Reply-To: <20081030120510.GH26256@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2008 01:17:40.0542 (UTC) FILETIME=[C6AE85E0:01C94F64]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 30, 2008 at 07:15:44PM +0800, Tiejun Chen wrote:
> 
> Looks reasonable but I have a few comments:
> 
>> diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
>> index cef2db8..26284fc 100644
>> --- a/arch/mips/mti-malta/Makefile
>> +++ b/arch/mips/mti-malta/Makefile
>> @@ -9,7 +9,7 @@ obj-y				:= malta-amon.o malta-cmdline.o \
>>  				   malta-display.o malta-init.o malta-int.o \
>>  				   malta-memory.o malta-mtd.o \
>>  				   malta-platform.o malta-reset.o \
>> -				   malta-setup.o malta-time.o
>> +				   malta-setup.o malta-time.o malta-rtc.o
> 
> Could you please fold malta-rtc.c into the existing malta-platform.c instead
> of creating a new file?
> 
>> +++ b/arch/mips/mti-malta/malta-rtc.c
>> @@ -0,0 +1,73 @@
> 
>> +	struct platform_device *pdev;
>> +	int ret;
>> +
>> +	pdev = platform_device_alloc("rtc_cmos", -1);
>> +	if (!pdev)
>> +		return -ENOMEM;
>> +
>> +	ret = platform_device_add_resources(pdev, malta_platform_rtc_resource,
>> +	                                       ARRAY_SIZE(malta_platform_rtc_resource));
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = platform_device_add(pdev);
>> +	if (ret)
>> +		goto err;
> 
> You can simplify this a bit by using a static struct platform_device like:
> 
> static struct platform_device rtc_device = {
>         .name                   = "rtc_cmos",
>         .id                     = -1,
> 	.resource		= &malta_platform_rtc_resource,
> 	.num_resources		= ARRAY_SIZE(malta_platform_rtc_resource),
> };
> 
>> +
>> +	/* Try setting rtc as BCD mode to support
>> +	 * current alarm code if possible.
>> +	 */
>> +	if (!RTC_ALWAYS_BCD)
>> +		CMOS_WRITE(CMOS_READ(RTC_CONTROL) & ~RTC_DM_BINARY, RTC_CONTROL);
> 
> RTC_ALWAYS_BCD is 0, so the if condition is always true and the if can be
> eleminated.
> 
> Can you fix that?
> 

Ralf,

I already re-sended another patch, [PATCH v2] Support RTC on Malta.

Best Regards
Tiejun
>   Ralf
> 
