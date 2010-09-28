Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 18:57:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17046 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0I1Q5D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 18:57:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca21e7f0000>; Tue, 28 Sep 2010 09:57:35 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Sep 2010 09:57:01 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Sep 2010 09:57:01 -0700
Message-ID: <4CA21E5D.7080905@caviumnetworks.com>
Date:   Tue, 28 Sep 2010 09:57:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     "wilbur.chan" <wilbur512@gmail.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Why mips eret failed?
References: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
In-Reply-To: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2010 16:57:01.0059 (UTC) FILETIME=[2B592D30:01CB5F2E]
X-archive-position: 27878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22559

On 09/28/2010 09:00 AM, wilbur.chan wrote:
> HI all!
>
> I'm learning to write a timer interrupt handler by my own on
> mips32(xls416 with 32bits cross compiled) , but to find that, eret
> failed to quit.
>
> detail:
>
> I took the following steps:
>
> 1)  copy exception vector to the physical address 0x180, then set ebase with it.
>
>       that is , memcpy these three  instructions to 0x80000180,with
> size 0x80 bytes:
>
>          lui    k1, HIGH(handle_int)
>         addiu  k1, k1, LOW(handle_int)
>         jr     k1
>
>
>   2)     this is handle_int , which is  the entry of interrupts
>
>      LEAF(handle_int)
>           nop
>           la     t9,do_IRQ
>           nop
>           jalr   t9
>           nop
>          eret
>          nop
>     END(handle_int)
>
>   ps:
>
>   'nop' is used to avoid delay slot,  and I did not add 'SAVE_ALL'  or
> 'RESTORE_ALL'  in handle_int,


Probably not a good choice.


> because it is just a demo,

If you want your demo to work, you cannot clobber all the registers in 
an exception handler.  Most ABIs allow you to clobber only k0 and k1.

In general any exception handler must save and restore all registers it 
modifies except for k0 and k1.  That is the function of SAVE_ALL and 
RESTORE_ALL.

> I want the
> interrupt return
>
> immediately.
>
> 3) this is do_IRQ
>
>   void do_IRQ(void)
> {
>      ack_irq();    /* ack with compare register ,which is used to
> generate timer interrupt*/
>      print("do_irq enter\n");
> }
>
>
>
> 4) there is a main loop like  this:
>
>
>      void main_loop()
>    {
>       local_irq_enable(); /* enable timer interrupt*/
>      while(1)
>      {
>           print("loop...\n");
>
>      }
>   }
>
> I found that , the message in do_IRQ  prints  every 4s (I' ve set
> timer of 4 seconds),  however, the message in main_loop did not appear
>
>
> q1:  does that mean, the timer interrupt has never quit to main_loop ,
> but a nested interrupt?
>
>
>
> q2:  that is to say, eret in handle_int failed to quit to main_loop?
>
> q3: why this happend?
>
>
> Thank you !
>
>
