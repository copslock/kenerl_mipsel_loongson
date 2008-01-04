Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 19:23:23 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:54926 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20025505AbYADTXN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Jan 2008 19:23:13 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 7071048905;
	Fri,  4 Jan 2008 20:23:07 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JAs8M-0004le-4P; Fri, 04 Jan 2008 19:23:10 +0000
Date:	Fri, 4 Jan 2008 19:23:10 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080104192310.GE22809@networkno.de>
References: <477E6296.7090605@raritan.com> <20080104172136.GD22809@networkno.de> <477E7DAE.2080005@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477E7DAE.2080005@raritan.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gregor Waltz wrote:
> Thiemo Seufer wrote:
>> Gregor Waltz wrote:
>>   
>>> I have been working on a JMR 3927 based system for a number of years. For 
>>> all of that time, we have been running:
>>> binutils 2.11.90.0.1
>>> gcc 2.95.3
>>> glibc 2.2.1
>>> linux 2.4.12
>>>
>>>
>>> We want to update to a 2.6 kernel, recent build tools, and saner system 
>>> libraries. Although, it seems that the JMR 3927 is still technically 
>>> supported, I have not found any info on whether anybody is still running 
>>> Linux on it and what combination of software they are using. Any idea?
>>> Is there a combination of software versions that are known to work on 
>>> this hardware?
>>>
>>>
>>> I have used crosstool 0.43 to build:
>>> binutils 2.15
>>> gcc 3.4.5
>>> glibc 2.3.6
>>>     
>>
>> http://www.linux-mips.org/wiki/Toolchains recommends binutils 2.16.1 and
>> gcc 3.4.4, but I believe your choice is also ok for 32-bit systems.
>>   
>
> I will try that combination also.
>
>> Hard to tell from so little information, it would help to see the whole
>> boot log.
>>
>>
>> Thiemo
> I wish that there were more of a boot log of which to speak. The following 
> is a complete boot log:
>
> Serial Number = WAC6200032
> MAC Address 1= 00:0D:5D:00:eb:6f
> Kernel Image Length = 0x695000, CRC = 0xd2ee6a23
>
> Loading Linux ......
> Downloading from ethernet, ^C to abort and restart pmonitor
> sendRRQ vmlinux.bin
> load linux length 0x34408a
> Checking CRC on downloaded RAM image
> /
> CRC Check passed
> Image Started At Address 0x80020000.
> Image Length = 3424394 (0x34408a).
> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc

Hm, your start address is 0x80020000, but the load address of the jmr3927
(in the www.linux-mips.org tree) is 0x80050000. So maybe the address is
wrong, comparing with the old 2.4 kernel should tell.

> All messages before the exception are from PMON. I am booting via TFTP. I 
> also tried writing the kernel to flash and booting from that, but that 
> fails identically.
> I checked the other serial port on the device, but it is not showing any 
> kernel messages either. The normal boot console is ttyS1. I tried setting 
> the kernel parameters and the default parameters (from the kernel build 
> config) to "console=ttyS1", but that made no difference. Regardless, I 
> would think that the kernel knows where to send messages because I am 
> seeing the exception dump on ttyS1.
> Further, the exception gets printed immediately after "Image Length = 
> 3424394 (0x34408a)." The exception happens so soon that I doubt that the 
> kernel does very much beforehand.

True, it fails early, before it can take over the exception handlers.


Thiemo
