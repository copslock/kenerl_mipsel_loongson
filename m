Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2KEiJj29839
	for linux-mips-outgoing; Wed, 20 Mar 2002 06:44:19 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2KEi6929835
	for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 06:44:06 -0800
Message-Id: <200203201444.g2KEi6929835@oss.sgi.com>
Received: (qmail 6381 invoked from network); 20 Mar 2002 14:16:37 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 20 Mar 2002 14:16:37 -0000
Date: Wed, 20 Mar 2002 22:46:14 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Girish Gulawani <girishvg@yahoo.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2KEi7929836
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

ÔÚ 2002-03-20 23:15:00 you wrote£º
>hello again.
>with regards to previous replies to my post -- the isa_readb() i am not
>using as i am still inside the linux loader program & not inside the linux
>kernel. now it seems what Zhang says is right. that some cards cannot be
>fired up without their BIOS.
>meantime today i could access VGA ROM BIOS at 0xC_0000 for no use as its x86
>code. i tried free-bios source code, which has VGA bios code for SiS300. its
>able to bring up monitor to normal mode out of powerdown mode. screen even
>displays "Out of Scan Range" message. but nothing after that. in order to
>compare initialization steps between SiS300 & my target SiS6326, i tried to
>get the data sheet from www.sis.com website but the data sheets are not
>available. could any body point me where the data sheets for SiS300 and
>PT-80 VGA card are available?
>
>btw, i wonder what card you people are using for VGA monitors? and what
>about their initialization on the MIPS board? is there ANYBODY who has used
>"AOpen's PT80" or ANY VGA card based on SiS6326 chipset on MIPS board & how?
>if somebody has done this exercise could you please explain, because i am
>sure this will be of general interest.
We have tried several cards on Algor P6032 board,but only matrox Gxxx cards
(G450 needs the latest code) can be used by linux kernel without vga bios 
executed. With a x86 emulator we are able to use Riva TNT2,and probably
more can work. Unfortunately that emulator is an executable from Algor,
as a kindly help. We can't get more control on it and finally give up.
 Recently we decide to develop our own emulator to execute vga bios code.
If everything goes smoothly,it should be available in several weeks.
>
>[to summarize my problem with PCI/VGA card -- currently i am using MILO bios
>source code. the card has 3 BARs.
>BAR0 = PCI Memory Area. BAR1 = 0xA_0000 (VGA MemIO Buff) BAR2 = 0x0380 (IO).
>with these settings the IO access from CPU is ok. but any access to A0000
>fails. my PCI is not PCI-to-PCI bridge, hence no question of VGA Enable.
>also the PCI bus analyzer does show memory read & memory writes commands
>being generated when accessed A0000 address. to add to this - i guess my
>options to choose the card are also limited as i have 3.3v PCI slot.]
>
>please help me.
>many thanks in advance.
>regards,
>girish.
>
>
>----- Original Message -----
>From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
>To: "Girish Gulawani" <girishvg@yahoo.com>
>Sent: Tuesday, March 19, 2002 12:00 AM
>Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
>
>
>hi,
>
> could that be the famouse vga bios initialization problem? That is,
>without executing the vgabios code,video card often refuse to work.
>And unfortunately vgabios code is often for x86.
>
>?¨² 2002-03-19 08:46:00 you wrote¡êo
>>> > i have a PCI/VGA card PT80 with SIS6326 chipset. i am using MILO BIOS
>>source
>>> > code. but i am not able to access the internal buffer which is
>typically
>>at
>>> > 0xA0000. even the BIOS ROM (0xC0000) read fails to show default value
>>> > 0xA5A5. the expansion ROM is enabled in PCI by setting D0 bit to 1.
>>however
>>> > IO seems okay because the monitor actually switches from power down
>mode
>>to
>>> > normal mode. i have tried using both vgaraw1.c and vgaraw2.c files, but
>>no
>>> > success. could anybody help me to solve this problem.
>>> > many thanks.
>>>
>>> Are you using isa_readb() and friends to access ISA memory space?
>>> Did you set up isa_slot_offset correctly with the start address of ISA
>>memory
>>> space on your MIPS box?
>>no i am not using isa_readb() etc. infact i am accessing this area 0xA_0000
>>as Memory/IO in memory mode. i have seen the pci bus transactions, its
>>generating memory read and memory write commands. but due to some reason
>>that is still *unknown* to me generates master abort. i always get master
>>received master abort. could you tell me what could be the reason?
>>
>>
>>_________________________________________________________
>>Do You Yahoo!?
>>Get your free @yahoo.com address at http://mail.yahoo.com
>
>Regards
>            Zhang Fuxin
>            fxzhang@ict.ac.cn
>
>
>_________________________________________________________
>Do You Yahoo!?
>Get your free @yahoo.com address at http://mail.yahoo.com

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
