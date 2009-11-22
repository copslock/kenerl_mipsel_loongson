Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 12:51:57 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:61008 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1492318AbZKVLvu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 12:51:50 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 213793ECA; Sun, 22 Nov 2009 03:51:38 -0800 (PST)
Message-ID: <4B0925BD.6070507@ru.mvista.com>
Date:	Sun, 22 Nov 2009 14:51:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com> <20091122081328.GB24558@elte.hu>
In-Reply-To: <20091122081328.GB24558@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ingo Molnar wrote:

>> +config HR_SCHED_CLOCK
>> +	bool "High Resolution sched_clock()"
>> +	depends on CSRC_R4K
>> +	default n
>> +	help
>> +	  This option enables the MIPS c0 count based high resolution
>> +	  sched_clock().
>> +
>> +	  If you need a ns precision timestamp, You are recommended to enable
>> +	  this option. For example, If you are using the Ftrace subsystem to do
>>     

   s/If/if/

>> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
>> index e95a3cd..4e52cca 100644
>> --- a/arch/mips/kernel/csrc-r4k.c
>> +++ b/arch/mips/kernel/csrc-r4k.c
>> @@ -6,10 +6,64 @@
>>   * Copyright (C) 2007 by Ralf Baechle
>>   */
>>  #include <linux/clocksource.h>
>> +#include <linux/cnt32_to_63.h>
>> +#include <linux/timer.h>
>>  #include <linux/init.h>
>>  
>>  #include <asm/time.h>
>>  
>> +/*
>> + * MIPS' sched_clock implementation.
>>     
>
> s/MIPS'/MIPS's
>   

   MIPS's is not really a proper English. :-)

WBR, Sergei
