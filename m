Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 15:39:51 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:27689 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225528AbVAJPjr>;
	Mon, 10 Jan 2005 15:39:47 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AFdj416045;
	Mon, 10 Jan 2005 16:39:45 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0AFdji10820;
	Mon, 10 Jan 2005 16:39:45 +0100
Message-ID: <41E2A1C1.4010709@schenk.isar.de>
Date: Mon, 10 Jan 2005 16:39:45 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
References: <20041223202526.GA2254@deprecation.cyrius.com> <20041224040051.93587.qmail@web52806.mail.yahoo.com> <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de> <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de> <41E27A6A.5060204@schenk.isar.de> <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de> <20050110143535.GE15344@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20050110143535.GE15344@rembrandt.csv.ica.uni-stuttgart.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Thiemo Seufer wrote:
> 
>>Rojhalat Ibrahim wrote:
>>
>>>Thiemo Seufer wrote:
>>>
>>>>I updated the patch now and checked it in. Please test, especially
>>>>for cases I couldn't do, like R3000-style TLB handling and MIPS32
>>>>CPUs with 64bit physaddr.
>>>>
>>>
>>>My Yosemite board (RM9000 processor) does not boot anymore with
>>>CONFIG_64BIT_PHYS_ADDR. Without that option it seems to be working
>>>as before. I tried to define cpu_has_64bit_gp_regs.
>>
>>Correct, this should always be defined for 64bit capable CPUs.
>>
>>
>>>With that it boots partly.
>>
>>Where does it fail?
> 
> 
> It's probably caused by the bug I just found. Please try the appended
> patch and tell me if it changes something for you.
> 
> 
Thanks, but I had already found that one. Sorry, I forgot to
mention it. Doesn't change a thing, except that I can compile
the kernel without errors.
