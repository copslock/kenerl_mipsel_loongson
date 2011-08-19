Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 23:27:24 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.9]:36553 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492163Ab1HSV1R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 23:27:17 +0200
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p7JLQ8fq021664;
        Fri, 19 Aug 2011 16:26:21 -0500
Received: from [IPv6:::1] (147.117.20.214) by smtps-am.internal.ericsson.com
 (147.117.20.31) with Microsoft SMTP Server (TLS) id 8.3.137.0; Fri, 19 Aug
 2011 17:26:14 -0400
Message-ID: <4E4ED4F5.2050002@ericsson.com>
Date:   Fri, 19 Aug 2011 14:26:13 -0700
From:   Jason Kwon <jason.kwon@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     David Daney <david.daney@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Octeon: Select CONFIG_HOLES_IN_ZONE
References: <1313779440-12522-1-git-send-email-david.daney@cavium.com> <1313781191.3235.96.camel@groeck-laptop>
In-Reply-To: <1313781191.3235.96.camel@groeck-laptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.kwon@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14738

On 08/19/2011 12:13 PM, Guenter Roeck wrote:
> On Fri, 2011-08-19 at 14:44 -0400, David Daney wrote:
>> Current Octeon systems do in fact have holes in their memory zones.
>> We need to select HOLES_IN_ZONE.  If we do not, some memory
>> configurations will result in crashes at boot time like this:
>>
>> .
>> .
>> .
>> CPU 6 Unable to handle kernel paging request at virtual address 0000000000700000, epc == ffffffff8118fe00, ra == ffffffff8118fe9c
>> Oops[#1]:
>> Cpu 6
>> .
>> .
>> .
>>          ...
>> Call Trace:
>> [<ffffffff8118fe00>] setup_per_zone_wmarks+0x1b0/0x338
>> [<ffffffff815cd738>] init_per_zone_wmark_min+0x64/0xd0
>> [<ffffffff81100438>] do_one_initcall+0x38/0x160
>> .
>> .
>> .
>>
>> Reported-by: Jason Kwon<jason.kwon@ericsson.com>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> Cc: Jason Kwon<jason.kwon@ericsson.com>
>> ---
>> Jason, can you test this patch?
>>
>> Ralf, if Jason reports that it fixes his problem, it probably is
>> needed for 3.0 and 3.1.
>>
> Your patch fixes the problem for the board with CN38xx and 2GB RAM that
> crashed previously.
>
> Tested-by: Guenter Roeck<guenter.roeck@ericsson.com>
>
> Thanks a lot for looking into this.
>
> Guenter
>
>

I applied the patch to 3.0.3 and was able to boot the CN58XX system 
without any memory restrictions.  The same patched kernel booted on 
CN38XX ran into a different problem, which I'm looking into.

Thanks,

Jason
