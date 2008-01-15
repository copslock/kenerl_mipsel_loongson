Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 15:50:39 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:8996 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20037268AbYAOPub (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 15:50:31 +0000
Received: from [192.168.32.206] ([192.168.32.206]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 Jan 2008 10:50:24 -0500
Message-ID: <478CD639.3040307@raritan.com>
Date:	Tue, 15 Jan 2008 10:50:17 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
CC:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E7DAE.2080005@raritan.com>	<20080106.000725.75184768.anemo@mba.ocn.ne.jp>	<4787AC3D.2020604@raritan.com> <20080112.211749.25909440.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080112.211749.25909440.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 15:50:25.0074 (UTC) FILETIME=[57D70120:01C8578E]
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 11 Jan 2008 12:49:49 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
>   
>> I built linux-2.6.23.9 with the above, but the results are still the 
>> same and the EPC is not in System.map.
>>     
>
> Are you searching the exact EPC value in System.map?
> Usually you should find a function symbol which contains the EPC value in it.
>
> Or you can do "mipsel-linux-objdump -d vmlinux" and search the EPC value.
>   


The current error is:
Exception! EPC=80026290 CAUSE=00000020(Sys)
80026290 0000000c syscall

80026290 is not in System.map, however, the objdump is much more 
informative and does contain that value. That particular syscall is in:

8002628c <kernel_execve>:
8002628c:       24020fab        li      v0,4011
80026290:       0000000c        syscall
80026294:       00401821        move    v1,v0
80026298:       14e00003        bnez    a3,800262a8 <kernel_execve+0x1c>
8002629c:       00000000        nop
800262a0:       03e00008        jr      ra
800262a4:       00601021        move    v0,v1
800262a8:       03e00008        jr      ra
800262ac:       00031023        negu    v0,v1

Does that provide any clues?
I have to go now. I will take another look when I return, but I have 
looked at kernel_execve before.

Thanks
