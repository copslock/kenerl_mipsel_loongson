Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5FQDf07189
	for linux-mips-outgoing; Wed, 5 Dec 2001 07:26:13 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5FQ6o07186
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 07:26:06 -0800
Received: from algor.co.uk (angel.algor.co.uk [62.254.210.234])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id fB5EPuZ22296;
	Wed, 5 Dec 2001 14:25:56 GMT
Message-ID: <3C0E2E74.C1E7DF9F@algor.co.uk>
Date: Wed, 05 Dec 2001 14:25:56 +0000
From: Chris Dearman <chris@algor.co.uk>
Organization: Algorithmics Ltd
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 2.4.16 for algorithmics p6032
References: <200112051354.fB5DstZ21095@oval.algor.co.uk>
Content-Type: text/plain; charset=iso-8859-1
X-MIME-Autoconverted: from 8bit to quoted-printable by oval.algor.co.uk id fB5EPuZ22296
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fB5FQ7o07187
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
> 
> hi,Chris£¬
>   you can do anything you like to my code:)
>   i have promised to release it months ago,but so busy I was the past
> months and i am shy to release ugly code. Sorry if it waste you time.

  Thanks.  We've followed very similar routes so there aren't so many
differences :-)

> 
>   Today I make some tests and get some fixes ,log is here
>   (i was too sleepy last night,so most of them is stupy errors):
>  2001.12.05:
>    arch/mips/defconfig-p6032:
>      ide dma unstable,don't choose 'use dma by default when available'

  Yes.  I have had a look at this but haven't tracked it down yet.  The
only thing I know is that the buffer heads get corrupted, so I assume
there is some interrupt locking problem somewhere.  I know that DMA
works in the MIPS 2.4.3 port. Were you using DMA in your 2.4.8 kernel?  

>  you probably will be more able to deal with the dma and board cache

  Do you use the IOBC?  I had to make some changes to pci.h and the
ethernet driver to make them work properly.

> than me:). The spurious interrupt problem still there,i have added some
> code to work around it but don't know the reason.

  The spurious interrupts are caused by posted writes to PCI devices. 
The sequence is usually something like:
  o write device to clear interrupt (write gets posted)
  o enable CPU interrupts (interrupt is still pending)
  o CPU enters interrupt handler and reads 8259 which causes posted
write
    to be flushed and so now there is no interrupt...

  The only fix is to do an explicit PCI (eg ISA port) before reenabling
interrupts.  The 2.4.x kernel reenables interrupts more quickly than the
older kernel which is why it is more noticeable.

> 
>  I have made a quick test with ltp, most of them passed,but some of
> the fs test and the syscall test failed,i will look into them soon
> if you have interest,i can give you more detail results

  I've not used ltp, but if you do find anything useful I would be
interested.

	Regards
		Chris

-- 
Algorithmics,The Fruit Farm,Ely Road,Chittering,CAMBS CB5 9PH,ENGLAND
P: +44 1223 706200    F: +44 1223 706250    W: http://www.algor.co.uk
