Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2003 10:24:14 +0100 (BST)
Received: from [IPv6:::ffff:202.125.80.34] ([IPv6:::ffff:202.125.80.34]:56583
	"EHLO mail.esn.activedirectory") by linux-mips.org with ESMTP
	id <S8225200AbTIDJX6>; Thu, 4 Sep 2003 10:23:58 +0100
Received: by mail.esn.activedirectory with Internet Mail Service (5.5.2650.10)
	id <RQAMMVKC>; Thu, 4 Sep 2003 14:38:17 +0530
Message-ID: <AF572D578398634881E52418B28925671EA5FC@mail.esn.activedirectory>
From: JinuM <jinum@esntechnologies.co.in>
To: linux-mips@linux-mips.org
Subject: PCI driver problem
Date: Thu, 4 Sep 2003 14:38:12 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.10)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <jinum@esntechnologies.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jinum@esntechnologies.co.in
Precedence: bulk
X-list: linux-mips

Hi All,

I am moving onto MIPS from x86. I am facing a few problems using the base
address register of my PCI device on my MIPS.

i have a PCI card and i have written a simple driver for it on my x86
system. I dont follow the "pci_register_driver()" routine, instead i do a
"register_chrdrv()" in my "init_module()". 

In the my "open" call back routine, i do a 
****dev=pci_find_device(MY_VEN_ID,MY_DEV_ID,NULL);
then follow it by 
****mystruct->ioaddr=pci_resource_start(dev,0);
i do a ioremap n get my remapped address 
****mystruct->reioaddr = ioremap(mystruct->ioaddr,someLen);

ofcourse i do all the error checks after the function calls.

now in my open callback routine for testing i do a 

outl(0x42, mystruct->reioaddr+LED_OFFSET)

this puts OFF the LED on my card.

The above steps work well with my x86 system and the LED does go OFF. But
the same code doesnot work on my MIPS. Is there a difference in the way i
should use my base address register or do my IO(out(s) and in(s)). I guess
MIPS doesnot support I/O mapped devices, but i think in and out on MIPS take
care of converting the access.

Its to be noted that my PCI configuration space also differs. I get 0x0006
from my PCI command register in G4 where as on x86 i have 0x0107. Is this
because IO based accessing is not enabled on MIPS?

do i need to do a pci_enable_device(dev) after my pci_find_device()????? I
tried this but it dint work. 

can anyone please help me figure out the problem? 

thanx for your time!
-Jinu
