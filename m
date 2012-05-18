Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2012 10:10:58 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:56233 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901167Ab2ERIKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2012 10:10:54 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4I8AjrZ027736;
        Fri, 18 May 2012 01:10:46 -0700
Received: from [192.168.225.107] (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Fri, 18 May 2012
 01:10:44 -0700
Message-ID: <4FB60403.3080700@mips.com>
Date:   Fri, 18 May 2012 16:10:43 +0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     <linux-mips@linux-mips.org>, <kevink@paralogos.com>
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org>
In-Reply-To: <4FB4EF81.10005@phrozen.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: DAk8ppKWbboHVstxt0FKKw==
X-archive-position: 33362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Thanks for reviewing the code.


On 05/17/2012 08:30 PM, John Crispin wrote:
> Hi,
>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index ce30e2f..8205afe 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -1925,7 +1925,7 @@ config MIPS_MT_FPAFF
>>
>>   config MIPS_VPE_LOADER
>>   	bool "VPE loader support."
>> -	depends on SYS_SUPPORTS_MULTITHREADING
>> +	depends on SYS_SUPPORTS_MULTITHREADING&&  MIPS_MALTA
>
> This would lead to the second user of the API having to patch this piece
> of code to make it work.
>
> You could introduce a ARCH_HAS_APRP which any platform can then select ?

Hmm... This is a good idea. Maybe the name could be SYS_SUPPORTS_APRP?

> I think it would also make sense to split changes to generic and malta
> code into separate patches if that is possible.

Yes, that's possible. Will do it in the next version.


Regards,

Deng-Cheng
