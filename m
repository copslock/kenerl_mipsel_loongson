Received:  by oss.sgi.com id <S42212AbQGNOGM>;
	Fri, 14 Jul 2000 07:06:12 -0700
Received: from [207.81.221.34] ([207.81.221.34]:11628 "EHLO mail.vcubed.com")
	by oss.sgi.com with ESMTP id <S42205AbQGNOGH>;
	Fri, 14 Jul 2000 07:06:07 -0700
Received: from vcubed.com ([207.81.96.153])
	by mail.vcubed.com (8.8.7/8.8.7) with ESMTP id KAA31764;
	Fri, 14 Jul 2000 10:24:16 -0400
Message-ID: <396F2300.62BA77B@vcubed.com>
Date:   Fri, 14 Jul 2000 10:26:08 -0400
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     erik.niessen@philips.com
CC:     linux-mips@oss.sgi.com
Subject: Re: Graphics on a mips-board
References: <0056890012369098000002L982*@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello Erik,

I have used the VGA16 framebuffer with several PCI VGA adapters.

The mapped address of 0xa00a0000 is very likely wrong.  The driver
is trying to access the framebuffer at the physical address of
0x000a0000.

If you are using a PCI based VGA chip and the linux kernel from
the SGI sources then the mapping will be wrong because the kernel
assumes a 1 to 1 mapping of PCI memory space and it doesn't map
the first megabyte of PCI memory space.  The problem is in the
ioremap function and the way that PCI memory space is mapped.

If you use the sources from the ftp.mips.com then you can get a
mapping that will allow access to the first megabyte of PCI memory.
The ioremap function in those sources is in my opinion is much
better.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.


erik.niessen@philips.com wrote:
> 
> Hello,
> 
> I have the ide-controller running on my mips-board. My next step will be to get some graphics out of this box. On the board is an onboard graphics chip and according to the specs it is VGA compatible.
> 
> I am using the serial-console for debugging and for sending characters to the box. My source tree is based on kernel 2.2.12.
> 
> Because the chip is VGA compatible I try to get the VGA16 framebuffer running on the box. After enabling the VGA16 framebuffer I receive the following output:
> 
> Jumping to image at 800605DCh...
> Detected 16MB of memory.
> Loading R4000/MIPS32 MMU routines.
> CPU revision is: 000028a0
> Primary instruction cache 32kb, linesize 32 bytes
> Primary data cache 32kb, linesize 32 bytes
> Linux version 2.2.12 (eniessen@psvcas16) (gcc version egcs-2.90.29 980515 (egcs-
> 1.0.3 release)) #10 Thu Jul 13 13:45:19 PDT 2000
> calculating r4koff... 000f4240(1000000)
> CPU frequency 200.00 MHz
> Console: colour VGA+ 80x50
> Calibrating delay loop... 199.88 BogoMIPS
> Memory: 12652k/16380k available (616k kernel code, 2724k data)
> Checking for 'wait' instruction...  available.
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Found SAA9730 at b2800000
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v 1.1.1.1
> vga16fb: initializing
> vga16fb: mapped to 0xa00a0000
> Console: switching to colour frame buffer device 80x30
> 
> It is doing the take_over_console but when I check the output of my VGA-connector there is no signal. Someone an idea how I can debug this???
> 
> Has somebody any experience with framebuffers on a mips?
> 
> Any hints/links/tips would be welcome,
> 
> Thanks for your time,
> 
>         Erik
