Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 16:45:20 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:4328 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021935AbXDRPpS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 16:45:18 +0100
Received: (qmail 22252 invoked by uid 507); 18 Apr 2007 23:47:37 +0800
Received: from unknown (HELO ?192.168.1.7?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 18 Apr 2007 23:47:37 +0800
Message-ID: <46263CA5.9080908@ict.ac.cn>
Date:	Wed, 18 Apr 2007 23:43:33 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	"Uhler, Mike" <uhler@mips.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, tiansm@lemote.com,
	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <20070418120620.GE3938@linux-mips.org> <46261DE2.5040908@ict.ac.cn> <692AB3595F5D76428B34B9BEFE20BC1FC1D723@Exchange.mips.com>
In-Reply-To: <692AB3595F5D76428B34B9BEFE20BC1FC1D723@Exchange.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Uhler, Mike wrote:
>> Yes. Most 64bit MIPS processors cannot access 64bit content 
>> of registers when it is in 32bit mode.
>>     
>
> For clarity, there is no 32/64-bit mode in MIPS processors.  There is a
> mode in which 64-bit OPERATIONS are enabled (that is, those instructions
> which operate on the full width of the registers) - See the definition
> of 64-bit Operations Enable in the MIPS64 Architecture for Programmers,
> volume III.  Note that such operations are always enabled while the
> processor is running in Kernel Mode.
>
> The patch is a little short on context, but if you've got a 64-bit
> kernel, I had always assumed that save/restore of context is always done
> with LD/SD, not by figuring out whether a process has 64-bit operations
> enabled, then doing a conditional LD/SD or LW/SW.
>
>   
This patch for 32bit kernel. We want to save/restore 64bit register 
content because the high 32bit of register might be used by multimedia 
programs for loongson processor, such as mplayer.

> /gmu
> ---
> Michael Uhler, Chief Technology Officer
> MIPS Technologies, Inc.   Email: uhler AT mips.com
> 1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
> Mountain View, CA 94043
>    
>
>   
>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org 
>> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Fuxin Zhang
>> Sent: Wednesday, April 18, 2007 6:32 AM
>> To: Ralf Baechle
>> Cc: tiansm@lemote.com; linux-mips@linux-mips.org; Fuxin Zhang
>> Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
>>
>>
>>     
>>>> +
>>>>     
>>>>         
>>> Is there anything in implementation of this option 
>>>       
>> Loongson2-specific?
>>     
>>>   
>>>       
>> Yes. Most 64bit MIPS processors cannot access 64bit content 
>> of registers when it is in 32bit mode.
>>
>> Loongson2 has no 32/64 mode bit in fact.
>>
>> And the usage arise from Loongson2's multimedia extension, 
>> which is also uniq.
>>     
>>> If not then I suggest we make this option loook like:
>>>
>>>    bool "Save 64bit integer registers" if 
>>>       
>> CPU_SUPPORTS_64BIT_KERNEL && 
>>     
>>> 32BIT
>>>
>>> Somebody else might have a use for it!
>>>
>>>   Ralf
>>>
>>>
>>>
>>>
>>>   
>>>       
>>     
>
>
>
>
>   
