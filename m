Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:19:29 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:6088 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22791067AbYJaGnT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 06:43:19 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9V6h8KI012783;
	Thu, 30 Oct 2008 23:43:08 -0700 (PDT)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Oct 2008 23:43:07 -0700
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 31 Oct 2008 07:43:04 +0100
Message-ID: <490AA937.3050505@windriver.com>
Date:	Fri, 31 Oct 2008 14:44:07 +0800
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
X-OriginalArrivalTime: 31 Oct 2008 06:43:05.0121 (UTC) FILETIME=[ED7F5910:01C93B23]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21138
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

Good idea and done.

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

I generated another patch to your separate email temporarily. I'll cc here after
you confirm if the file head is valid.

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

Ohh... I guess we'd better use this to track something once this macro may be
changed in the future.

Best Regards
Tiejun

> Can you fix that?
> 
>   Ralf
> 
