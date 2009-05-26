Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 03:31:25 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:57884 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023822AbZEZCbR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 03:31:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id D58D9340A3;
	Tue, 26 May 2009 10:26:05 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bcxa1bXROc6i; Tue, 26 May 2009 10:25:51 +0800 (CST)
Received: from localhost.localdomain (unknown [172.16.2.66])
	by lemote.com (Postfix) with ESMTP id 9BBAA340AD;
	Tue, 26 May 2009 10:25:50 +0800 (CST)
Message-ID: <4A1B53A3.6060503@lemote.com>
Date:	Tue, 26 May 2009 10:27:47 +0800
From:	Hongbing Hu <huhb@lemote.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	yanh@lemote.com
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, wuzhangjin@gmail.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org, philippe@cowpig.ca,
	r0bertz@gentoo.org, zhangfx@lemote.com, apatard@mandriva.com,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	hofrat@hofr.at, liujl@lemote.com, erwan@thiscow.com
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
References: <817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>	 <20090522.220123.59650403.anemo@mba.ocn.ne.jp>	 <1243066003.8509.60.camel@localhost.localdomain>	 <20090523.213045.39168996.anemo@mba.ocn.ne.jp> <1243302188.9819.58.camel@localhost.localdomain>
In-Reply-To: <1243302188.9819.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <huhb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huhb@lemote.com
Precedence: bulk
X-list: linux-mips

yanh 写道:
> 在 2009-05-23六的 21:30 +0900，Atsushi Nemoto写道：
>   
>> On Sat, 23 May 2009 16:06:43 +0800, yanh <yanh@lemote.com> wrote:
>>     
>>>>> +unsigned long
>>>>> +	saved_ra,
>>>>> +	saved_sp,
>>>>>           
>> ...
>>     
>>>>> +	saved_v0,
>>>>> +	saved_v1;
>>>>>           
>>>> Instead of enumerating them, I would prefer something like "struct
>>>> pt_regs saved_regs" or "unsigned long saved_regs[32]".
>>>>         
>>> This implementation is referencing the x86 platform. 
>>> Not all the 32 reigsters are needed to save. 
>>> Maybe the whole registers needed to save can still be reduced.
>>>       
>> I did not mean save/restore all registers.  I just mean using only one
>> symbol (struct or array).  Though the struct or array contains some
>> unused members, it saves many instructions in
>> swsusp_arch_{suspend,resume}.
>>
>> For saving N registers, (N * 2) instructions are required to save to
>> individual variables, but (N + 2) instructions are required to save to
>> array or struct.
>>     
>
> Yes, the struct array method is more efficient, we will change to it.
>   
The length of registers  is different between  32bit kernel  and  64bit 
kernel.
That means the file hibernate.S wiil be divided into  hibernate_32.S  
and hibernate_64.S ?

>>>>> +void save_processor_state(void)
>>>>> +{
>>>>> +	saved_status = read_c0_status();
>>>>> +}
>>>>>           
>>>> No need to save/restore floating point registers?
>>>>         
>>> the floating point registers are not used by kernel, for user part, they
>>> are already saved while entering into kernel mode.
>>>       
>> No, floating point registers are not saved on entering into kernel.
>> They are saved on context switch.  
>>     
Yes, suspend to disk  will freeze processes at first,and i think the 
process wiil save the float point regs.
So there is no need to save them.
> It's my mistake. But I think, if there is need to save floating point
> registers, the kernel have already done for it. 
> What's need to save should be for the resuming parts. Those registers which are used while 
> in suspending path are needed to save.
>
> create_image()
>
>    in_suspend = 1;
>     save_processor_state();
>     error = swsusp_arch_suspend();
>     if (error)
>         printk(KERN_ERR "PM: Error %d creating hibernation image\n",
>             error);
>    
>   when resuming this functions is executed for righ after the  swsusp_arch_suspend().
>   This is not a normal function return.
>   So the registers need to save are those damaged by swsusp_arch_suspend and what it calls.
>   
>   because this is not a normal function call, the callee saved registers can not be restored, so we need to save
> it explicitly. For caller saved temporary registers, they are already saved in create_image.  Are this right?
>       
>   
---
>> Atsushi Nemoto
>>     
>
>
>
>   


-- 
---------------------------------------------------------
Hongbing,Hu (Software Department)
Tel:    0512-52308631
E-mail:	huhb@lemote.com
MSN:	[huhb04@gmail.com]
JiangSu Lemote Corp. Ltd.
MengLan, Yushan, Changshu, JiangSu Province, China
---------------------------------------------------------
