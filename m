Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 01:41:51 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:31618 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20026372AbXHHAlm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Aug 2007 01:41:42 +0100
Received: (qmail 8318 invoked by uid 511); 8 Aug 2007 00:47:15 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 8 Aug 2007 00:47:15 -0000
Message-ID: <46B910EE.2010905@lemote.com>
Date:	Wed, 08 Aug 2007 08:40:14 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	jiankemeng@gmail.com, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org, tiwai@suse.de, greg@kroah.com,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] ALSA on MIPS platform
References: <46B332AC.8020403@lemote.com>	<5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>	<5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com> <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
>   
>>  static inline unsigned long virt_to_phys(volatile const void *address)
>>  {
>> -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
>> +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
>>  }
>>     
>
> This makes virt_to_phys() a bit slower, and more importantly, breaks
> 64-bit kernel.
>   

I have tried this way, and disassemble result show 32-bit kernel add 
only one instruction.
But I don't really insist on this patch, for it doesn't resolve some 
driver code requirement.
> ---
> Atsushi Nemoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   
