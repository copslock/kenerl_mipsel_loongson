Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 04:57:34 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:41588 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490981Ab0EQC5b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 May 2010 04:57:31 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o4H2vKdd024444;
        Sun, 16 May 2010 19:57:23 -0700 (PDT)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Sun, 16 May 2010 19:57:20 -0700
Message-ID: <4BF0B08F.1010305@windriver.com>
Date:   Mon, 17 May 2010 10:57:19 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [Bug report] Got bus error when loading kernel module on SB1250
 Rev B2 board with 64 bit kernel
References: <4BED25F3.4010809@windriver.com> <20100514180211.GB32203@linux-mips.org>
In-Reply-To: <20100514180211.GB32203@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 May 2010 02:57:20.0363 (UTC) FILETIME=[AAC28BB0:01CAF56C]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle 写道:
> On Fri, May 14, 2010 at 06:29:07PM +0800, Yang Shi wrote:
>
>   
>> I'm running 2.6.34-rc7 mainline kernel on SB1250 (Rev B2) board. And, I
>> use the default sb1250 kernel config (sb1250-swarm_defconfig). So, 64
>> bit kernel is used. During kernel loading module got bus error, see
>> below log:
>>     
>
> Whops.  Fixes which were supposed to handle exactly this problem went
> upstream for 2.6.34-rc3 and were tested successfully by others on their
> systems.
>
> I wonder if in arch/mips/sibyte/sb1250/setup.c you can instrument
> the function sb1250_m3_workaround_needed() and print the values of
> soc_type, soc_pass and the retun value of that function.  Then let's take
> it from there.
>   

See below log:

Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)

And, soc_typs is 0x0 and soc_pass is 0x11, sb1250_m3_workaround_needed 
should return 1. So, tlb refill handler should go the m3 workaround code 
path.

Thanks,
Yang

>   Ralf
>
>   
