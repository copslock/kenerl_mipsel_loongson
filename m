Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ODCJwJ021271
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 06:12:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ODCJSS021270
	for linux-mips-outgoing; Wed, 24 Apr 2002 06:12:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ODC1wJ021266
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 06:12:01 -0700
Message-Id: <200204241312.g3ODC1wJ021266@oss.sgi.com>
Received: (qmail 27258 invoked from network); 24 Apr 2002 13:09:14 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 24 Apr 2002 13:09:14 -0000
Date: Wed, 24 Apr 2002 21:11:20 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Girish Gulawani <girishvg@yahoo.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: vga initialization
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g3ODC2wJ021267
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
  I don't have that card at hand:(. But if you have tried this emulation
code,please give more detailed message:
  1. what you do
  2. output (dmesg,or captured from your serial console).
  3. your platform,esp. whether it has pc legacy hardware support. 
    For example,a PIIX4 or via686a southbridge will give you 
    functionality of the legacy vga support,8254 timer and standard io ports
    (0x41-0x43 timer,0x61->timer 2 enable,0x3c0-0x3cf ->vga ports etc.)


ÔÚ 2002-04-24 20:15:00 you wrote£º
>would you by any chance try this emulation on AOpen's PT80 card? i failed to
>fire up this card. any clues?
>
>
>----- Original Message -----
>From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
>To: <linux-mips@oss.sgi.com>
>Sent: Wednesday, April 24, 2002 10:11 AM
>Subject: vga initialization
>
>
>> hi,
>>   I find most code is already there in scitech's x86emu-0.8.
>> in one day it is adapted into linux kernel.
>>
>>   If anybody is interested,my code can be fetched from
>> ftp://ftp.gnuchina.org/incoming/mips-vga-init/freebiosvga.tar.gz
>>
>> For a short description,the READ in the package is paste here:
>>
>> This is x86/bios emulator adapted for used in 2.4 kernel
>> to do initialize pc VGA cards.
>>
>> Port it to pmon/yamon should be easy,if you want an userland
>> executable,please download the original x86emu-0.8 from SciTech
>> Software, Inc.
>>
>> Usage:
>>  here is my choice:
>>   1.add code in new directory arch/mips/freebiosvga/
>>   2.arch/mips/config.in:
>>      add config option CONFIG_VGA_POST to proper place
>>          bool '  Support for VGA POST' CONFIG_VGA_POST
>>
>>   3.arch/mips/Makefile
>>      add directory and target objects of freevgabios
>>
>>      ifdef CONFIG_VGA_POST
>>      SUBDIRS      += arch/mips/freebiosvga
>>      LIBS         += arch/mips/freebiosvga/vga.o
>>      SUBDIRS      += arch/mips/freebiosvga/x86emu
>>      LIBS         += arch/mips/freebiosvga/x86emu/x86emu.o
>>      endif
>>
>>   4.init/main.c:
>>     add call to vgabios_init (right after pci_init)
>>     #ifdef CONFIG_VGA_POST
>>       vgabios_init();
>>     #endif
>>
>>   5.select 'VGA text console' or proper framebuffer, you may need to
>>   slightly modify the code,because many of them is for x86
>>
>>     for 'VGA text console',the file is drivers/video/vgacon.c,propably
>>   you need to comment out the check for card's presence in vgacon_startup.
>>   Because card initialization is later than console_init,so at that time
>>   pci address 0xa0000-0xc0000 may not response to your requests.
>>
>>
>> Problems & limits:
>>   1.currently the code rely on system's pci resource allocator to assign
>>     a valid address to rom base register(offset 0x30 in pci header).
>>     I have modified the pci_auto.c to handle rom. Patch is here:
>>
>>      diff -r1.2 pci_auto.c
>>      107a108,110
>>      >       u32 bases[7] =
>{PCI_BASE_ADDRESS_0,PCI_BASE_ADDRESS_1,PCI_BASE_ADDRESS_2,
>>      >
>PCI_BASE_ADDRESS_3,PCI_BASE_ADDRESS_4,PCI_BASE_ADDRESS_5,
>>      >                       PCI_ROM_ADDRESS};
>>      110c113,116
>>      <       for (bar = PCI_BASE_ADDRESS_0; bar <= PCI_BASE_ADDRESS_5;
>bar+=4) {
>>      ---
>>      >       for (bar_nr=0; bar_nr<7; bar_nr++) {
>>      >
>>      >               bar = bases[bar_nr];
>>      >
>>      137c143
>>      <               if (bar_response & PCI_BASE_ADDRESS_SPACE) {
>>      ---
>>      >               if (bar_nr != 6 && (bar_response &
>PCI_BASE_ADDRESS_SPACE)) {
>>      209d214
>>      <               bar_nr++;
>>      349,350d353
>>      <
>>      <                       DBG("Skipping legacy mode IDE controller\n");
>>
>>    if you don't use pci_auto,then make sure your pmon/yamon do it.
>>
>>    Of course,you can write an absolute,safe value for your specific
>platform
>>    to see it works:)
>>
>>    If the base address read from your card is invalid,you will get message
>>    like:
>>      "No address assigned to rom" or "No valid bios found"
>>
>>  2. i am assuming ioremap(a_pci_address) will return a valid cpu virtue
>>    address for accessing memory located at 'a_pci_address'.
>>
>>
>>  3. Multiple cards are not supported currently,though it may be a piece of
>>  cake.Complex cards,e.g. those contain bridges,may fail.
>>
>>  4. cards tested here include:
>>    trident 3Dimage9750,S3virge,Riva TNT2
>>
>> DISCLAIMER:
>>   It is provided "as is" without express or implied warranty.
>>
>>   Any problems you can contact fxzhang@ict.ac.cn.
>>
>>
>> Happy hacking and good luck.
>
>
>
>
>_________________________________________________________
>
>Do You Yahoo!?
>
>Get your free @yahoo.com address at http://mail.yahoo.com

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
