Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5Et3903472
	for linux-mips-outgoing; Wed, 5 Dec 2001 06:55:03 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5Esuo03460
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 06:54:56 -0800
Message-Id: <200112051454.fB5Esuo03460@oss.sgi.com>
Received: (qmail 11386 invoked from network); 5 Dec 2001 13:49:20 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 5 Dec 2001 13:49:20 -0000
Date: Wed, 5 Dec 2001 21:53:3 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Chris Dearman <chris@algor.co.uk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: 2.4.16 for algorithmics p6032
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fB5Esvo03461
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Chris£¬
  you can do anything you like to my code:)
  i have promised to release it months ago,but so busy I was the past
months and i am shy to release ugly code. Sorry if it waste you time.

  Today I make some tests and get some fixes ,log is here
  (i was too sleepy last night,so most of them is stupy errors):
 2001.12.05:
   arch/mips/defconfig-p6032:
     ide dma unstable,don't choose 'use dma by default when available'
     enable CONFIG_MTD_OBSOLETE_CHIPS & CONFIG_MTD_AMDSTD instead of
            CONFIG_MTD_CFI_AMDSTD for p6032 flash driver
          (to use the driver,mknod /dev/flash b 31 0,then you can cp to/from it)
     arch/mips/kernel/time.c:
        add code to display a banner using the little led on p6032.
     arch/mips/algor/p6032/kernel/setup.c:
         fix calculation of mips_counter_frequency,forget to div 2:(

 the diff on my site is updated.

 you probably will be more able to deal with the dma and board cache
than me:). The spurious interrupt problem still there,i have added some
code to work around it but don't know the reason.
  
 I have made a quick test with ltp, most of them passed,but some of
the fs test and the syscall test failed,i will look into them soon
if you have interest,i can give you more detail results



ÔÚ 2001-12-05 12:37:00 you wrote£º
>Zhang Fuxin wrote:
>> 
>> hi,linux-mips,
>> 
>>  This mail seems lost,so i repost,i apologize if it duplicates
>> :
>
>  I've been tracking the 2.4 (now 2.5) kernel with my own P6032/P6064
>port.  I did say I would send my stuff to Ralf to get it included in the
>CVS tree.
>
>  I can see that you have some good stuff here, so I'd like to
>incorporate it into my code if that's OK with you.  Then I *really* will
>send this stuff to Ralf.
>
>	Regards
>		Chris
>
>-- 
>Algorithmics,The Fruit Farm,Ely Road,Chittering,CAMBS CB5 9PH,ENGLAND
>P: +44 1223 706200    F: +44 1223 706250    W: http://www.algor.co.uk

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
