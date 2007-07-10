Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 02:26:19 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:28288 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20023546AbXGJB0R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2007 02:26:17 +0100
Received: (qmail 12805 invoked by uid 511); 10 Jul 2007 01:29:35 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 10 Jul 2007 01:29:35 -0000
Message-ID: <4692E018.60701@lemote.com>
Date:	Tue, 10 Jul 2007 09:25:44 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fulong PCI updates
References: <11838701474147-git-send-email-tiansm@lemote.com> <20070709134104.GA14536@linux-mips.org>
In-Reply-To: <20070709134104.GA14536@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Jul 08, 2007 at 12:49:07PM +0800, tiansm@lemote.com wrote:
>   
>> diff --git a/include/asm-mips/mips-boards/bonito64.h b/include/asm-mips/mips-boards/bonito64.h
>> index cd71256..dc3fc32 100644
>> --- a/include/asm-mips/mips-boards/bonito64.h
>> +++ b/include/asm-mips/mips-boards/bonito64.h
>> @@ -26,7 +26,12 @@
>>  /* offsets from base register */
>>  #define BONITO(x)	(x)
>>
>> -#else /* !__ASSEMBLY__ */
>> +#elif defined(CONFIG_LEMOTE_FULONG)
>> +
>> +#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
>> +#define BONITO_IRQ_BASE   32
>> +
>> +#else
>>
>>  /*
>>   * Algorithmics Bonito64 system controller register base.
>>     
>
> Okay, I've folded that into the existing Fulong patch in the -queue tree
> and that'll also be the last thing I do on the -queue tree before merging
> it into the main tree rsp. to Linus.
>
> Note that the "mips-boards" in the filename was meant to mean
> boards of MTI, so that mips-boards file would rather be moved around than
> included via unobvious pathes that will eventually lead to breakage when
> we change code for mips-boards/bonito64.h but I guess we can fix that
> later.
>
>   Ralf
>
>
>   

Thanks:)
