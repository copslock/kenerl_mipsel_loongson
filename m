Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5Fera08744
	for linux-mips-outgoing; Wed, 5 Dec 2001 07:40:53 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5Feio08741
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 07:40:45 -0800
Message-Id: <200112051540.fB5Feio08741@oss.sgi.com>
Received: (qmail 14691 invoked from network); 5 Dec 2001 14:35:09 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 5 Dec 2001 14:35:09 -0000
Date: Wed, 5 Dec 2001 22:38:55 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Chris Dearman <chris@algor.co.uk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: 2.4.16 for algorithmics p6032
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fB5Fejo08742
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Chris£¬



ÔÚ 2001-12-05 14:25:00 you wrote£º
>Zhang Fuxin wrote:
>> 
>> hi,Chris£¬
>>   you can do anything you like to my code:)
>>   i have promised to release it months ago,but so busy I was the past
>> months and i am shy to release ugly code. Sorry if it waste you time.
>
>  Thanks.  We've followed very similar routes so there aren't so many
>differences :-)
>
>> 
>>   Today I make some tests and get some fixes ,log is here
>>   (i was too sleepy last night,so most of them is stupy errors):
>>  2001.12.05:
>>    arch/mips/defconfig-p6032:
>>      ide dma unstable,don't choose 'use dma by default when available'
>
>  Yes.  I have had a look at this but haven't tracked it down yet.  The
>only thing I know is that the buffer heads get corrupted, so I assume
>there is some interrupt locking problem somewhere.  I know that DMA
>works in the MIPS 2.4.3 port. Were you using DMA in your 2.4.8 kernel?  
 Yes,it works well,at least much more stable
 for 2.4.16,a simple 'mtest01 -p80 -w'(alloc 80% memory to write) test can break the ide dma.

>
>>  you probably will be more able to deal with the dma and board cache
>
>  Do you use the IOBC?  I had to make some changes to pci.h and the
>ethernet driver to make them work properly.
No. I had to make changes to generic code:),that's why i disable it.
>
>> than me:). The spurious interrupt problem still there,i have added some
>> code to work around it but don't know the reason.
>
>  The spurious interrupts are caused by posted writes to PCI devices. 
>The sequence is usually something like:
>  o write device to clear interrupt (write gets posted)
>  o enable CPU interrupts (interrupt is still pending)
>  o CPU enters interrupt handler and reads 8259 which causes posted
>write
>    to be flushed and so now there is no interrupt...
>
>  The only fix is to do an explicit PCI (eg ISA port) before reenabling
>interrupts.  The 2.4.x kernel reenables interrupts more quickly than the
>older kernel which is why it is more noticeable.
>
Oh, thanks for your explanation.
>> 
>>  I have made a quick test with ltp, most of them passed,but some of
>> the fs test and the syscall test failed,i will look into them soon
>> if you have interest,i can give you more detail results
>
>  I've not used ltp, but if you do find anything useful I would be
>interested.
>
ok,i will let you know if something found
>	Regards
>		Chris
>
>-- 
>Algorithmics,The Fruit Farm,Ely Road,Chittering,CAMBS CB5 9PH,ENGLAND
>P: +44 1223 706200    F: +44 1223 706250    W: http://www.algor.co.uk

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
