Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 10:11:00 +0100 (BST)
Received: from bay18-f5.bay18.hotmail.com ([65.54.187.55]:31865 "EHLO
	hotmail.com") by ftp.linux-mips.org with ESMTP id S8133532AbWEDJKr
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 10:10:47 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 4 May 2006 02:10:37 -0700
Message-ID: <BAY18-F5B011E1AD8FC316E77126ADB40@phx.gbl>
Received: from 220.247.245.66 by by18fd.bay18.hotmail.msn.com with HTTP;
	Thu, 04 May 2006 09:10:34 GMT
X-Originating-IP: [220.247.245.66]
X-Originating-Email: [safiudeen@hotmail.com]
X-Sender: safiudeen@hotmail.com
In-Reply-To: <20060504065657.GI11097@dusktilldawn.nl>
From:	"safiudeen Ts" <safiudeen@hotmail.com>
To:	freddy@dusktilldawn.nl, linux-mips@linux-mips.org
Subject: Re: Linux-2.6.16 on DB1100
Date:	Thu, 04 May 2006 09:10:34 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 04 May 2006 09:10:37.0199 (UTC) FILETIME=[9B6D01F0:01C66F5A]
Return-Path: <safiudeen@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi ,
Here is the original  output from minicom.
------------------------------------------------------------

YAMON ROM Monitor, Revision 02.19DB1100.
Copyright (c) 1999-2000 MIPS Technologies, Inc. - All Rights Reserved.

For a list of available commands, type 'help'.

Compilation time =            Oct 18 2005  11:09:13
MAC address =                 00.00.1a.18.d4.d4
Processor Company ID =        0x03
Processor ID/revision =       0x02 / 0x04
Endianness =                  Little
CPU =                         396 MHz
Flash memory size =           32 MByte
SDRAM size =                  64 MByte
First free SDRAM address =    0x8008d314

Environment variable 'start' exists. After 2 seconds
it will be interpreted as a YAMON command and executed.
Press Ctrl-C to bypass this.

About to load tftp://192.168.0.5//tftpboot/vmlinux.srec
Press Ctrl-C to break
........................................
........................................
........................................
........................................
........................................
........................................
........................................
..............................
Start = 0x8034f000, range = (0x80100000,0x8036e084), format = SREC

-----------------------------------------------------------

After above message there are no any messagess were displayed.
It look like kernel hang somewhere before doing the serial UART0 
initialization.
I  put fiew code  like setting GPIO18 to high and low in preodically to see 
whether the kernel is running, but there were no change in the state of 
GPIO18.

Followings are the Yamon enviremnt variables
-----------------------------------------------------------------
YAMON> setenv

MAC         (R/W)  0
bootfile    (R/W)  /tftpboot/vmlinux.srec
bootprot    (R/W)  tftp
bootser     (USER) 192.168.0.5
bootserport (R/W)  tty0
bootserver  (R/W)  192.168.0.5
ethaddr     (R/W)  00.00.1a.18.d4.d4
gateway     (R/W)  0.0.0.0
ipaddr      (R/W)  192.168.0.42
memsize     (RO)   0x04000000
modetty0    (R/W)  115200,n,8,1,none
modetty1    (R/W)  115200,n,8,1,none
prompt      (R/W)  YAMON
start       (R/W)  load; go . ip=192.168.0.42:192.168.0.5::::eth0:
subnetmask  (R/W)  255.255.255.0

YAMON>
-----------------------------------------------------------------

please tell me wether I should apply any patches to this Linux-2.6.16 kernel 
to make it works with db1100

I have tested db1100 board with linux-2.4.20 in the same way there it works 
fine.
I want to move to linux-2.6.
please suggest me any good working linux-2.6 kernel release  with db1100.


Thanx
Safiudeen

>From: Freddy Spierenburg <freddy@dusktilldawn.nl>
>To: safiudeen Ts <safiudeen@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: Linux-2.6.16 on DB1100
>Date: Thu, 4 May 2006 08:56:57 +0200
>
>Hi Safiudeen,
>
>On Thu, May 04, 2006 at 06:31:08AM +0000, safiudeen Ts wrote:
> > About to load tftp://192.168.0.3//tftpboot/vmlinux.srec
> > Press Ctrl-C to break
> > 
>...............................................................................
> > 
>..................................................................................
> > 
>................................................................................
> >
> > Start = 0x8034f000, range = ( 0x80100000,0x8036e084 )
>There is some vital information missing from your email. Can you
>also send the yamon command's you use to start the system. Like for
>instance the output below is far more complete than yours. I have put some
>extra comment in between '->' and '<-' to give you an idea what is 
>happening.
>
>-> Here yamon starts and shows some general information <-
>
>		YAMON ROM Monitor, Revision 02.27GDB1100.
>		Copyright (c) 1999-2004 MIPS Technologies, Inc. - All Rights Reserved.
>
>		For a list of available commands, type 'help'.
>
>		Switch S1.1 selects endian.
>
>		Compilation time =            Jan  1 2000  00:00:35
>		MAC address =                 00.00.00.00.00.00
>		Processor Company ID =        0x03
>		Processor ID/revision =       0x02 / 0x04
>		Endianness =                  Little
>		CPU =                         396 MHz
>		Flash memory size =           64 MByte
>		SDRAM size =                  192 MByte
>		First free SDRAM address =    0x800a66ec
>
>-> Here you can see me loading the kernel image by means of tftp from my 
>tftp-server. <-
>
>		YAMON> load tftp://192.168.10.136/vmlinux-2.6.16-20060418.000.srec
>		About to load tftp://192.168.10.136/vmlinux-2.6.16-20060418.000.srec
>		Press Ctrl-C to break
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		........................................
>		..................
>		Start = 0x80473000, range = (0x80100000,0x80498085), format = SREC
>
>-> Here you can see me starting the kernel image, which uses a
>    root filesystem from my nfs-server <-
>
>		YAMON> go . ip=192.168.10.236 nfsroot=192.168.10.136:\
>		? /opt/cellar0/AMD.Alchemy/test.20060202/root/ rw
>
>-> Here you can see my kernel starting <-
>
>		Linux version 2.6.16 (frsp@id6236) (gcc version 3.4.6 20060122 
>(prerelease) (Debian 3.4.5-2)) #20 PREEMPT Tue Apr 18 10:59:57 CEST 2006
>		CPU revision is: 02030204
>		AMD Alchemy Au1100/Db1100 Board
>		(PRId 02030204) @ 396MHZ
>		BCLK switching enabled!
>		Determined physical RAM map:
>		 memory: 0c000000 @ 00000000 (usable)
>		Built 1 zonelists
>		Kernel command line: ip=192.168.10.236 
>nfsroot=192.168.10.136:/opt/cellar0/AMD.Alchemy/test.20060202/root/ rw 
>console=ttyS0,115200
>
>-> I have cut out the rest for brevity <-
>
>So there can be two things:
>
>	a) You forgot to start the loaded kernel. (this I can't tell
>	from your output, so please make it more verbose)
>
>	b) Can it be that you have disabled CONFIG_PRINTK in the kernel
>	configuration???
>
>--
>$ cat ~/.signature
>Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
>GnuPG: 0x7941D1E1=C948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
>$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!


><< signature.asc >>

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
