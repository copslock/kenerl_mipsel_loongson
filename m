Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2QACLx12918
	for linux-mips-outgoing; Tue, 26 Mar 2002 02:12:21 -0800
Received: from ms45.hinet.net (root@ms45.hinet.net [168.95.4.45])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2QACDq12912
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 02:12:13 -0800
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by ms45.hinet.net (8.8.8/8.8.8) with SMTP id SAA06600;
	Tue, 26 Mar 2002 18:13:42 +0800 (CST)
From: "Y.H. Ku" <iskoo@ms45.hinet.net>
To: "Jun Sun" <jsun@mvista.com>
Cc: "Marc Karasek" <marc_karasek@ivivity.com>, <linux-mips@oss.sgi.com>
Subject: RE: BootLoader on MIPS
Date: Tue, 26 Mar 2002 18:09:13 +0800
Message-ID: <NGBBILOAMLLIJMLIOCADOENICCAA.iskoo@ms45.hinet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3C9FAEB5.2070201@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Importance: Normal
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g2QACEq12913
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ya,
I have traced the PMON code (www.carmel.com/pmon/) with NEC DDB5476 board (linux package from Montavista),
(LSI Logic' Software Support Package for MIPS processors version 5.3.33)

However, though it seem clear that function "_go" of pmon/head.S transfer control to client program
by "j k0" (a exception)
BUT I do not understand what information tha PMON transfer to LINUX-MIPS KERNEL
I found the KERNEL's entry is "kernel_entry" of ~arch/mips/kernel/head.S.
But, I can not find any information just like "board information" be transferred well.
where is it!? using sp register with "j k0" command?
where is the memory setting be transferred?
What MIPS LINUX needed!?
(PPCBOOT to PPC-LINUX is clear with a board_info struct, initrd_start and initrd_end ... and work well...

REALLY thanks for help,
--Ku






-----Original Message-----
From: owner-linux-mips@oss.sgi.com
[mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Jun Sun
Sent: Tuesday, March 26, 2002 7:12 AM
To: Y.H. Ku
Cc: Marc Karasek; linux-mips@oss.sgi.com
Subject: Re: BootLoader on MIPS


Y.H. Ku wrote:

> Hi everybody,
> 
> I trace PMON into mips.S, and find the entry "_go".
> the entry transfer control to client prog.
> 
> I am confused of what information PMON transfer to MIPS's BOOTLOADER
> and transfer to which entry point of BOOTLOADER.
> 
> I found the bd_t struct of PPCBOOT.h for PPCBOOT package on POWERPC platform.
> It is corresponding POWERPC-LINUX data structure bd_info in ~/include/asm/mbx.h 
> (register r3~r7)
> 
> I just can not find the entry for MIPS's one. (can not find corresponding baget.h's one)
> 
> Could anybody tell me what is the information (register inforation) PMON transfer
> to bootloader?
> 
> Or anybody can disscuss with me,
> 


NEC provides PMON for DDB5476.  You should be able to get it if it is not
already on the board.

Jun
