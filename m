Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2003 11:16:26 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:43482 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225419AbTIPKQQ>;
	Tue, 16 Sep 2003 11:16:16 +0100
Received: (qmail 25948 invoked from network); 16 Sep 2003 10:02:13 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 16 Sep 2003 10:02:13 -0000
Message-ID: <3F66E2DC.8030007@ict.ac.cn>
Date: Tue, 16 Sep 2003 18:15:56 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Guangxing Zhang <guangxing@ict.ac.cn>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: It is ok on linux ,but not ok on mips_linux as my expection!
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

To compile a module on mips,some compiler flags are required. An example:
  CFLAGS=
     "-I /usr/local/src/linux-mips/include/asm/gcc -D__KERNEL__ 
-I/usr/local/src/linux-mips/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common
 -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe 
-DMODULE -mlong-calls"

And you may have know that there are 2 different world of mips: big 
endian and little endian. When
using cross compiler,you should choose the correct toolchain(often 
mipsel-xxx vs. mips-xxx).

But these normally lead to other errors, so again check for your kernel 
version about task queue data
structures. (Does your toolchain's kernel headers consistent with the 
one running on mips?)

Guangxing Zhang wrote:

>Hi, 
>
>	    Inspired by your advice , I have changed the method of preventing the module 
>from being unloaded while "intrpt_routine" is still in the task queue.Now it can freely 
>"insmod" and "rmmod" in my linux(2.4.18-3,not on mips) at  any time.But unfortunatlly,
>When I port it to mips_linux, it get some errors as you can see in my mail to 
>linux-mips@linux-mips.org . It confuses me .Why? And what should I MUST pay attention to
>or what should I MUST learn if I I want to implement schedualing a function to be called
>on every timer interrupt.
>
>        Thank you again and eagering your enthusiastic again! 
> 
>
>======= 2003-09-16 13:17:00 WROTE��=======
>
>  
>
>>Guangxing Zhang wrote:
>>
>>    
>>
>>>Hi, Fuxin Zhang
>>>
>>> 
>>>
>>>      
>>>
>>>>for any warnings. BTW, I don't the method you used to cleanup is safe,
>>>>there maybe a task queued but not executed at the time you 
>>>>'rmmod',doesn't it?
>>>>   
>>>>
>>>>        
>>>>
>>>Yes ,in http://www.faqs.org/docs/kernel/x1145.html#AEN1201 , it mentions the 
>>>situation as you said.And just to overcoming it ,it use the sleep_on().But as you 
>>>see, now it can not "rmmod" correctly and my linux will broke.
>>>
>>>As a newbie to kernel module ,I am not sure why and not know how to scheduale a 
>>>function to be called on every timer interrupt or every seconds in kernle module.
>>>Eagering your help!
>>> 
>>>
>>>      
>>>
>>>>>interrupt
>>>>>     
>>>>>
>>>>>          
>>>>>
>>Most ethernet adapter driver(e.g. drivers/net/eepro100.c) use timer,you 
>>can check them for examples.
>>
>>
>>Have you check the sleep_on and wakeup routine's argument type? They 
>>should be wait_queue_head_t *
>>for recent kernels?
>>    
>>
>
>= = = = = = = = = = = = = = = = = = = =
>			
> 
>				 
>　　　　　　　　Guangxing Zhang
>　　　　　　　　guangxing@ict.ac.cn
>　　　　　　　　　　2003-09-16
>
>
>
>
>
>  
>
