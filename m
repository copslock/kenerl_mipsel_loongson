Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6IaWe23678
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:36:32 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB6Ia2o23634
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:36:03 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB6HZxr09439
	for linux-mips@oss.sgi.com; Thu, 6 Dec 2001 15:35:59 -0200
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB4JbCo04548
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 11:37:12 -0800
Message-Id: <200112041937.fB4JbCo04548@oss.sgi.com>
Received: (qmail 8208 invoked from network); 4 Dec 2001 18:31:28 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 4 Dec 2001 18:31:28 -0000
Date: Wed, 5 Dec 2001 2:35:3 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
   Chris Dearman <chris@algor.co.uk>, Ian Chilton <mailinglist@ichilton.co.uk>
Subject: 2.4.16 kernel for algor p6032
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,linux-mips,
   Finally the 2.4 kernel seems calm down,I pay some time to cleanup
my code for algorithmics p6032 board.
   Although it may still very experimental,i make it public here 
hoping that it will save  sometime for someone else.
   You can get the source diff
   (against sgi cvs linux_2_4_branch Dec.3,about 50k) from: 
   http://159.226.40.150/godson/mips-2.4.16-zfx.diff.gz
     (sorry i haven't a dns name)

  I am eager to get some feedback.

  There are Changelog and README in arch/mips/algor/

 for your convenience,READ is post here:

    This is my code for algor p6032,many of them borrowed/inherit from
algorithmics' 2.2 kernel(and others),but with a lot of cleanup(i think:)
I have tried my best to make minimum changes to generic code.

  Testing platform:
      Algorithmics p6032 eval board,idt RC64474 CPU
      (with a 40G IBM 7200rpm ide disk,256M sdram memory,matrox G200 video
       card)
      Software: H.J.Lu's cross compile toolchain & redhat 7.1 port)
  Features:
      1.new time,new irq,new pci,auto-pci,etc
      see this list:
      CONFIG_PCI=y
      CONFIG_NEW_PCI=y
      CONFIG_PCI_AUTO=y
      CONFIG_NEW_IRQ=y
      CONFIG_I8259=y
      CONFIG_HAVE_STD_PC_SERIAL_PORT=y
      CONFIG_NEW_TIME_C=y
      CONFIG_BOARD_SCACHE=y
      CONFIG_PC_KEYB=y
      CONFIG_NONCOHERENT_IO=y

      2. frame buffer for matrox cards(that means you can use X windows)
      3. a flash driver for easily rewriting of on board flash
      4. ide,ethernet(pcnet32) with dma
      5. with 2.4.16 patch(filesystem corruption fixed)

   TODO:
      1. more test,e.g. with ltp or something
         I have run 2.4.8 for some time with good stablity,but this upgrade is
	 done in one day,with many cleanups
	 it will surely contain some bugs
      2. on board cache support
         i haven't decided a elegant way to support the board cache
      3. 

   Important Notes:
      1. the command line is fixed at arch/mips/kernel/setup.c for my convenience:),you should change to fit your need or comment it out and use pmon args
      2. PIIX support for ide must be choosed,or the irq probe will lead to
         endless interruption.
      
   More information may present in Changelog.zfx.


                   2001.12.05 Zhang Fuxin, <fxzhang@ict.ac.cn>
		   Institute of Computing Technology,Chinese Academy of Sciences

have to get some sleep now:)

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
