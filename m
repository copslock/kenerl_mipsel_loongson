Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2004 07:55:31 +0000 (GMT)
Received: from pimout2-ext.prodigy.net ([IPv6:::ffff:207.115.63.101]:28821
	"EHLO pimout2-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8224929AbUKYHz0>; Thu, 25 Nov 2004 07:55:26 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iAP7tFL6064566
	for <linux-mips@linux-mips.org>; Thu, 25 Nov 2004 02:55:20 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Wed, 24 Nov 2004 23:55:09 -0800
Message-ID: <41A58FD2.1020100@embeddedalley.com>
Date: Wed, 24 Nov 2004 23:54:58 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: linux-mips@linux-mips.org
Subject: Re: =?windows-1255?Q?=FA=F9=E5=E1=E4=3A_=FA=F9=E5=E1=E4=3A_A?=
 =?windows-1255?Q?u1500_Chip_Select?=
References: <20041125073158.98A11EB2A9@mail.romat.com>
In-Reply-To: <20041125073158.98A11EB2A9@mail.romat.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=windows-1255; format=flowed
Content-Transfer-Encoding: 8bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gilad Rom wrote:
> The device is a simple ALTERA chip, used for testing (for the mean time).
> I need to make sure that I can access it, and simply read data from it.
> Here's my question: Let's say I assign 0x1000 as the address portion (CSBA)
> Of MEM_STADDR1. What address should I mmap after that?

I don't have the spec in front of me. It's whatever 0x1000 in the CS 
translates to as the physical address.

Pete

> (Using mmap only for initial development, Once I realize all I need
> To do I'll write a driver).
> 
> Thanks,
> Gilad.
> 
> -----הודעה מקורית-----
> מאת: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] בשם Pete Popov
> נשלח: Thursday, November 25, 2004 9:23 AM
> אל: Gilad Rom
> עותק: linux-mips@linux-mips.org
> נושא: Re: תשובה: Au1500 Chip Select
> 
> Gilad Rom wrote:
> 
>>Well, what I did so far was setup mem_stcfg1/mem_staddr1. 
>>What I'm having trouble with is, what values do I need to Set in 
>>mem_staddr1,
> 
> 
> Depends on the device attached to that CS and the physical address you want
> to assign to it.
> 
> 
>>and then, how do I access
>>That memory (mmap? Driver?).
> 
> 
> Driver would be better.
> 
> Pete
> 
> 
>>Thanks.
>>Gilad.
>>
>>-----הודעה מקורית-----
>>מאת: linux-mips-bounce@linux-mips.org
>>[mailto:linux-mips-bounce@linux-mips.org] בשם Pete Popov
>>נשלח: Wednesday, November 24, 2004 7:58 PM
>>אל: Gilad Rom
>>עותק: linux-mips@linux-mips.org
>>נושא: Re: Au1500 Chip Select
>>
>>Gilad Rom wrote:
>>
>>
>>
>>>Hello,
>>>
>>>I am trying to implement a simple program which Will be used to 
>>>communicate with an I/O peripheral Over CS1 (Chip select 1) of the 
>>>au1500.
>>
>>
>>I'm not sure I understand what you're trying to do. The chip select is 
>>setup by the boot loader or kernel, and you don't touch it anymore. 
>>The CS will get asserted/deasserted based on the addresses you're trying
> 
> to access.
> 
>>
>>>Has anyone ever attempted this? Could someone Point me to some sample 
>>>code, perhaps? I am grepping Through the kernel, yet having trouble 
>>>locating Chip-select specific code for reference.
>>
>>
>>Again, what sort of an example are you looking for?  Setting up a chip 
>>select on the Au1x is nothing more than writing the appropriate values 
>>to the 3 chip select registers. Then you're done.
>>
>>Pete
>>
>>
>>
>>
> 
> 
> 
> 
> 
> 
