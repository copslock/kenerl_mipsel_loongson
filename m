Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2003 02:51:38 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:16775 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225362AbTIQBvg> convert rfc822-to-8bit;
	Wed, 17 Sep 2003 02:51:36 +0100
Received: (qmail 13309 invoked from network); 17 Sep 2003 01:37:23 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 17 Sep 2003 01:37:23 -0000
From: "Guangxing Zhang" <guangxing@ict.ac.cn>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: Re: Re: It is ok on linux ,but not ok on mips_linux as my expection!
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Wed, 17 Sep 2003 9:51:59 +0800
Message-Id: <20030917015136Z8225362-1272+5527@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi, Fuxin Zhang
======= 2003-09-16 18:15:00 WROTE£º=======

>To compile a module on mips,some compiler flags are required. An example:
>  CFLAGS=
>     "-I /usr/local/src/linux-mips/include/asm/gcc -D__KERNEL__ 
>-I/usr/local/src/linux-mips/include
>-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
>-fno-strict-aliasing -fno-common
> -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe 
>-DMODULE -mlong-calls"
I have tried to change the compiler flags before.And I am not sure the 
exact meaning of the "-mips2".I think it is related to our mips.When I 
compile my mips-linux kernel,I used "-mcpu=sb1 " and our mips is
mips64 , but the kernel we use is linux for mips32, because I know linux 
for mips64 doest not support kernel module yet(It is a trouble to me too). 
One thing confused me is that with the flag "-mips2" or "-mips32", or 
"-mips64", when I compiled my kernel module,it will get the following error  :
______________________________________________________________________________________________
sch_example.c:80: warning: function declaration isn't a prototype
sch_example.c:92: warning: function declaration isn't a prototype
/tmp/ccxxm0Sw.s: Assembler messages:
/tmp/ccxxm0Sw.s:152: Error: opcode not supported on this processor: R6000 (MIPS2) `lld $3,8($6)'
/tmp/ccxxm0Sw.s:154: Error: opcode not supported on this processor: R6000 (MIPS2) `scd $2,8($6)'
/tmp/ccxxm0Sw.s:245: Error: opcode not supported on this processor: R6000 (MIPS2) `lld $4,8($6)'
/tmp/ccxxm0Sw.s:247: Error: opcode not supported on this processor: R6000 (MIPS2) `scd $3,8($6)'
________________________________________________________________________________________________
But when i removed that flags it will be compiled ok, of course it is still can not work ok when i
try to "insmod".:)~
Any advice for me ?
>And you may have know that there are 2 different world of mips: big 
>endian and little endian. When
>using cross compiler,you should choose the correct toolchain(often 
>mipsel-xxx vs. mips-xxx).
>
Yes, I have noticed this before and my others simple kernel module can be
compiled  and "insmod" ok. So i think it is the tq_timer or the queue_task
that arose the trouble as you said follow.
>But these normally lead to other errors, so again check for your kernel 
>version about task queue data
>structures. (Does your toolchain's kernel headers consistent with the 
>one running on mips?)
I have notice the change of the "struct tq_struct" .
But I am not sure  whether the task queue is the best choice to be used here.
Because I know the evolution of "task queque-->tasklet-->softirq" . It seems 
"task queque" is a obsolete way.Ha~, maybe I should try to learn how to use
tasklet or softirq.
Is it a right think ? What is your advice?  And what should I do ?
As a newbie to the kernle module ,I am so so so confused.
Thank you again. You are an excellent Linux Man.
>
>Guangxing Zhang wrote:
>
>>Hi, 
>>
>>	    Inspired by your advice , I have changed the method of preventing the module 
>>from being unloaded while "intrpt_routine" is still in the task queue.Now it can freely 
>>"insmod" and "rmmod" in my linux(2.4.18-3,not on mips) at  any time.But unfortunatlly,
>>When I port it to mips_linux, it get some errors as you can see in my mail to 
>>linux-mips@linux-mips.org . It confuses me .Why? And what should I MUST pay attention to
>>or what should I MUST learn if I I want to implement schedualing a function to be called
>>on every timer interrupt.
>>
>>        Thank you again and eagering your enthusiastic again! 
>> 
>>
>>======= 2003-09-16 13:17:00 WROTE£º=======
>>
>>  
>>
>>>Guangxing Zhang wrote:
>>>
>>>    
>>>
>>>>Hi, Fuxin Zhang
>>>>
>>>> 
>>>>
>>>>      
>>>>
>>>>>for any warnings. BTW, I don't the method you used to cleanup is safe,
>>>>>there maybe a task queued but not executed at the time you 
>>>>>'rmmod',doesn't it?
>>>>>   
>>>>>
>>>>>        
>>>>>
>>>>Yes ,in http://www.faqs.org/docs/kernel/x1145.html#AEN1201 , it mentions the 
>>>>situation as you said.And just to overcoming it ,it use the sleep_on().But as you 
>>>>see, now it can not "rmmod" correctly and my linux will broke.
>>>>
>>>>As a newbie to kernel module ,I am not sure why and not know how to scheduale a 
>>>>function to be called on every timer interrupt or every seconds in kernle module.
>>>>Eagering your help!
>>>> 
>>>>
>>>>      
>>>>
>>>>>>interrupt
>>>>>>     
>>>>>>
>>>>>>          
>>>>>>
>>>Most ethernet adapter driver(e.g. drivers/net/eepro100.c) use timer,you 
>>>can check them for examples.
>>>
>>>
>>>Have you check the sleep_on and wakeup routine's argument type? They 
>>>should be wait_queue_head_t *
>>>for recent kernels?
>>>    
>>>
>>
>>= = = = = = = = = = = = = = = = = = = =
>>			
>> 
>>				 
>>¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡Guangxing Zhang
>>¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡guangxing@ict.ac.cn
>>¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡2003-09-16
>>
>>
>>
>>
>>
>>  
>>

= = = = = = = = = = = = = = = = = = = =
			
 
				 
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡Guangxing Zhang
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡guangxing@ict.ac.cn
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡2003-09-17
