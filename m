Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2003 10:33:44 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:49368 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225414AbTIPJd1> convert rfc822-to-8bit;
	Tue, 16 Sep 2003 10:33:27 +0100
Received: (qmail 8231 invoked from network); 16 Sep 2003 09:17:00 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 16 Sep 2003 09:17:00 -0000
From: "Guangxing Zhang" <guangxing@ict.ac.cn>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: It is ok on linux ,but not ok on mips_linux as my expection!
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Tue, 16 Sep 2003 17:31:24 +0800
Message-Id: <20030916093341Z8225414-1272+5484@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi, 

	    Inspired by your advice , I have changed the method of preventing the module 
from being unloaded while "intrpt_routine" is still in the task queue.Now it can freely 
"insmod" and "rmmod" in my linux(2.4.18-3,not on mips) at  any time.But unfortunatlly,
When I port it to mips_linux, it get some errors as you can see in my mail to 
linux-mips@linux-mips.org . It confuses me .Why? And what should I MUST pay attention to
or what should I MUST learn if I I want to implement schedualing a function to be called
on every timer interrupt.

        Thank you again and eagering your enthusiastic again! 
 

======= 2003-09-16 13:17:00 WROTE��=======

>Guangxing Zhang wrote:
>
>>Hi, Fuxin Zhang
>>
>>  
>>
>>>for any warnings. BTW, I don't the method you used to cleanup is safe,
>>>there maybe a task queued but not executed at the time you 
>>>'rmmod',doesn't it?
>>>    
>>>
>>Yes ,in http://www.faqs.org/docs/kernel/x1145.html#AEN1201 , it mentions the 
>>situation as you said.And just to overcoming it ,it use the sleep_on().But as you 
>>see, now it can not "rmmod" correctly and my linux will broke.
>>
>>As a newbie to kernel module ,I am not sure why and not know how to scheduale a 
>>function to be called on every timer interrupt or every seconds in kernle module.
>>Eagering your help!
>>  
>>
>>>>interrupt
>>>>      
>>>>
>
>Most ethernet adapter driver(e.g. drivers/net/eepro100.c) use timer,you 
>can check them for examples.
>
>
>Have you check the sleep_on and wakeup routine's argument type? They 
>should be wait_queue_head_t *
>for recent kernels?

= = = = = = = = = = = = = = = = = = = =
			
 
				 
　　　　　　　　Guangxing Zhang
　　　　　　　　guangxing@ict.ac.cn
　　　　　　　　　　2003-09-16
