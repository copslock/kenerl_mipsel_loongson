Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 17:36:15 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30962 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTB0RgO>;
	Thu, 27 Feb 2003 17:36:14 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1RHa7P13296;
	Thu, 27 Feb 2003 09:36:07 -0800
Date: Thu, 27 Feb 2003 09:36:07 -0800
From: Jun Sun <jsun@mvista.com>
To: ZhouY.external@infineon.com
Cc: ncrook@micron.com, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: MIPS Malta board Linux installation
Message-ID: <20030227093607.F24501@mvista.com>
References: <3A5A80BF651115469CA99C8928706CB603D7B303@mucse004.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5A80BF651115469CA99C8928706CB603D7B303@mucse004.eu.infineon.com>; from ZhouY.external@infineon.com on Thu, Feb 27, 2003 at 05:44:07PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I just compiled and tested on Malta board a couple of days ago
by using linux-mips.org linux_2_4 CVS tree.  It worked fine.
Given the new defconfig I checked in, you only need the 
following command line (assuming you have dhcp with bootp setup
on your host):

	go . ip=any

Jun

On Thu, Feb 27, 2003 at 05:44:07PM +0100, ZhouY.external@infineon.com wrote:
> I tried again. The result is same. 
> The green LED display shows 'LINUX' not 'LINUX on malta'. All the status LED
> are green except the LED rst is off. There are 2 kernel images(el and eb),
> one of them is vmlinux-2.2.12.mips.malta.eb-01.05.srec, which is the current
> one. I double checked my console and its baud rate is 38400. 
>   From this symptom, what kind of conclusion can you draw?
> 
>   Best regards,
> 
>   Yidan
> 
> -----Ursprüngliche Nachricht-----
> Von: ncrook [mailto:ncrook@micron.com]
> Gesendet am: Donnerstag, 27. Februar 2003 17:25
> An: Zhou Yidan (COM AC CE M external)
> Betreff: RE: MIPS Malta board Linux installation 
> 
> Hmm, well, for a start, you can just boot like this:
> 
> go . console=ttyS0,38400
> 
> .. your boot isn't getting anywhere near far enough to care
> about IP addresses and nfs root disks; Once you get far
> enough to see a message about "attempting to mount root
> file system" then you can start worrying about ip and nfsroot
> arguments.
> 
> ..take a look at the green 8-character display (U42). If it
> is scrolling the text "linux on malta" then the kernel is
> almost certainly up and running, and I would suspect your
> serial port settings are wrong in your terminal emulator.
> If not, check you're using a big-endian kernel for a malta.
> 
> that's all I can think of. Happy hunting
> 
> Neal.
> 
> 
> -----Original Message-----
> From: ZhouY.external@infineon.com [mailto:ZhouY.external@infineon.com]
> Sent: 27 February 2003 16:03
> To: ncrook@micron.com
> Subject: AW: MIPS Malta board Linux installation 
> 
> 
> Hi Neal,
>   First, thanks a lot!
>   Second, I tried as you mentioned, but the result is still same--screens of
> rubbish characters.
> 
>   Any other solutions? 
> 
>   Best regards,
>   Yidan 
> 
> -----Ursprüngliche Nachricht-----
> Von: ncrook [mailto:ncrook@micron.com]
> Gesendet am: Donnerstag, 27. Februar 2003 16:36
> An: Zhou Yidan (COM AC CE M external)
> Betreff: RE: MIPS Malta board Linux installation 
> 
> 
> >>Start = 0x80100608, range = (0x80100000,0x8024015f), format = SREC
> >>YAMON> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
> >>
> >>LINUX started...
> >>EURfÐñoeíï>ßüÿû_ÿÿö~ÿÿ¿ßÿë¬RÿßïþëÿÛþïùúßm»>ÿÿÿûÿë®Þýí}®¿ùýoÞ÷ÿï?mÿêó¯Íëýïÿ
> ³ÿ
> >>ÿÝûïî¯÷ÿïÿûÿÏÿÿ¿¯ÿý»ºÿgÿ¿ÿ~ÿÿßþÿûþêþÿ÷ÿÿïÿê÷×¢ÿh«Ïÿßýïÿÿþûÿÿýûÿ{ÿ®ÿÿÿÿß÷/ó
> ÿí
> 
> 
> looks like your serial port baud rate is wrong. At some stage, the
> current setting (left by YAMON) gets overwritten by UART setup in 
> Linux. Try changing:
> 
> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
> 
> to:
> 
> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116
> console=ttyS0,38400
> 
> (38400 is the baud rate.. use the value you want)
> 
> Just my guess.. worth as much as you paid for it!!
> 
> Neal.
> 
