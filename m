Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IAYLv27617
	for linux-mips-outgoing; Tue, 18 Sep 2001 03:34:21 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IAYIe27614
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 03:34:18 -0700
Message-Id: <200109181034.f8IAYIe27614@oss.sgi.com>
Received: (qmail 15539 invoked from network); 18 Sep 2001 10:28:23 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Sep 2001 10:28:23 -0000
Date: Tue, 18 Sep 2001 18:33:35 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,all
  I have finally been able to get a copy of sgi cvs code:).Now I have
changed my p6032 code to use new[time,pci,irq] code and it seems a 
lot cleaner.But still problems.
  I keep seeing spurious interrupt when starting xwindows.And 
sometimes without x. If the machine is doing heavy io(e.g.,unzip & 
untar mozilla source) when I startx,it will probably enter an 
endless loop of spurious interrupt or lead to unaligned instruction 
access shortly after(with epc=0x1,ra=0x1) and die.
  I have seen spurious IRQ1,IRQ7 and IRQ12,and the endless loop case
is IRQ12--ps2 mouse interrupt.
  Can somebody give me a clue? What I know is that 8259 may generate
spurious IRQ7 & IRQ15. But how can the others happen,buggy hw?And 
what may cause a kernel unaligned instruction access?

  My hw is p6032 rev.B eval board with idtRC64474 cpu.

  BTW,is that current code has no support for different PCI & CPU 
address space?In p6032 default setting,PCI memory address 0 is 
CPU physical address 0x10000000,and main memory is 0-0x10000000
for CPU,but 0x80000000-0x90000000 for pci. So I have to change 
ioremap,virt_to_bus & bus_to_virt. I think this problem should 
exist in many nonpc hw,could you point me a clean way?

  Thanks in advance.


Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
