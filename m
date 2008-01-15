Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 16:14:41 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:2468 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20037338AbYAOQO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 16:14:28 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 87BE348916;
	Tue, 15 Jan 2008 17:14:22 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JEoRF-0004VO-ML; Tue, 15 Jan 2008 16:14:57 +0000
Date:	Tue, 15 Jan 2008 16:14:57 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080115161457.GB31107@networkno.de>
References: <477E7DAE.2080005@raritan.com> <20080106.000725.75184768.anemo@mba.ocn.ne.jp> <4787AC3D.2020604@raritan.com> <20080112.211749.25909440.anemo@mba.ocn.ne.jp> <478CD639.3040307@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478CD639.3040307@raritan.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gregor Waltz wrote:
> Atsushi Nemoto wrote:
>> On Fri, 11 Jan 2008 12:49:49 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
>>   
>>> I built linux-2.6.23.9 with the above, but the results are still the  
>>> same and the EPC is not in System.map.
>>>     
>>
>> Are you searching the exact EPC value in System.map?
>> Usually you should find a function symbol which contains the EPC value in it.
>>
>> Or you can do "mipsel-linux-objdump -d vmlinux" and search the EPC value.
>>   
>
>
> The current error is:
> Exception! EPC=80026290 CAUSE=00000020(Sys)
> 80026290 0000000c syscall
>
> 80026290 is not in System.map, however, the objdump is much more  
> informative and does contain that value. That particular syscall is in:
>
> 8002628c <kernel_execve>:
> 8002628c:       24020fab        li      v0,4011
> 80026290:       0000000c        syscall
> 80026294:       00401821        move    v1,v0
> 80026298:       14e00003        bnez    a3,800262a8 <kernel_execve+0x1c>
> 8002629c:       00000000        nop
> 800262a0:       03e00008        jr      ra
> 800262a4:       00601021        move    v0,v1
> 800262a8:       03e00008        jr      ra
> 800262ac:       00031023        negu    v0,v1
>
> Does that provide any clues?

The kernel failed to set up the general exception handler correctly.
It should have done that before attempting to start the first kernel
thread.


Thiemo
