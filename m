Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HD7hY18701
	for linux-mips-outgoing; Tue, 17 Jul 2001 06:07:43 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HD7fV18697
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 06:07:41 -0700
Message-Id: <200107171307.f6HD7fV18697@oss.sgi.com>
Received: (qmail 32133 invoked from network); 17 Jul 2001 13:02:13 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 17 Jul 2001 13:02:13 -0000
Date: Thu, 19 Jul 2001 21:41:5 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: help on linux-mipsel frame buffer
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,linux-mips gurus
   Recently I am trying to make frame buffer work on my P6032 board
(from Algorithmics).I have a cirrus logic 5430,a RIVA TNT2 and a
Trident 3dImage9750 on hand.The linux kernel I am using is 2.2.14
(  mipsel 1.05? modified by Algorithmics. 
   BTW,could someone tell me how to access the mips tree and 
   what the version scheme for mipsel? I read the mips-howto.
   but although i can login to the cvs server of oss.sgi.com
   i could not find out where is the kernel. "cvs get linux"
   responded with "cannot find module 'linux'"
   I am new to mips world.
) 
and the distribution is Hardhat downloaded from oss.sgi.com
  First I try the vga16 frame buffer driver,but i can only get
some black/white strips on the screen.(after made some changes 
to the source,most important one is use pci to find and set the
vbase address). I can use tty driver,because I can switch consoles
using alt-f? on the keyboard attached to the board and even login 
and reboot the machine: just no readable display.
  Then I try to use vesa driver. This one use some vgabios code 
I commented out the x86 relevant codes and made it compiled,(again
use pci_find_device to find video memory address,and tweak the make
file to force vgacon use vesa driver). But the result is a blank 
screen.The fb driver is certainly on: I can copy to/from /dev/fb0.
but with no visual effect.
  Finally I back port the Riva TNT frame buffer code to 2.2,the result
is the same as the vesa driver.

  I suspect that the pci memory map is somewhat broken,but I checked
the source code and the bonito(P6032 north bridge) manual and found 
no obvious flaw.

  Where could i be wrong?Is there anybody has some experience with
frame buffer for mips?

  Any help will be great appreciated.

   



Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
