Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 08:38:58 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:6892 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022449AbXDPHi5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 08:38:57 +0100
Received: (qmail 4170 invoked by uid 511); 16 Apr 2007 07:39:49 -0000
Received: from unknown (HELO ?192.168.2.197?) (192.168.2.197)
  by lemote.com with SMTP; 16 Apr 2007 07:39:49 -0000
Message-ID: <462327C3.4020905@lemote.com>
Date:	Mon, 16 Apr 2007 15:37:39 +0800
From:	Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de>
In-Reply-To: <20070415222847.GA1402@networkno.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> tiansm@lemote.com wrote:
> [snip]
>   
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index 92bca6a..2a6742d 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
>> @@ -118,6 +118,7 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
>>  cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
>>  cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
>>  cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
>> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
>>     
>
> I wonder why this is r4600. I heard the Loongson2 is MIPS IV compatible,
> so r5000 / r8000 / r10000 would be better choices.
>
>
> Thiemo
>
>   
I check the datasheet I have and i don't see loongson2e has implemented 
mips iv instructions.

Songmao
