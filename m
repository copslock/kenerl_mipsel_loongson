Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 19:27:12 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:64255 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab1BJS1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 19:27:09 +0100
Received: by bwz5 with SMTP id 5so2246801bwz.36
        for <linux-mips@linux-mips.org>; Thu, 10 Feb 2011 10:27:04 -0800 (PST)
Received: by 10.204.102.19 with SMTP id e19mr14519203bko.35.1297362423959;
        Thu, 10 Feb 2011 10:27:03 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id u23sm208798bkw.21.2011.02.10.10.27.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 10:27:02 -0800 (PST)
Message-ID: <4D542DA1.5020705@mvista.com>
Date:   Thu, 10 Feb 2011 21:25:37 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: DB1200: Set Config_OD for improved stability.
References: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com> <1297347429-18215-2-git-send-email-manuel.lauss@googlemail.com> <4D542B1D.1060407@mvista.com>
In-Reply-To: <4D542B1D.1060407@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

I wrote:

>> Setting Config_OD gets rid of a _LOT_ of spurious CPLD interrupts,
>> but also decreases overall performance a bit.

>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> [...]

>> diff --git a/arch/mips/alchemy/devboards/db1200/setup.c 
>> b/arch/mips/alchemy/devboards/db1200/setup.c
>> index 8876195..a3729c9 100644
>> --- a/arch/mips/alchemy/devboards/db1200/setup.c
>> +++ b/arch/mips/alchemy/devboards/db1200/setup.c
>> @@ -23,6 +23,13 @@ void __init board_setup(void)
>>      unsigned long freq0, clksrc, div, pfc;
>>      unsigned short whoami;
>>  
>> +    /* Set Config_OD (disable overlapping bus transaction):

>    The bit is called Config[OD] by other Alchemy code.
>    You just should add your Au1200 revision to 
> au1xxx_cpu_needs_config_od() in <asm/mach-au1x00.h> so that 
> plat_mem_setup() automatically sets the bit (just after it calls 
> board_setup()); Au1200 rev. AC should have it set already...

    Forgot to add that if you don't do it, the code in plat_mem_setup() will 
clear the bit after you've set it.

WBR, Sergei
