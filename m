Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3O1C5wJ006672
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Apr 2002 18:12:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3O1C5wR006671
	for linux-mips-outgoing; Tue, 23 Apr 2002 18:12:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3O1BowJ006668
	for <linux-mips@oss.sgi.com>; Tue, 23 Apr 2002 18:11:50 -0700
Message-Id: <200204240111.g3O1BowJ006668@oss.sgi.com>
Received: (qmail 16595 invoked from network); 24 Apr 2002 01:08:48 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 24 Apr 2002 01:08:48 -0000
Date: Wed, 24 Apr 2002 9:11:38 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: vga initialization
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
  I find most code is already there in scitech's x86emu-0.8.
in one day it is adapted into linux kernel.

  If anybody is interested,my code can be fetched from
ftp://ftp.gnuchina.org/incoming/mips-vga-init/freebiosvga.tar.gz

For a short description,the READ in the package is paste here:

This is x86/bios emulator adapted for used in 2.4 kernel
to do initialize pc VGA cards.

Port it to pmon/yamon should be easy,if you want an userland
executable,please download the original x86emu-0.8 from SciTech 
Software, Inc.

Usage:
 here is my choice:
  1.add code in new directory arch/mips/freebiosvga/
  2.arch/mips/config.in:
     add config option CONFIG_VGA_POST to proper place
         bool '  Support for VGA POST' CONFIG_VGA_POST

  3.arch/mips/Makefile
     add directory and target objects of freevgabios

     ifdef CONFIG_VGA_POST
     SUBDIRS      += arch/mips/freebiosvga
     LIBS         += arch/mips/freebiosvga/vga.o
     SUBDIRS      += arch/mips/freebiosvga/x86emu
     LIBS         += arch/mips/freebiosvga/x86emu/x86emu.o
     endif

  4.init/main.c:
    add call to vgabios_init (right after pci_init)
    #ifdef CONFIG_VGA_POST
      vgabios_init();
    #endif

  5.select 'VGA text console' or proper framebuffer, you may need to
  slightly modify the code,because many of them is for x86

    for 'VGA text console',the file is drivers/video/vgacon.c,propably
  you need to comment out the check for card's presence in vgacon_startup.
  Because card initialization is later than console_init,so at that time
  pci address 0xa0000-0xc0000 may not response to your requests.


Problems & limits:
  1.currently the code rely on system's pci resource allocator to assign
    a valid address to rom base register(offset 0x30 in pci header).
    I have modified the pci_auto.c to handle rom. Patch is here:

     diff -r1.2 pci_auto.c
     107a108,110
     >       u32 bases[7] = {PCI_BASE_ADDRESS_0,PCI_BASE_ADDRESS_1,PCI_BASE_ADDRESS_2,
     >                         PCI_BASE_ADDRESS_3,PCI_BASE_ADDRESS_4,PCI_BASE_ADDRESS_5,
     >                       PCI_ROM_ADDRESS};
     110c113,116
     <       for (bar = PCI_BASE_ADDRESS_0; bar <= PCI_BASE_ADDRESS_5; bar+=4) {
     ---
     >       for (bar_nr=0; bar_nr<7; bar_nr++) {
     > 
     >               bar = bases[bar_nr];
     > 
     137c143
     <               if (bar_response & PCI_BASE_ADDRESS_SPACE) {
     ---
     >               if (bar_nr != 6 && (bar_response & PCI_BASE_ADDRESS_SPACE)) {
     209d214
     <               bar_nr++;
     349,350d353
     < 
     <                       DBG("Skipping legacy mode IDE controller\n");

   if you don't use pci_auto,then make sure your pmon/yamon do it.

   Of course,you can write an absolute,safe value for your specific platform
   to see it works:)

   If the base address read from your card is invalid,you will get message 
   like:
     "No address assigned to rom" or "No valid bios found"
    
 2. i am assuming ioremap(a_pci_address) will return a valid cpu virtue 
   address for accessing memory located at 'a_pci_address'.
    

 3. Multiple cards are not supported currently,though it may be a piece of
 cake.Complex cards,e.g. those contain bridges,may fail.

 4. cards tested here include: 
   trident 3Dimage9750,S3virge,Riva TNT2

DISCLAIMER:
  It is provided "as is" without express or implied warranty.

  Any problems you can contact fxzhang@ict.ac.cn.

  
Happy hacking and good luck.
			
  

    
    





--
Zhang Fuxin
System Architecture Lab
Institute of Computing Technology
Chinese Academy of Sciences,China
http://www.ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
