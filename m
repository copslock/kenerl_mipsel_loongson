Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UDjZJ04195
	for linux-mips-outgoing; Mon, 30 Jul 2001 06:45:35 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UDjXV04192
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 06:45:33 -0700
Message-Id: <200107301345.f6UDjXV04192@oss.sgi.com>
Received: (qmail 22784 invoked from network); 30 Jul 2001 13:40:39 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 30 Jul 2001 13:40:39 -0000
Date: Mon, 30 Jul 2001 21:48:20 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: 
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,linux-mips
    I am porting support of Algorithmics P6032 evalution board from
2.2 kernel to 2.4. I started with the kernel 2.4.3 from hardhat2.0 
distribution.Now I am able to boot the kernel but it hangs up when
trying to exec /sbin/init.The error message is something like:
   Init: Kernel panic: trying to kill init
   Init:error loading libc.so.6, undefined symbol _sec0

But if i let the kernel execute /bin/ash.static directly,it can give me
a shell while complaining something like" no tty found,job control disabled". Then I can use most commands such as ls,passwd,cat.So the 
libc.so.6 can't be a corrupted one.

  The test environment is:
       Algorithmics P6032 with a idt79RC64474 CPU
       IDE hard disk(IBM Deskstar 40M,7200rpm)
  Kernel options:
       pci,ide(with/without dma,multimode) enabled
       serial console enabled

  What can be the cause?

  I suspect the ide driver first.But disabling dma doesn't help and it
seems to work quite well under ash.

  I am investigating the cause,if you want,I can provide more 
information.
  

 


Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
