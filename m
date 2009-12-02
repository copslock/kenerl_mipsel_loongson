Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 18:47:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10088 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493472AbZLBRrw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 18:47:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b16a83c0001>; Wed, 02 Dec 2009 09:47:42 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 2 Dec 2009 09:45:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 2 Dec 2009 09:45:50 -0800
Message-ID: <4B16A7CC.3090305@caviumnetworks.com>
Date:   Wed, 02 Dec 2009 09:45:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ales Mulej <Ales.Mulej@HSTX.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Reserved instruction in kernel code
References: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn>
In-Reply-To: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2009 17:45:50.0331 (UTC) FILETIME=[49679CB0:01CA7377]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ales Mulej wrote:
> Hi,
> 
>  
> 
> I'm porting linux(2.6.31.6) to the Wintegra WINHDP2 refrence board.
> 
> As a refrence I already have an old BSP from Wintegra based on kernel 
> 2.6.10.
> 
>  
> 
> During the kernel start up process I receive following error:
> 
>  
> 
> Reserved instruction in kernel code[#1]:
> 
> Cpu 0
> 
> $ 0   : 00000000 1000fc00 802be630 00000001
> 
> $ 4   : 802be670 802be674 ffffffff 802f4d4c
> 
> $ 8   : 1000fc01 1000001f 00000001 0000002b
> 
> $12   : 00000000 000001f5 07a0d380 00000000
> 
> $16   : 00000000 00000000 00000000 1000fc00
> 
> $20   : 802e9674 bd030f04 3e490000 00000a72
> 
> $24   : 00000008 8000167c                 
> 
> $28   : 802ba000 802bbd30 ffffffff 802f4d4c
> 
> Hi    : 000000fb
> 
> Lo    : 00000001
> 
> epc   : 801013a0 handle_ri_int+0x18/0x38
> 
>     Not tainted
> 
> ra    : 802f4d4c __log_buf+0x0/0x20000
> 
> Status: 1000fc03    KERNEL EXL IE
> 
> Cause : 50808000
> 
> PrId  : 00019365 (MIPS 24Kc)
> 
> Modules linked in:
> 
> Process swapper (pid: 0, threadinfo=802ba000, task=802bc000, tls=00000000)
> 
> Stack : 1000fc00 1000001f 00000001 0000002b 00000000 000001f5 00000000 
> 1000fc00
> 
>         802be630 00000001 802be670 802be674 ffffffff 802f4d4c 1000fc00 
> 1000001f
> 
>         00000001 0000002b 00000000 000001f5 07a0d380 00000000 00000000 
> 00000000
> 
>         00000000 1000fc00 802e9674 bd030f04 3e490000 00000a72 00000008 
> 8000167c
> 
>         802bbe94 802a2954 802ba000 802bbde0 ffffffff 802f4d4c 1000fc02 
> 000000fb
> 
>         ...
> 
> Call Trace:
> 
> [<801013a0>] handle_ri_int+0x18/0x38
> 
>  
> 
>  
> 
> Code: 01094025  3908001e  40886000 <00000040> 00000040  00000040  

       ...   ssnop ssnop ssnop ...

One would think a 'PrId  : 00019365 (MIPS 24Kc)' would execute those.

The cause value indicates an 'Interrupt' but you are somehow executing 
in handle_ri_int, so it could be that multiple exceptions are messing up 
the OOPS output...



> 
> Disabling lock debugging due to kernel taint
> 
> Kernel panic - not syncing: Attempted to kill the idle task!
> 
>  
> 
>  
> 
> Does anybody know where is the problem?
> 
> I suspect, that the problem is in my interrupt routine, because I 
> receive this error as soon as the tick timer start's up.
> 
>  
> 
> Regards,
> 
> Ales
> 
>  
> 
>  
> 
>  
> 
