Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3PCU6wJ024755
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 05:30:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3PCU6AD024754
	for linux-mips-outgoing; Thu, 25 Apr 2002 05:30:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3PCTswJ024735
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 05:29:54 -0700
Message-Id: <200204251229.g3PCTswJ024735@oss.sgi.com>
Received: (qmail 5861 invoked from network); 25 Apr 2002 12:27:01 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 25 Apr 2002 12:27:01 -0000
Date: Thu, 25 Apr 2002 20:29:54 +0800
From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
To: "GIRISH V. GULAWANI" <girishvg@yahoo.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: vga initialization
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g3PCTtwJ024742
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

 I met the situation you described before.
x86emu0.6 will give such result on many cards.
I believe it's because their bioses access vga
memory between address [0xa0000-0xc0000],while
in x86emu0.6, the mem_read/mem_write doesn't
distinguish they from bios code section.
 
 I guess that your code:
  1. copy bios code to PHYSICAL MEMORY 0xc0000
  2. emulation code,and redirect accesses to
    [0xa0000-0xfffff] to PHYSICAL memory 0xa0000-0xfffff
  3. code ok,vga memory access failed. Because pci addr
    !=physical addr in your platform

x86emu-0.8 solve this.

Another caution please,the original code may define 
 #define char u8
and your compiler might treat 'char' as unsigned!At
least my sde-gcc from algor seems to do this.it will
lead to failure of 'JB' emulation.


	

======= 2002-04-25 03:14:00 ÄúÔÚÀ´ÐÅÖÐÐ´µÀ£º=======

>thanks for replying. this card PT80 seems a SPECIAL
>one. perhaps i am the only user for it on non-x86
>platform. 
>
>>   1. what you do
>i borrowed an old MIPS board from my company. from
>home i'm learning MIPS as well as linux. 
>
>>   2. output (dmesg,or captured from your serial
>> console).
>i've NOT used your particular code. somebody gave me a
>PMON code which has SciTech's bios emulation code. 
>i've integrated this code as part of bootloader. i
>dont see any dmesg or something.
>
>>   3. your platform,esp. whether it has pc legacy
>> hardware support.
>the board has a custom PCI bridge with 2 PCI slots.
>the PCI slots are 3.3v. i'm trying to port linux 2.4.3
>on this board. so far i'm able to build kernel with
>serial console. in order to support x-windows i need
>VGA monitor. hence i purchased one AOpen's PT80 card
>which supports PCI 3.3v. i was trying to emulate the
>BIOS. since it has only x86 bios. 
>
>in my case, the emulation as such completes. with no
>errors at any time. the monitor switches from power
>down to power on mode & also appears there AOpen's
>splash window. the one comes initially with AOpen's
>icon & some text explaining the card configuration.
>HOWEVER this whole screen is filled with colorful
>vertical lines. that's it & i'm stucked. 
>
>since i dont have any tools like PCI bus analyzer or
>something. so i have no clue to proceed further. i
>have checked the card & also the monitor. it works
>well on a PC running both windows-me & redhat linux
>7.1. 
>
>one thing i checked however is, an user command build
>on linux dumps the register access. the register
>access & the values written there or read from are
>ditto. exact match.
>
>could you make out anything from this?? any clues??
>
>many thanks & best regards,
>girish.
>
><<snip>>
>
>__________________________________________________
>Do You Yahoo!?
>Yahoo! Games - play chess, backgammon, pool and more
>http://games.yahoo.com/

= = = = = = = = = = = = = = = = = = = =
			

¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡ÖÂ
Àñ£¡
 
				 
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡Zhang Fuxin
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡fxzhang@ict.ac.cn
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡2002-04-25
